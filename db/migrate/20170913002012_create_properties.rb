class CreateProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :properties do |t|
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :status, default: 'prospect'
      t.references :user, index: true
      t.text :notes, null: true
      t.timestamps
    end
  end
end
