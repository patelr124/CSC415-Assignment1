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

	def find(email)
		@group.each do |student|
			if student.get_email.strip.eql? email.strip
				return student
			end
		end
	end

end