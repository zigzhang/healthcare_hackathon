class PatientController < ApplicationController

  def index
    @patient = Patient.find params[:id]
    @sponsor = @patient.site.sponsor
    render json: {status: "success", data: @sponsor}
  end

end
