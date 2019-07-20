class AddPushEndpointToPatients < ActiveRecord::Migration[5.0]
  def change
    add_column :patients, :push_endpoint, :string
  end
end
