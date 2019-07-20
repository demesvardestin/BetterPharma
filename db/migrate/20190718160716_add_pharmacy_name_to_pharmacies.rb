class AddPharmacyNameToPharmacies < ActiveRecord::Migration[5.0]
  def change
    add_column :pharmacies, :pharmacy_name, :string
    add_column :pharmacies, :pharmacy_owner_first_name, :string
    add_column :pharmacies, :pharmacy_owner_last_name, :string
    add_column :pharmacies, :pharmacy_phone_number, :string
  end
end
