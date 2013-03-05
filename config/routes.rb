RefactorIt::Application.routes.draw do
  root :to => 'home#index'
  match 'login' => 'home#login'
  match 'show_original_code' => 'home#show_original_code'
  match 'submit_refactored_code' => 'home#submit_refactored_code'
  match 'list_refactored_code' => 'home#list_refactored_code'
  match 'rate' => 'home#rate'
  match 'comment' => 'home#comment'
end
