class AddDivisionToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :division, :string
  end
end
