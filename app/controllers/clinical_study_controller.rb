
class ClinicalStudyController < ApplicationController
  def index
    @clinical_studies = ClinicalStudy.all
    render json: {status: "success", data: @clinical_studies}
  end
  
  def show
    @clinical_study = ClinicalStudy.find params[:id]
    @assessment = @clinical_study.assessment
    render json: {status: "success", data: @assessment}
  end

  def create
  	@sponsor=current_user
  	@clinical_study = ClinicalStudy.new(:sponsor_id => @sponsor.name, :name => params[:id])
  	render json: {status: "success", data: @clinical_study}

  end
  
end
