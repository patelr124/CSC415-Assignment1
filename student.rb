class Student
	def initialize(first, last, email, section, major1, major2, minor1, minor2)
		@first = first
		@last = last
		@email = email
		@section = section
		@major1 = major1
		@major2 = major2
		@minor1 = minor1
		@minor2 = minor2
	end

	def set_name(first)
		@first = first
	end

	def set_last(last)
		@last = last
	end

	def set_email(email)
		@email = email
	end

	def set_section(section)
		@section = section
	end

	def set_major1(major1)
		@major1 = major1
	end

	def set_major2(major2)
		@major2 = major2
	end

	def set_minor1(minor1)
		@minor1 = minor1
	end

	def set_minor2(minor2)
		@minor2 = minor2
	end

	def get_name()
		return @first
	end

	def get_last()
		return @last
	end

	def get_email()
		return @email
	end

	def get_section()
		return @section
	end

	def get_major1()
		return @major1
	end

	def get_major2()
		return @major2
	end

	def get_minor1()
		return @minor1
	end

	def get_minor2()
		return @minor2
	end

	def print()
		printf("%-15s%-15s%-30s%-8s%-30s%-30s%-30s%-30s\n", "#@first", "#@last", "#@email", "#@section", "#@major1", "#@major2", "#@minor1", "#@minor2")
	end
end

