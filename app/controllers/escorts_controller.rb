class EscortsController < ApplicationController
  def create
    redirect_to identification_path(Escort.create)
  end
end
