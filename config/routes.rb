Rails.application.routes.draw do
  post "publish-idml-publication" => "publications#create_idml_publication"
  get "new-pdf-alert" => "publications#new_pdf_alert"

  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"
end
