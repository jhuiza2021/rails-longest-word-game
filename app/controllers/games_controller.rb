require "open-uri"

class GamesController < ApplicationController
#   def new
#     @letter = 
#     @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }  

#   end
  VOWELS = %w(A E I O U Y)

  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end


  def score
    @letras = params[:letters].split
    @word = (params[:palabra] || "").upcase
    @included = included?(@word, @letras)
    @english_word = english_word?(@word)

  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
