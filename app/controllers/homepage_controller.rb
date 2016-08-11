class HomepageController < ApplicationController
  def index
    if(client_signed_in?)
      redirect_to '/dashboard/index'
    end
  end
end
