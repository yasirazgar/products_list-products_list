class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  # add settings and configrations for api
end
