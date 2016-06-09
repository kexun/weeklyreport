# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

get 'weeklyreports', :to => 'weeklyreports#index'
get 'weeklyreports/new', :to => 'weeklyreports#new'

get 'weeklyreports/find_by_date', :to => 'weeklyreports#find_by_date'
resources :weeklyreports