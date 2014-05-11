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
    @actor_list = Actor.all
    @the_actor = Actor.first

    @actor_list.each do |actor|
      if actor.movies.count > @the_actor.movies.count
        @the_actor = actor
      end
    end

    @actor_with_the_most_movies = @the_actor.name
  end

  def question_5
    # Which actor/director pair has the most movies on the list?
    # (If there's a tie, any pair of them is fine)

    @most_collaborations = []

    Actor.all.each do |actor|
      @actor_grouped_movies = actor.movies.group_by { |movie| movie.director_id }
      @actor_most_collaborations = @actor_grouped_movies.max_by { |director_id, movies| movies.count }
      @most_collaborations << @actor_most_collaborations
    end


    @the_most = []

    @most_collaborations.each do |list_of_collaborations|
      @collaboration_count = list_of_collaborations[1].count
      @the_most << @collaboration_count
    end

    @count_most_collaborations = @the_most.sort.last


    @collaboration_movies_array = []

    @most_collaborations.each do |list_of_collaborations|
      @collaboration_count = list_of_collaborations[1].count
      if @collaboration_count == @count_most_collaborations
        @collaboration_movies_array << list_of_collaborations
      end
    end

    @movies_together = @collaboration_movies_array[0][1]
    @first_collaboration = @collaboration_movies_array[0][1][0]

    @the_final_director = Director.find_by({ :id => @first_collaboration.director_id})
    @director = @the_final_director.name

    @most_times_worked_with_the_director = 0

    Actor.all.each do |actor|
      @times_worked_with_the_director = actor.movies.where({ :director_id => @the_final_director.id }).count
      if @times_worked_with_the_director > @most_times_worked_with_the_director
        @most_times_worked_with_the_director = @times_worked_with_the_director
        @the_final_actor = actor
      end
    end

    @actor = @the_final_actor.name
  end
end
