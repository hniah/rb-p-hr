class UsersController < Admin::BaseController
  before_filter :authenticate_user!
end
