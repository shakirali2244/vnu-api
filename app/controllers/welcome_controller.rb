class WelcomeController < ApplicationController
  def index
  	@spaces = Space.all
  end
end
