class CreatePermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :permissions do |t|
      t.string :resource
      t.string :action
      t.references :role, foreign_key: true

      t.timestamps
    end
  end
end
