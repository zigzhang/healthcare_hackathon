class PatientController < ApplicationController
  require 'rqrcode'

  def show
    @patient = Patient.find params[:id]
    @sponsor = @patient.site.sponsor
    render json: {status: "success", data: @sponsor}
  end

  def qrcode
    @qr = RQRCode::QRCode.new( 'http://10.10.93.245/'+params[:id]+'/index', :size => 4, :level => :h )
  end

end
