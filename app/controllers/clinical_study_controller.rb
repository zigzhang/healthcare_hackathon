
class ClinicalStudyController < ApplicationController
  def index
    @clinical_studies = ClinicalStudy.all
    @clinical_stats = Array.new
    @clinical_studies.each do |cs|
      @protocoles = cs.protocoles
      @countries = Array.new
      @count = Array.new
      @stats = [["Country", "Total Patients"]]
      @protocoles.each do |p|
        if @countries.index(p.patient.site.country).nil? 
          @countries.push(p.patient.site.country)
          @count.push(1)
        else
          @count[@countries.index(p.patient.site.country)] = @count[@countries.index(p.patient.site.country)] + 1
        end
        for i in 0..@countries.count-1 do
          @stats.push([@countries[i], @count[i]])
        end 
      end
      @clinical_stats.push([cs, @stats])
    end
    respond_to do |format|
      format.html { render action: 'index' }
    end
  end
  
  def show
    @clinical_study = ClinicalStudy.find params[:id]
    @protocoles = @clinical_study.protocoles
    @sites = Array.new
    @sites_id = Array.new
    @protocoles.each do |p|
      if @sites_id.include? p.patient.site.id
      else
        @sites.push(p.patient.site)
        @sites_id.push(p.patient.site.id)
      end
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
      end
      @sites_protocoles.push([s, [["State", "Total"], ["Pending", pending], ["Active", active], ["Done", done]]])

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
