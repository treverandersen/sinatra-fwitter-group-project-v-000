require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

require_relative 'app/controller/tweets_controller'
require_relative 'app/controller/users_controller'

use Rack::MethodOverride

use TweetsController 
use UsersController
run ApplicationController
