require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
    @letters << ("A".."Z").to_a.sample
    end
  end

  def score
    @word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    dictionary_hash = JSON.parse(open(url).read)
    @grid = params[:grid].split(" ")
    if inside?(@word, @grid)
      if dictionary_hash["found"]
        @answer = "Congratulations! #{@word} is a valid English word!"
      else
        @answer = "Sorry but #{@word} does not seem to be a valid English word..."
      end
    else
      @answer = "Sorry but #{@word} can´t be build out of #{@grid}"
    end
  end


  def inside?(attempt, grid)
    attempt.upcase.split("").all? { |letter| attempt.upcase.count(letter) <= grid.count(letter) && grid.include?(letter) }
  end
end















# def included?(attempt, grid)
#   attempt.upcase.split("").all? { |letter| attempt.upcase.count(letter) <= grid.count(letter) && grid.include?(letter) }
# end


# def run_game(attempt, grid, start_time, end_time)
#   s = compute_score_and_time(attempt, grid, start_time, end_time)
#   result = { time: s[1], score: s[0] }
#   if !english_word?(attempt)
#     result[:message] = "not an english word"
#   elsif !included?(attempt, grid)
#     result[:message] = "not in the grid."
#   else
#     result[:message] = "Well done!"
#   end
#   return result
# end

# def compute_score_and_time(attempt, grid, start_time, end_time)
#   result = []
#   if english_word?(attempt) && included?(attempt, grid)
#     result << (attempt.length * 10) - (end_time - start_time)
#   else
#     result << 0
#   end
#   result << end_time - start_time
# end

