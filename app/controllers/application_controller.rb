class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :best_word, :calculate

  def best_word(letter_array)
  	blanks = letter_array.count('?')
		letter_array.delete('?')
		words = File.open("#{Rails.root}/app/assets/words/dictionary.txt")
		sorted_words = []

		# words.readlines.each do |word|
		# 	sorted_words << word.chomp
		# end
		found_words = words.readlines.keep_if do |word|
	        word = word.chomp.split(//)

	        letter_array.each do |letter|
				if word.index(letter)
					word.delete_at word.index(letter)
				end
	        end

			word.length <= blanks
		end
		blanks.times do |blank|
			letter_array << '?'
		end
		found_words
  end

  def calculate(found_words)
  	calculated_words = {}
		found_words.each do |word|
			worth = 0
			word.chars.each do |letter|
				case letter
				when 'a', 'e', 'i', 'o', 'u', 'l', 'n', 's', 't', 'r'
					worth += 1
				when 'd', 'g'
					worth += 2
				when 'b', 'c', 'm', 'p'
					worth += 3
				when 'f', 'h', 'v', 'w', 'y'
					worth += 4
				when 'k'
					worth += 5
				when 'j', 'x'
					worth += 8
				when 'q', 'z'
					worth += 10
				end
			end
			calculated_words[word] = worth 
		end

		max = calculated_words.values.max
		best_words = calculated_words.keys.keep_if do |word|
			calculated_words[word] == max
		end
		[best_words, max]
  end

end
