require 'rails_helper'

describe UsersController do
  it 'is kind of Admin::BaseController' do
    expect(controller).to be_kind_of Admin::BaseController
  end
end
