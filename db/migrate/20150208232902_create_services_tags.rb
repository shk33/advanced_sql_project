class CreateServicesTags < ActiveRecord::Migration
  def change
    create_table :services_tags do |t|
      t.belongs_to :tag,     index: true
      t.belongs_to :service, index: true
    end
  end
end
