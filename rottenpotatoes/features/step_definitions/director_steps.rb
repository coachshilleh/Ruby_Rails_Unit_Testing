And /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  
  fill_in("movie_director", :with => value)
  
end



Then /the director of "([^"]*)" should be "([^"]*)"$/ do |movie_name, director_name|
    @strings = [movie_name, director_name]
    @strings.each do |text|
    if page.respond_to? :should
    page.should have_content(text)
    else
    assert page.has_content?(text)
    end
end
end

