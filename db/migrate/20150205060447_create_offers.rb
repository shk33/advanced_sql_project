class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.references :user, index: true
      t.references :service_request, index: true
      t.boolean    :accepted, default: false

      t.timestamps
    end
  end
end
