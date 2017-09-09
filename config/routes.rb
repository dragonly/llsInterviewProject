Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :user
  post    '/login',               to: 'session#create'
  delete  '/login',               to: 'session#destroy'
  post    '/red_packet/issue',    to: 'red_packet#issue'
  post    '/red_packet/gamble',   to: 'red_packet#gamble'
  get     '/red_packet/list',     to: 'red_packet#list'
  get     '/red_packet/balance',  to: 'red_packet#balance'
end
