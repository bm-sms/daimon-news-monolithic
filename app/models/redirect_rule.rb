class RedirectRule < ActiveRecord::Base
  after_save :after_change
  after_destroy :after_change

  belongs_to :site

  validates :request_path, presence: true
  validates :request_path, uniqueness: {scope: :site_id}
  validates :destination, presence: true
  validate :request_path_has_query_string?
  validate :request_equal_destination?
  validate :redirect_loop?

  private

  def request_path_has_query_string?
    uri = URI.parse(request_path)
    errors.add(:request_path, "クエリパラメーターは含めることができません") if uri.query.present?
  end

  def request_equal_destination?
    errors.add(:destination, "リダイレクト元とリダイレクト先は同じにできません") if request_path == destination
  end

  def redirect_loop?
    redirect_rule = RedirectRule.find_by(request_path: destination, destination: request_path)
    if redirect_rule.present?
      errors.add(:destination, "リダイレクトループが発生する設定は追加できません") unless redirect_rule.id == id
    end
  end

  def after_change
    Rails.application.reload_routes!
  end
end
