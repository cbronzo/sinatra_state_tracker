class CreateUserStates < ActiveRecord::Migration[4.2]
  def change
   create_table :user_states do |t|
     t.integer :user_id
     t.integer :state_id
     t.string :memory
   end
 end
end
