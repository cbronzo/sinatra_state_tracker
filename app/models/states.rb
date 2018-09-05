class State < ActiveRecord::Base
  has_many :user_states
  has_many :users, through: :user_states



end
