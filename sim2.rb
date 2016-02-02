class Voter
	attr_accessor :name, :politics, :political_party
	@@voters = []
	@@pols = []
end

class Person < Voter
	def initialize(name, politics)
		@name = name
		@politics = politics
		@@voters << self
	end

	def self.all
		@@voters
	end

	def to_s
		"Voter, #{@name}, #{@politics}"
	end
end

class Politician < Voter
	def initialize(name, political_party)
		@name = name
		@political_party = political_party
		@@pols << self
	end

	def self.all
		@@pols
	end
end
###############################################################################

class Votingsim < Voter
	def menu
	puts "What would you like to do? (C)reate, (L)ist, (U)pdate, or (D)elete."
	answer = gets.chomp
	  case answer.downcase
		when 'c'
			create
		when 'l'
			list
		when 'u'
			update
		when 'd'
			delete
		else
			puts "You didn't enter Create, List, Update or Delete"
			menu
		end
	end

	def create
		puts "What would you like to create? (P)olitician or (V)oter."
		create_answer = gets.chomp
		if create_answer.downcase == 'p'
			puts "Name?"
			name = gets.chomp.capitalize
			puts "Party? Democrat or Republican."
			political_party = gets.chomp.capitalize
			  sim1 = Politician.new(name, political_party)
		elsif create_answer.downcase == 'v'
			puts "Name?"
			name = gets.chomp.capitalize
			puts "Politics? Liberal, Conservative, Tea Party, Socialist or Neutral"
			politics = gets.chomp.capitalize
				sim2 = Person.new(name, politics)
		else
			puts "You didn't enter (P)olitician or (V)oter."
			create
		end
		menu
	end

	def list
		puts ""
		puts "All registered Politicians and Voters"
		puts ""
		puts Person.all
		# Person.all.each do |person|
		# 	puts "Voter, #{person.name}, #{person.politics}"
		# end

		Politician.all.each do |pol|
			puts "Politician, #{pol.name}, #{pol.political_party}"
		end
		puts ""
		menu
	end

	def update
		puts "Whose information would you like to update?\nEnter Name"
		old_name = gets.chomp.capitalize
		Person.all.each do |person|
			if old_name == person.name
				puts "What would you like to update? Enter (N)ame or (P)olitics"
				update_this = gets.chomp.capitalize
					if update_this ==  "N"
						puts "What is the new name?"
						new_name = gets.chomp.capitalize
						# person.name = new_name
						Person.all.each do |person|
							if old_name == person.name
								person.name = new_name
								menu
							end
						end
					elsif update_this == "P"
						puts "What are your new politics? Liberal, Conservative, Tea Party, Socialist or Neutral"
						new_politics = gets.chomp.capitalize
						Person.all.each do |person|
							if old_name == person.name
								person.politics = new_politics
								menu
							end
						end
					else
						puts "What would you like to update? Enter (N)ame or (P)olitics"
						update
					end
				end
			end
		end
		Politician.all.each do |pol|
			if old_name == pol.name
				puts "What would you like to update? Enter (N)ame or (P)arty"
				update_this = gets.chomp.capitalize
					if update_this ==  "N"
						puts "What is the new name?"
						new_name = gets.chomp.capitalize
						Politician.all.each do |pol|
							if old_name == pol.name
								pol.name = new_name
								menu
							end
						end
					elsif update_this == "P"
						puts "What is your new party? Democrat or Republican"
						new_party= gets.chomp.capitalize
						Politician.all.each do |pol|
							if old_name == pol.name
								pol.political_party = new_party
								menu
							end
						end
					else
						puts "You did not specify (N)ame or (P)arty"
						update
					end
		else
			puts "Name not found in directory."
			menu
		end
	end

	def delete
		puts "All registered Politicians and Voters"
		puts ""
		Person.all.each do |person|
			puts "Voter, #{person.name}, #{person.politics}"
		end

		Politician.all.each do |pol|
			puts "Politician, #{pol.name}, #{pol.political_party}"
		end
		puts ""
		puts "Who would you like to delete? (Name only)"

		delete_prompt = gets.chomp.capitalize
		Person.all.each do |person|
			if delete_prompt == person.name
				puts "Are you sure you want to delete Voter? (Y)es or (N)o?"
				delete_name = gets.chomp.capitalize
					if delete_name == "Y"
						puts "Voter has been deleted"
						Person.all.each do |person|
							if delete_prompt == person.name
								@@voters.delete_if {|person| person.name = delete_prompt}
								menu
							end
						end
					elsif delete_name == "N"
						menu
					end
			end
		end
		Politician.all.each do |pol|
			if delete_prompt == pol.name
				puts "Are you sure you want to delete Voter? (Y)es or (N)o?"
				delete_name = gets.chomp.capitalize
					if delete_name == "Y"
						puts "Politician has been deleted"
						#Politician.delete("Sean")
						Politician.all.each do |pol|
							if delete_prompt == pol.name
								@@pols.delete_if {|pol| pol.name = delete_prompt}
								menu
							end
						end
					elsif delete_name == "N"
						menu
					end
			end
		end
		puts "Name not found in directory."
		menu
	end
end



votersim = Votingsim.new
votersim.menu
