require './student.rb'
class Group

	def initialize
		@group = []
	end

	def add(student)
		@group << student
	end

	def print_group()
		@group.each  do |student|
			student.print
		end
	end
end