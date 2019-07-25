class Main::PharmaciesController < ApplicationController
  include Notifier
  before_action :set_pharmacy
  before_action :load_requests
  
  def dashboard
  end

  def edit
  end

  def update
    current_pharmacy.update pharmacy_params
    
    respond_to do |format|
      format.html { redirect_to :back, notice: "Changes saved!" }
    end
  end
  
  def status_requests
    @unresolved_requests = @patient_alerts.status_requests.unresolved
    @resolved_requests = @patient_alerts.status_requests.resolved
  end
  
  def refill_requests
    @unresolved_requests = @patient_alerts.refill_requests.unresolved
    @resolved_requests = @patient_alerts.refill_requests.resolved
  end
  
  def update_rx_status
    @alert = PatientAlert.find_by(evaluation_number: params[:eval_num])
    @alert.update(status: params[:status], resolved: true)
    
    respond_to do |format|
      format.js { render :layout => false, notice: "Update sent!" }
      
      ## send update
      Notifier.alert_mobile_client(@alert.notification_endpoint)
    end
  end
  
  def load_chart
    @period = params[:period]
    render :layout => false
  end
  
  private
  
  def set_pharmacy
    @pharmacy = current_pharmacy
  end
  
  def load_requests
    @pharmacy = set_pharmacy
    @patient_alerts = current_pharmacy.patient_alerts.order('created_at DESC')
  end
  
  def pharmacy_params
    params.require(:pharmacy)
    .permit(
      :pharmacy_name,
      :pharmacy_phone_number,
      :pharmacy_owner_first_name,
      :pharmacy_owner_last_name)
  end
end
