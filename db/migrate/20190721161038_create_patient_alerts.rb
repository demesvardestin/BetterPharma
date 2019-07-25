class CreatePatientAlerts < ActiveRecord::Migration[5.0]
  def change
    create_table :patient_alerts do |t|
      t.string :alert_type
      t.string :notification_endpoint
      t.integer :pharmacy_id
      t.string :evaluation_number
      t.boolean :resolved, default: false
      t.string :status

      t.timestamps
    end
  end
end
