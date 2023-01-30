require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative "cookbook"
require_relative "recipe"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path(__dir__)
end

csv_file   = File.join(__dir__, 'recipes.csv')
cookbook = Cookbook.new(csv_file)

get "/" do
  @recipes = cookbook.all
  erb :index
end

get "/new" do
 erb :new
end

post "/create" do
  # create the recipe
  recipe = Recipe.new({
    name: params[:name],
    description: params[:rating],
    rating: params[:rating],
    prep_time: params[:prep_time],
    done: false
  })
  cookbook.create(recipe)
  # send user back to home
  redirect to('/')
end

get "/team/:username" do
  puts params[:username]
  "The username is #{params[:username]}"
end
