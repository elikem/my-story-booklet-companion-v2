Rails.application.routes.draw do
  post "publish-idml-publication" => "publications#create_idml_publication"
end
