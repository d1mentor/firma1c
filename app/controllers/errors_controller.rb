class ErrorsController < ApplicationController
  def not_found
    redirect_to "/404"
  end
end
