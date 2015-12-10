class CreateServiceRequests < ActiveRecord::Migration
  def change
    create_table :service_requests do |t|
      t.references :user, index: true
      t.boolean    :open, default: true
      t.timestamps
    end
  end
end
