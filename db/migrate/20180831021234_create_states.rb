class CreateStates < ActiveRecord::Migration[4.2]
  def change
   create_table :states do |t|
     t.string :state_name
   end
 end
end
