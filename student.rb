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

	def set_first(first)
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

	def get_first()
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

	def change_student()
		puts "Student found. What would you like to change about the student?"
		puts "1: First Name"
		puts "2: Last Name"
		puts "3: Email"
		puts "4: Section"
		puts "5: Major (1st)        6: Major (2nd)"
		puts "7: Minor (1st)        8: Minor (2nd)"
		puts "0: Back to Main Menu"
		puts "Please type the option number that you would like:"
		change = gets.to_i
		case change
		when 1
			puts "What would you like their first name to be?"
			set_first(gets.strip)
		when 2
			puts "What would you like their last name to be?"
			set_last(gets.strip)
		when 3
			puts "What would you like their email to be?"
			set_email(gets.strip)
		when 4
			puts "What would you like their section to be?"
			set_section(gets.strip.to_i)
		when 5
			puts "What would you like their major (1st) to be?"
			set_major1(gets.strip)
		when 6
			puts "What would you like their major (2st) to be?"
			set_major2(gets.strip)
		when 7
			puts "What would you like their minor (1st) to be?"
			set_minor1(gets.strip)
		when 8
			puts "What would you like their minor (2st) to be?"
			set_minor2(gets.strip)
		when 10
			main_menu
		when 0
			puts "Invalid input! Please restart!"
			change_student
		end
	end

	def print()
		printf("%-15s%-15s%-30s%-8s%-30s%-30s%-30s%-30s\n", "#@first", "#@last", "#@email", "#@section", "#@major1", "#@major2", "#@minor1", "#@minor2")
	end
end

