class EscortRecordsController < ApplicationController
  def create
    redirect_to identification_path(EscortRecord.create)
  end
end
