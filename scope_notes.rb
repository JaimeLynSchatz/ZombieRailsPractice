class RottingZombiesController < ApplicationController

  def index
    @rotting_zombies - Zombie.rotting
    ...
  end

end

class Zombie < ActiveRecord::Base

	scope :rotting, where(rotting: true)
	scope :fresh, where("age, < 20")
	scope :recent, order("created_at desc").limit(3)

end

class Zombie < ActiveRecord::Base

	before_save :make_rotting

	def make_rotting
		self.rotting = true if age < 20
	end

end

class Brain < ActiveRecord::Base

	before_save :taste

	def taste
		return false // this will halt the save!!
	end

end

class Brain < ActiveRecord::Base
	belongs_to :zombie
end

class Zombie < ActiveRecord::Base
	has_one :brain, dependent: :destroy // keeps the brain linked to the zombie
	has_many :roles, through: :assignments S
end

z = Zombie.find(1)
Brain.find(1)
z.destroy
Brain.find(1) // that brain will still exist

def index
	@zombie = Zombie.includes(:brain).all
end

class CreateAssignements < ...
	def change
		create_table :assignements do |t|
			t.integer :zombie_id
			t.integer :role_id
		end
		add_index :assignments, :zombie_id
		add_index :assignements, :role_id
	end
end

class CreateRoles < ...
	def change
		create_table :roles do |t|
			t.string :title
		end
	end
end






