Rails.application.routes.draw do
  match 'ping'         => 'toolss#ping',           as: :ping, via: :all
  root 'pages#index'
end
