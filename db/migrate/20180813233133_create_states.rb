class CreateStates < ActiveRecord::Migration
  def change

    create_table :states do |t|
      t.string :name
      t.string :region
      t.string :abbreviation
    end
  end
end
