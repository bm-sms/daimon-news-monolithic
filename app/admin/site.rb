ActiveAdmin.register Site do
  attrs = %i(
    name
    js_url
    css_url
    fqdn
    tagline
    description
    logo_url
    favicon_url
    mobile_favicon_url
    gtm_id
    content_header_url
    promotion_url
    sns_share_caption
    twitter_account
    ad_client
    ad_slot
    menu_url
    home_url
    footer_url
  )

  permit_params(*attrs)

  form do |f|
    f.semantic_errors
    f.inputs(*attrs)

    f.actions
  end

  actions :all, except: :destroy
end
