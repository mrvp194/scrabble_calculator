class WordsController < ApplicationController

	def index
		letters = Array.new(9, 'a') + Array.new(2, 'b') + Array.new(2, 'c') + Array.new(4, 'd') + Array.new(12, 'e') + Array.new(2, 'f') + Array.new(3, 'g') + Array.new(2, 'h') + Array.new(9, 'i') + Array.new(1, 'j') + Array.new(1, 'k') + Array.new(4, 'l') + Array.new(2, 'm') + Array.new(6, 'n') + Array.new(8, 'o') + Array.new(2, 'p') + Array.new(1, 'q') + Array.new(6, 'r') + Array.new(4, 's') + Array.new(6, 't') + Array.new(4, 'u')  + Array.new(2, 'v') + Array.new(2, 'w') + Array.new(1, 'x') + Array.new(2, 'y') + Array.new(1, 'z') + Array.new(1, '?')
		@chosen_letters = []

		7.times do |a|
			@chosen_letters << letters.shuffle!.pop
		end
	end

	def find_word
		@chosen_letters = params[:chosen_letters].split('')
		@found_words = best_word(@chosen_letters)
		@best_words = calculate(@found_words)
	end

end