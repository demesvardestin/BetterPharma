class AddSubscriptionDetailsToPharmacies < ActiveRecord::Migration[5.0]
  def change
    add_column :pharmacies, :subscription_auth, :string
    add_column :pharmacies, :subscription_p256dh, :string
    add_column :pharmacies, :promotional_email_notifications, :boolean, default: true
    add_column :pharmacies, :subscribed_to_push_notifications, :boolean, default: false
  end
end
