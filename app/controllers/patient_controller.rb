class PatientController < ApplicationController

  def show
    @patient = Patient.find params[:id]
    @sponsor = @patient.site.sponsor
    render json: {status: "success", data: @sponsor}
  end

end
