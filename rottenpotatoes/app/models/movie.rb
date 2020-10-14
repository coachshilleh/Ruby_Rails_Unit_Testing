class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.same_dir(id)
    # Movie.where(:director => director)
    # i want to look at the director aspects of this movie
    Movie.find(id).director
      self.where(director: Movie.find(id).director)
  end
end

