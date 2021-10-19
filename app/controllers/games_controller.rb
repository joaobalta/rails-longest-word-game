# frozen_string_literal: true
require 'open-uri'
require 'json'


class GamesController < ApplicationController
  def new
    @letters = generate_grid(19)
    @start_time = Time.now
  end

  def score
    @attempt = params[:attempt]
    @end_time = Time.now
    @result = run_game(@attempt, @letters, @start_time, @end_time)
  end

  def generate_grid(grid_size)
    Array.new(grid_size) { ('A'..'Z').to_a.sample }
  end

  def included?(attempt, letters)
    attempt.chars.all? { |letter| attempt.count(letter) <= @attempt.count(letter) }
  end

  def compute_score(attempt, time_taken)
    time_taken.values[0] > 60.0 ? 0 : @attempt.size * (1.0 -  time_taken.values[0].to_f  / 60.0)
  end

  def run_game(attempt, letters, start_time, end_time)
    result = { time: 9 } # coloquei um numero qq

    score_and_message = score_and_message(@attempt, @letters, result)
    result[:score] = score_and_message.first
    result[:message] = score_and_message.last

    result
  end

  def score_and_message(attempt, letters, time)
    if included?(@attempt.upcase, @letters)
      if english_word?(@attempt.to_s)
        score = compute_score(@attempt, time)
        [score, 'well done']
      else
        [0, 'not an english word']
      end
    else
      [0, 'not in the grid']
    end
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
