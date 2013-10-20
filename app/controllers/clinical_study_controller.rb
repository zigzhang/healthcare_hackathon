
class ClinicalStudyController < ApplicationController
  def index
    @clinical_studies = ClinicalStudy.all
    respond_to do |format|
      format.html { render action: 'index' }
    end
  end
  
  def show
    @clinical_study = ClinicalStudy.find params[:id]
    @site = Protocole.where(clinical_study: params[:id])
    @assessment = @clinical_study.assessments
    respond_to do |format|
      format.html { render action: 'show' }
      format.json {render status: "success", data: @assessment}
    end
    
  end

  def create
  	@sponsor=current_user
  	@clinical_study = ClinicalStudy.new(:sponsor_id => @sponsor.name, :name => params[:id])
  	render json: {status: "success", data: @clinical_study}

  end
  
end
