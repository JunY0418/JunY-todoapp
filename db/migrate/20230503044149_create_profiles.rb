class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false
      t.string :name
      t.string :division
      t.text :description
      t.boolean :subscribed, defauls: false
      t.timestamps
    end
  end
end
