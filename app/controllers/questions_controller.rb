class QuestionsController < ApplicationController
  def question_1
    # What is the most recent movie on the list that the second actor appeared in?

    @the_actor = Actor.second.movies
    @ordered_movies = @the_actor.order("year DESC")

    @most_recent_movie_for_second_actor = @ordered_movies.first.title
  end

  def question_2
    # Who directed the longest movie on the list?

    @movies_ordered_by_duration = Movie.order("duration DESC")
    @the_director = @movies_ordered_by_duration.first.director

    @director_of_longest_movie = @the_director.name
  end

  def question_3
    # Which director has the most movies on the list?

    @director_list = Director.all
    @the_director = Director.first

    @director_list.each do |director|
      if director.movies.count > @the_director.movies.count
        @the_director = director
      end
    end

    @director_with_the_most_movies = @the_director.name
  end

  def question_4
    # Which actor has been in the most movies on the list?
    # (If there's a tie, any one of them is fine)

    # Your Ruby goes here.

    # @actor_with_the_most_movies = ???
  end

  def question_5
    # This one is hard. Work on it after all your other review is complete.

    # Which actor/director pair has the most movies on the list?
    # (If there's a tie, any pair of them is fine)

    # Your Ruby goes here.

    # @actor = ???
    # @director = ???
    # @movies_together = ???
  end
end
