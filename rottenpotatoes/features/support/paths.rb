# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    
######################################################################################################################

    when /^the (RottenPotatoes )?home\s?page$/ then '/movies'

    when /^the edit page for "([^"]+)"$/
      movie_name = page_name.split(" ")
      # I am removing the quotes 
      movie_name[-1][0] = ""
      movie_name[-1][-1] = ""
      edit_movie_path(Movie.find_by_title(movie_name).id)
      
      
    when /^the details page for "([^"]+)"$/
      movie_path(Movie.find_by_title($1).id)
      
    when /^the Similar Movies page for "([^"]+)"$/
      same_directors_path(Movie.find_by_title($1).id)
      
######################################################################################################################


    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
