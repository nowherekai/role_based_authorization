class CreateJoinTableUsersRoles < ActiveRecord::Migration[5.0]
  def change
    create_join_table :users, :roles do |t|
      t.index [:user_id, :role_id], unique: true
    end
  end
end
