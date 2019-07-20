class PharmaciesController < ApplicationController
  before_action :set_pharmacy
  
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
  
  private
  
  def set_pharmacy
    @pharmacy = current_pharmacy
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
