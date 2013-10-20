class PatientController < ApplicationController
  require 'rqrcode'

  def show
    @patient = Patient.find(params[:id])
    render json: {status: "success", data: {patient: @patient, protocole:  @patient.protocole, clinical_study: @patient.protocole.clinical_study,
                                           assessments: @patient.protocole.assessments }}
  end

  def qrcode
    @qr = RQRCode::QRCode.new( '/'+params[:id]+'/index', :size => 4, :level => :h )
  end

  def create
  	@clinical_study= ClinicalStudy.all
  	@protocole_id = params[:protocole_id]
  	@site_id = current_user.site_id
  	@patient = Patient.new(:protocole_id => @protocole_id, :site_id => @site_id)
end
