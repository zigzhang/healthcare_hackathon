
class ClinicalStudyController < ApplicationController
  def index
    @clinical_studies = ClinicalStudy.all
    respond_to do |format|
      format.html { render action: 'index' }
    end
  end
  
  def show
    @clinical_study = ClinicalStudy.find params[:id]
    @protocoles = @clinical_study.protocoles
    @sites = Array.new
    @protocoles.each do |p|
      @sites.push(p.patient.site)
    end
    @sites_stats = [["Site", "Number of Patients"]]
    @sites_protocoles = Array.new
    @sites.each do |s|
      @sites_stats.push([s.name, s.patients.count])
      pending = 0
      active = 0
      done = 0
      s.patients.each do |p|
        case p.protocole.state
        when "pending"
          pending = pending + 1
        when "active"
          active = active + 1
        when "done"
          done = done + 1
        end
        @sites_protocoles.push([s.name, [["State", "Total"], ["Pending", pending], ["Active", active], ["Done", done]]])
      end

    end
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
