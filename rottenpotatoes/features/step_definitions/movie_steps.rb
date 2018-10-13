# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
  #fail "Unimplemented"
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  title_array = page.body.scan(/#{e1}|#{e2}/)
  title_array.uniq!
  title_array.index(e1).should be < title_array.index(e2), "#{e2} came before #{e1}"
  #fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list = rating_list.split(",")
  rating_list.each do |rating|
    unless uncheck
      step "I check \"ratings_#{rating}\""
    else
      step "I uncheck \"ratings_#{rating}\""
    end
  end
  #fail "Unimplemented"
end

Then /I should see the following movies: (.*)/ do |movies_list|
  movies_list = movies_list.split(",")
  movies_list.each do |movie|
      step "I should see #{movie}"
  end
end

Then /I should not see the following movies: (.*)/ do |movies_list|
  movies_list = movies_list.split(",")
  movies_list.each do |movie|
    step "I should not see #{movie}"
  end
end

Then /I should see movies with the following ratings: (.*)/ do |selected|
  selected = selected.split(",")
  selected_movies = Movie.where(:rating => selected)
  selected_movies.each do |movie|
    step "I should see \"#{movie.title}\""
  end
end
  
Then /I should not see movies with the following ratings: (.*)/ do |selected|
  selected = selected.split(",")
  selected_movies = Movie.where(:rating => selected)
  selected_movies.each do |movie|
    step "I should not see \"#{movie.title}\""
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  Movie.all.each do |movie|
    step "I should see \"#{movie.title}\""
  end
  #fail "Unimplemented"
end