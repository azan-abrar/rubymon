class Monster < ActiveRecord::Base
    validates_presence_of :name, :power, :monster_type
	belongs_to :user
end
