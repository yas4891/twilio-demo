Twilio::Application.routes.draw do
  
  
  resources :sms do
    collection do
      get 'incoming'
    end
  end

  resources :calls do
    member do
      post 'gather'
      get 'gather'
      post 'twiml'
      get 'twiml'
      post 'recording'
      get 'recording'
      post 'transcribe'
    end
    collection do
      get 'update_calls'
      
    end
  end

  get "welcome/index"

  resources :outgoing_caller_ids do
    member do
      post 'status_update'
      get 'status_update'
    end
  end

  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
