class AddCanceledToServiceArrangements < ActiveRecord::Migration
  def change
    add_column :service_arrangements, :canceled, :boolean, default: false
  end
end
