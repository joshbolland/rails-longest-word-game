require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (Array.new(10) { ('a'..'z').to_a.sample })
  end

  def check_word(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    word = JSON.parse(open(url).read)
    word['found']
  end

  def score
    @letters = params[:letters].upcase.split("")
    @word = params[:word]
    if @word.upcase.chars.all? { |letter| @word.upcase.count(letter) > @letters.count(letter) }
      @score = "Sorry but #{@word.upcase} cannot be built out of #{@letters}"
    elsif check_word(@word)
      @score = "Congratulations! #{@word.upcase} is a valid English word!"
    else
      @score = "Sorry buy #{@word.upcase} does not seem to be a valid English word..."
    end
  end
end
