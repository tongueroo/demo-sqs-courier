class CreateDeliveries < ActiveRecord::Migration[7.0]
  def change
    create_table :deliveries do |t|
      t.string :message, null: false

      t.timestamps index: true
    end
  end
end
