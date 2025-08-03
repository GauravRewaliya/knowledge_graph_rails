# commands

bundle exec rspec spec/integration


RAILS_ENV=test bundle exec rspec spec/integration

RAILS_ENV=test bundle exec rake rswag:specs:swaggerize


# done 
rails generate scaffold Chatgpt name:string desc:text auth_token:string meta_data:json last_used_at:datetime workspace:references

rails generate scaffold ChatSession name:string desc:text external_id:string meta_data:json last_used_at:datetime chatgpt:references workspace:references

bundle add hashid-rails