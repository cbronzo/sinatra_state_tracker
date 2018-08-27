class CreateStates < ActiveRecord::Migration
  def change

    create_table :states do |t|
      t.string :state_name
      t.string :abbreviation
    end
  end
end
