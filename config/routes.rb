Rails.application.routes.draw do
  root "pages#index"
  post "publish-idml-publication" => "publications#download_idml_publication"
  get "new-pdf-alert" => "publications#new_pdf_alert"
  get "publications/:id/pdf" => "publications#show_pdf"

  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"
end
