Rails.application.routes.draw do
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

	root  'homes#index'
	resources :homes

	get 'batting_csv', to: "homes#batting_csv"
	get 'teams_csv',   to: "homes#teams_csv"

	post 'import_batting_csv', to: "homes#import_batting_csv"
	post 'import_teams_csv',   to: "homes#import_teams_csv"
end
