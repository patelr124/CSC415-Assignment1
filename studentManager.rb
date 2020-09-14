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
	CSV.foreach(filename.strip, headers: true) do |line|
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

def create_group
	puts "1: Section Based (students from the same section)"
	puts "2: Major Based"
	puts "3: Minor Based"
	puts "4: More than 1 Basis (ex. major and section)"
	puts "0: Back to Main Menu"
	puts "Please type the option number that you would like:"
	input = gets.strip
	if input == "1"
		section_based
	elsif input == "2"
		
	elsif input == "3"
		
	elsif input == "4"
		
	elsif input == "0\n"
		main_menu
	else
		puts "Invalid input! Please restart!"
		edit_student
	end

end


def section_based
	# section_values = @students.uniq.pluck(:section)
	puts "Please enter the section that you would like to split up into groups: "
	section = gets.strip.to_s
	section_all = section_choice(@students, section)
	puts "How many people would you like in each group? Current population of section " +section+" is "+section_all.length
end

def section_choice(students, section) # students is the array
	@in_section=[];
	students.each do |student| # only select students by month
		if student[:section] == section.to_s
			@in_section << student
		end
	end
	# print_students(@in_section)
	return @in_section
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
	puts "What is the email of the student whose information you would like to change: "
	email = gets
	email.chomp
	# puts "What is the last name of the student whose information you would like to change: "
	# lastname = gets
	# lastname.chomp
	@students.each do |student|
		# puts "#{student[:email]}".strip.eql? email.strip
		if "#{student[:email]}".strip.eql? email.strip
			puts "Student found. What would you like to change about the student?"
			puts "1: First Name"
			puts "2: Last Name"
			puts "3: Email"
			puts "4: Section"
			puts "5: Major (1st)        6: Major (2nd)"
			puts "7: Minor (1st)        8: Minor (2nd)"
			puts "0: Back to Main Menu"
			puts "Please type the option number that you would like:"
			change = gets
			if change == "1\n"
				puts "What would you like their first name to be?"
				change = gets
				change.chomp
				student[:first] = change.strip
			elsif change == "2\n"
				puts "What would you like their last name to be?"
				change = gets
				change.chomp
				student[:last] = change.strip
			elsif change == "3\n"
				puts "What would you like their email to be?"
				change = gets
				change.chomp
				student[:email] = change.strip
			elsif change == "4\n"
				puts "What would you like their section to be?"
				change = gets
				change.chomp
				student[:section] = change.strip
			elsif change == "5\n"
				puts "What would you like their major (1st) to be?"
				change = gets
				change.chomp
				student[:major1] = change.strip
			elsif change == "6\n"
				puts "What would you like their major (2st) to be?"
				change = gets
				change.chomp
				student[:major2] = change.strip
			elsif change == "7\n"
				puts "What would you like their minor (1st) to be?"
				change = gets
				change.chomp
				student[:minor1] = change.strip
			elsif change == "8\n"
				puts "What would you like their minor (2st) to be?"
				change = gets
				change.chomp
				student[:minor2] = change.strip
			elsif input == "0\n"
				main_menu
			else
				puts "Invalid input! Please restart!"
				edit_student
			end
		end
	end
end

def student_options
	puts "What would you like to do?"
	puts "1: Edit existing student"
	puts "2: Create new student"
	puts "3: Delete existing student"
	puts "0: Back to Main Menu"
	input = gets
	if input == "1\n"
		edit_student
	elsif input =="2\n"
		create_student
	elsif input == "3\n"
		delete_student
	elsif input == "0\n"
		main_menu
	else 
		puts "Invalid student search, please restart!"
		student_options
	end	
end

def create_student
	puts "What is the student's first name?"
	first = gets.strip
	puts "What is the student's last name?"
	last = gets.strip
	puts "What is the student's email?"
	email = gets.strip
	puts "What's the student's section number?"
	section = gets.strip
	puts "What's the students major (1st)?"
	major1 = gets.strip
	puts "What's the student's major (2nd)?"
	major2 = gets.strip
	puts "What's the students minor (1st)?"
	minor1 = gets.strip
	puts "What's the student's minor (2nd)?"
	minor2 = gets.strip
	push_student(first, last, email, section, major1, major2, minor1, minor2)
end


def delete_student
	puts "What is the email of the student whose information you would like to change: "
	email = gets
	email.chomp
	index_del = nil;
	@students.each_with_index do |student, index|
		if "#{student[:email]}".strip.eql? email.strip
			index_del = index
		end
	end
	if index_del == nil
		puts "Invalid student search, please restart!"
		student_options
	else @students.delete_at(index_del)
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
		load_students(input.strip)
		main_menu
	elsif choice == "1\n"
		student_options
		main_menu
	elsif choice == "2\n"
		create_group
		main_menu
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
	puts "1: Edit/Add/Delete Student"
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
# edit_student
# print_students (@students)
# section_choice(@students, 9)
# section_choice(@students, 3)
# print_groups(@groups)
main_menu
# print_groups(@groups)
# @students.each do | stud | # prints student lists by cohort
# 		puts stud
# 	end