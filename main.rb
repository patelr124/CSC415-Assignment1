# require './student.rb'
require 'csv'
require './group.rb'


class Assignment1

def initialize
	@students = Group.new
	# load_students("test_file.csv")
	main_menu
end

def main_menu # main menu that presents all of the main options to teh user
	puts "----- Main Menu ------"
	puts "1: Load .csv File"
	puts "2: Edit/Add/Delete Student"
	puts "3: Create Group"
	puts "4: View All Groups"
	puts "5: Write All Groups to File"
	puts "6: View All Students"
	puts "10: Exit"
	puts "Please type the option number that you would like:"
	# @choice = gets.to_i
	menu_choice(gets.to_i)
end

def menu_choice(choice) # evaluates user's choice and calls appropriate methods
	case choice
	when 0
		puts "Invalid input! Please choose a valid option from the menu below!"
		main_menu
	when 1
		puts "Please enter filename: "
		input = gets
		input.chomp
		load_students(input.strip)
		main_menu
	when 2
		student_options
		main_menu
	when 3
		create_group
		main_menu
	when 4
		print_all_groups
		main_menu
	when 5
		export_groups
		main_menu
	when 6
		@students.print_group
		main_menu
	when 10
		puts "Goodbye! Have a great day!"
	end
end

def load_students(filename) # reads in the students from the .csv inclusing headers
	if File.file?(filename)
		CSV.foreach(filename.strip, headers: true) do |line|
			@students.add(Student.new(line[0], line[1], line[2], line[3], line[4], line[5], line[6], line[7]))
		end
		puts "The file has been loaded." 
	else
		puts "File does not exist, please try again."
	end
end

def student_options # provides use with option to student directory and calls appropriate methods
	puts "What would you like to do?"
	puts "1: Edit existing student"
	puts "2: Create new student"
	puts "3: Delete existing student"
	puts "10: Back to Main Menu"
	input = gets.to_i
	case input
	when 0 
		puts "Invalid student search, please restart!"
		student_options
	when 1
		edit_student
	when 2
		add_student
	when 3
		delete_student
	when 10
		main_menu
	end	
end

def edit_student()
	puts "What is the email of the student whose information you would like to change: "
	@ch_student = @students.find(gets.chomp)
	@ch_student.change_student
end

def add_student()
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
	@students.add(Student.new(first, last, email, section, major1, major2, minor1, minor2))
end


end
Assignment1.new

