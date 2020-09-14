# assign.rb
require 'csv' # for working with CSV files
class Assignment1

def initialize
	@students = [] # define a variable accessible to all methods
	@groups = []
	main_menu
end

#########################################################################
#   methods related to csv file loading and exporting
#########################################################################
def load_students(filename) # reads in the students from the .csv inclusing headers
	CSV.foreach(filename.strip, headers: true) do |line|
		first, last, email, section, major1, major2, minor1, minor2 = line[0], line[1], line[2], line[3], line[4], line[5], line[6], line[7]
		push_student(first, last, email, section, major1, major2, minor1, minor2)
	end
	puts "The file has been loaded."
end

def push_student(first, last, email, section, major1, major2, minor1, minor2) # adds students to the array to access later
	@students << {first: first, last: last, email: email, section: section, major1: major1, major2: major2, minor1: minor1, minor2: minor2}
end

#########################################################################
#   methods related creating groups
#########################################################################

def create_group # provides user with group creation options and then calls appropriate methods
	puts "1: Section Based (students from the same section)"
	puts "2: Major Based"
	puts "3: Minor Based"
	puts "4: More than 1 Basis (ex. major and section)"
	puts "0: Back to Main Menu"
	puts "Please type the option number that you would like:"
	input = gets.strip
	if input == "1"
		@groups << section_based
	elsif input == "2"
		@groups << major_based
	elsif input == "3"
		@groups << minor_based
	elsif input == "4"
		multi_based
	elsif input == "0"
		main_menu
	else # input validation
		puts "Invalid input! Please restart!"
		create_group
	end

end

def section_based 
	puts "Please enter the section that you would like to split up into groups: "
	section = gets.strip.to_s
	@section_all = section_choice(section)
	puts "How many people would you like in each group? Current population of section " + section + " is "+ @section_all.length.to_s
	size =  gets.chomp.to_i
	@section_all = @section_all.each_slice(size.to_i).to_a  #slice breaks array up into an array of arrays
		#doesn't always make evil groups -- no consideration for remainders
	return @section_all
end

def section_choice(section) # section is an array
	@in_section=[];
	@students.each do |student| # only select students in that section
		if student[:section] == section.to_s
			@in_section << student
		end
	end
	return @in_section
end

def major_choice( major) # major is the array
	@in_major=[];
	@students.each do |student| # only select students by major (whether its first or second)
		if student[:major1] == major.to_s || student[:major2] == major.to_s 
			@in_major << student
		end
	end
	return @in_major
end

def major_based
	puts "Please enter the major (1st) that you would like to split up into groups: "
	major = gets.strip.to_s
	@major_all = major_choice(major)
	puts "How many people would you like in each group? Current population in " + major + " is "+ @major_all.length.to_s
	size =  gets.chomp.to_i
	@major_all = @major_all.each_slice(size.to_i).to_a
	print_groups(@major_all)
	return @major_all
end

def minor_choice(minor) # minor is the array
	@in_minor=[];
	@students.each do |student| # only select students by minor (first or second)
		if student[:minor1] == minor.to_s || student[:minor2] == minor.to_s 
			@in_minor << student
		end
	end
	return @in_minor
end

def minor_based
	# section_values = @students.uniq.pluck(:section)
	puts "Please enter the minor (1st) that you would like to split up into groups: "
	minor = gets.strip.to_s
	@minor_all = minor_choice(minor)
	puts "How many people would you like in each group? Current population in " + minor + " is "+ @minor_all.length.to_s
	size =  gets.chomp.to_i
	@minor_all = @minor_all.each_slice(size.to_i).to_a
	return @minor_all
end

def multi_simplify(choice) # method to take into account 2 constraints
	if choice == "12" # 1 = section 2 = major
		puts "Please enter the section that you would like"
		sect = gets.strip.to_s
		puts "Please enter the major that you would like"
		major = gets.strip.to_s
		@sect_all = section_choice(sect) # weeds out to only include section
		@indexes = [];
		@sect_all.each_with_index do |student, index| # if from section array is not the same major
			if !(student[:major1] == major.to_s || student[:major2] == major.to_s)
				@indexes << index.to_i 
			end
		end

		@indexes.reverse.each do |index_del| # deletes array indices that don't meet najor conatraint (reversed so array indixes don't change while deleting)
			@sect_all.delete_at(index_del.to_i)
		end
		puts "How many people would you like in each group? Current population is "+ @sect_all.length.to_s
		size =  gets.chomp.to_i
		@sect_all = @sect_all.each_slice(size.to_i).to_a
		print_groups(@sect_all)
		return @sect_all
	elsif choice == "13" # 1 = section 3 = minor
		puts "Please enter the section that you would like"
		sect = gets.strip.to_s
		puts "Please enter the minor that you would like"
		minor = gets.strip.to_s
		@sect_all = section_choice(sect)
		@indexes = [];
		@sect_all.each_with_index do |student, index|
			if !(student[:minor1] == minor.to_s || student[:minor2] == minor.to_s)
				@indexes << index.to_i
			end
		end

		@indexes.reverse.each do |index_del|
			@sect_all.delete_at(index_del.to_i)
		end
		puts "How many people would you like in each group? Current population is "+ @sect_all.length.to_s
		size =  gets.chomp.to_i
		@sect_all = @sect_all.each_slice(size.to_i).to_a
		print_groups(@sect_all)
		return @sect_all
	elsif choice == "23" # 2 = major 3 = minor
		puts "Please enter the major that you would like"
		major = gets.strip.to_s
		puts "Please enter the minor that you would like"
		minor = gets.strip.to_s
		@major_all = majorion_choice(major)
		@indexes = [];
		@major_all.each_with_index do |student, index|
			if !(student[:minor1] == minor.to_s || student[:minor2] == minor.to_s)
				@indexes << index.to_i
			end
		end
		@indexes.reverse.each do |index_del|
			@major_all.delete_at(index_del.to_i)
		end
		puts "How many people would you like in each group? Current population is "+ @major_all.length.to_s
		size =  gets.chomp.to_i
		@major_all = @major_all.each_slice(size.to_i).to_a
		print_groups(@major_all)
		return @major_all
	end
end

def multi_based # provides menu for double constraints
	puts "1: Major and Section"
	puts "2: Minor and Section"
	puts "3: Major and Minor"
	puts "0: Back to Main Menu"
	puts "Please type the option number that you would like:"
	input = gets.strip
	if input == "1"
		@groups << multi_simplify("12")
	elsif input == "2"
		@groups << multi_simplify("13")
	elsif input == "3"
		@groups << multi_simplify("23")
	elsif input == "4"
		multi_based
	elsif input == "0"
		main_menu
	else
		puts "Invalid input! Please restart!"
		multi_based

	end
end

def export_groups() # method to export as file
	puts "What would you like to name your file? (Please include the '.txt' extension.)"
	filename = gets.strip.to_s #removes unwated characters
	out_file = File.new(filename, 'w') #opens file
	@groups.each_with_index  do |array, ind| # traverses array of all constraint sets
		out_file.puts "Constraint set " + (ind+1).to_s 
		array.each_with_index do |gr, inde| # traverses groups formed from constraints
			out_file.puts "Group " + (inde+1).to_s
			string = "%-15s%-15s%-30s%-8s%-30s%-30s%-30s%-30s\n" % ["First Name","Last Name", "Email", "Section", "Major","Major (2nd)", "Minor","Minor (2nd)"]
			out_file.puts (string.to_s)
			gr.each do |student| # traverses students in the groups formed from the constraints
				string = "%-15s%-15s%-30s%-8s%-30s%-30s%-30s%-30s\n" % ["#{student[:first]}"," #{student[:last]}", "#{student[:email]}", "#{student[:section]}", "#{student[:major1]}","#{student[:major2]}", "#{student[:minor1]}","#{student[:minor2]}"]
				out_file.puts (string.to_s)
			end
			out_file.puts("\n")
		end
		out_file.puts("\n\n")
	end
end

#########################################################################
#   methods related to printing out student data
#########################################################################

def print_students (array) # prints and formats students data so it is readable
	printf("%-15s%-15s%-30s%-8s%-30s%-30s%-30s%-30s\n", "First Name","Last Name", "Email", "Section", "Major","Major (2nd)", "Minor","Minor (2nd)")
	array.each  do |student| # only select students by month
		# puts "#{student[:first]} #{student[:last]} #{student[:email]} #{student[:section]} #{student[:major1]} #{student[:major2]}  #{student[:minor2]} #{student[:minor2]}  "
		printf("%-15s%-15s%-30s%-8s%-30s%-30s%-30s%-30s\n", "#{student[:first]}"," #{student[:last]}", "#{student[:email]}", "#{student[:section]}", "#{student[:major1]}","#{student[:major2]}", "#{student[:minor1]}","#{student[:minor2]}")
	end
end

def print_groups (array) # prints groups formed by a single constraint set
	array.each  do |group|
		print_students(group)
		puts "\n"
	end
end

def print_all_groups # prints all the groups formed by all the constraint sets
	@groups.each  do |group|
		print_groups(group)
		puts "\n\n"
	end
end

#########################################################################
#   methods related to editing a students data
#########################################################################

def edit_student  #provides user the ability to change any attribute of the student -- looks up by email only
	puts "What is the email of the student whose information you would like to change: "
	email = gets
	email.chomp
	@students.each do |student|
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

def student_options # provides use with option to student directory and calls appropriate methods
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

def create_student # creates a new student in the dircetory
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

def delete_student  # deletes student from the direectory -- email lookup only
	puts "What is the email of the student whose information you would like to change: "
	email = gets
	email.chomp
	index_del = nil;
	@students.each_with_index do |student, index|
		if "#{student[:email]}".strip.eql? email.strip
			index_del = index
		end
	end
	if index_del == nil # makes sure student is found
		puts "Invalid student search, please restart!"
		student_options
	else @students.delete_at(index_del)
	end

end

#########################################################################
#   methods related to the main menu and choice evaluation
#########################################################################
def menu_choice(choice) # evaluates user's choice and calls appropriate methods
	if choice == "0\n"
		puts "Goodbye! Have a great day!"
	elsif choice == "1\n"
		puts "Please enter filename: "
		input = gets
		input.chomp
		load_students(input.strip)
		main_menu
	elsif choice == "2\n"
		student_options
		main_menu
	elsif choice == "3\n"
		create_group
		main_menu
	elsif choice == "4\n"
		print_all_groups
		main_menu
	elsif choice == "5\n"
		export_groups
		main_menu
	elsif choice == "6\n"
		print_students(@students)
		main_menu
	else
		puts "Invalid input! Please choose a valid option from the menu below!"
		main_menu
	end
end

def main_menu # main menu that presents all of the main options to teh user
	puts "----- Main Menu ------"
	puts "1: Load .csv File"
	puts "2: Edit/Add/Delete Student"
	puts "3: Create Group"
	puts "4: View All Groups"
	puts "5: Write All Groups to File"
	puts "6: View All Students"
	puts "0: Exit"
	puts "Please type the option number that you would like:"
	@choice = gets
	menu_choice(@choice)
end

end
#########################################################################
#   "main" code/method
#########################################################################

Assignment1.new 
