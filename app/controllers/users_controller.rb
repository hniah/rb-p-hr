class UsersController < AdminsController
  before_filter :authenticate_user!
end
