class ParticipantsController < ApplicationController
  def index
    @participants = current_site.participants.published.order_by_recent.page(params[:page])
    @participants.extend(ParticipantsDecorator)
  end

  def show
    @participant = current_site.participants.find(params[:id])
    @posts = @participant.posts.published.order_by_recent.page(params[:page])

    @posts.extend(PaginationInfoDecorator)
  end
end
