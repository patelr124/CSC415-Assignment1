# assign.rb
require 'csv' # for working with CSV files
require 'pp'


@students = [] # define a variable accessible to all methods
# @stud = Student.new
@groups = []

#########################################################################
#   methods related to csv file loading and exporting
#########################################################################
def load_students(filename)
	CSV.foreach(filename, headers: true) do |line|
		first, last, email, section, major1, major2, minor1, minor2 = line[0], line[1], line[2], line[3], line[4], line[5], line[6], line[7]
		push_student(first, last, email, section, major1, major2, minor1, minor2)
	end
	puts "The file has been loaded."
end

def push_student(first, last, email, section, major1, major2, minor1, minor2)
	@students << {first: first, last: last, email: email, section: section, major1: major1, major2: major2, minor1: minor1, minor2: minor2}
		# @stud << Student.new(first,last, email,section,major1,major2,minor1,minor2)
		# @students << @stud
	end


#########################################################################
#   methods related creating groups
#########################################################################

def section_choice(students, section) # students is the array
	@in_section=[];
	students.each do |student| # only select students by month
		if student[:section] == section.to_s
			@in_section << student
		end
	end
	# print_students(@in_section)
	@groups << @in_section
end

def major1_choice(students, major1) # students is the array
	by_major1 = students.select do |student| # only select students by month
		student[:major1] == major1
	end

	by_major1.each_with_index do |student, index| # print out above results with index
		groups<<" "
		groups<< "#{index + 1}. - #{student[:name]} in #{student[:major1]}"
	end
end

def copy_student(student)
	@stud = {first: "#{student[:first]}",last:"#{student[:last]}",email:"#{student[:email]}", section: "#{student[:section]}", major1: "#{student[:major1]}", major2: "#{student[:major2]}", minor1: "#{student[:minor1]}", minor2: "#{student[:minor2]}"} 
	print_students(@stud)
end

#########################################################################
#   methods related to printing out student data
#########################################################################

def print_students (array)
	printf("%-15s%-15s%-30s%-8s%-30s%-30s%-30s%-30s\n", "First Name","Last Name", "Email", "Section", "Major","Major (2nd)", "Minor","Minor (2nd)")
	array.each  do |student| # only select students by month
		# puts "#{student[:first]} #{student[:last]} #{student[:email]} #{student[:section]} #{student[:major1]} #{student[:major2]}  #{student[:minor2]} #{student[:minor2]}  "
		printf("%-15s%-15s%-30s%-8s%-30s%-30s%-30s%-30s\n", "#{student[:first]}"," #{student[:last]}", "#{student[:email]}", "#{student[:section]}", "#{student[:major1]}","#{student[:major2]}", "#{student[:minor2]}","#{student[:minor2]}")
	end
end

def print_groups (array)
	array.each  do |group|
		print_students(group)
	end
end

#########################################################################
#   methods related to editing a students data
#########################################################################
def edit_student
	puts "What is the first name of the student whose information you would like to change: "
	firstname = gets
	firstname.chomp
	puts "What is the last name of the student whose information you would like to change: "
	lastname = gets
	lastname.chomp
	@students.each do |student|
		puts student[:first]
		if student[:first].to_s == firstname #&& "#{student[:first]}" == lastname.t
			puts "Student found. What would you like to change about the student?"
			puts "1: First Name"
			puts "2: Last Name"
			puts "3: Email"
			puts "4: Major (1st or 2nd)"
			puts "5: Minor (1st or 2nd"
			puts "Please type the option number that you would like:"
			change = gets
			if change == "1\n"
				puts "What would you like their first name to be?"
				change = gets
				change.chomp
				instance_variable_set(:@first, change)
				puts "#{student[:first]} #{student[:last]}"
			end
		end
	end
end



#########################################################################
#   methods related to the main menu and choice evaluation
#########################################################################
def menu_choice(choice)
	if choice == "5\n"
		puts "Goodbye! Have a great day!"
	elsif choice == "0\n"
		puts "Please enter filename: "
		input = gets
		input.chomp
		load_students("test_file.csv")
		main_menu
	elsif choice == "1\n"
		edit_student
		main_menu

	# elsif choice == "2\n"
	# 	create_group
	# 	main_menu
	# elsif choice == "3\n"
	# 	export_groups
	# 	main_menu
elsif choice == "4\n"
	print_students(@students)
	main_menu
else
	puts "Invalid input! Please choose a valid option from the menu below!"
	main_menu
end
end

def main_menu
	puts "----- Main Menu ------"
	puts "0: Load .csv File"
	puts "1: Edit Student"
	puts "2: Create Group"
	puts "3: Write All Groups to File"
	puts "4: View All Students"
	puts "5: Exit"
	puts "Please type the option number that you would like:"
	@choice = gets
	menu_choice(@choice)
end

#########################################################################
#   "main" code/method
#########################################################################

# load_students("test_file.csv")
# print_students (@students)
# section_choice(@students, 9)
# section_choice(@students, 3)
# print_groups(@groups)
main_menu
# print_groups(@groups)
# @students.each do | stud | # prints student lists by cohort
# 		puts stud
# 	end