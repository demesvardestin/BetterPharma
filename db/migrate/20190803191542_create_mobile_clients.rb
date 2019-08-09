class CreateMobileClients < ActiveRecord::Migration[5.0]
  def change
    create_table :mobile_clients do |t|
      t.string :subscription_auth
      t.string :subscription_p256dh
      t.boolean :subscribed_to_push_notifications, default: false

      t.timestamps
    end
  end
end
