require_relative "recipe"
require "csv"

class Cookbook
  def initialize(filepath)
    @filepath = filepath
    @recipes = []
    CSV.foreach(filepath) { |row| @recipes << Recipe.new(
      {
        name: row[0],
        description: row[1],
        rating: row[2],
        prep_time: row[3],
        done: row[4]
      }
    ) }
  end

  def all
    @recipes
  end

  def create(recipe)
    @recipes << recipe
    store
  end

  def destroy(recipe_index)
    @recipes.delete_at(recipe_index)
    store
  end

  def store
    CSV.open(@filepath, "wb") do |csv|
      @recipes.each { |recipe| csv << [recipe.name, recipe.description, recipe.rating, recipe.prep_time, recipe.done] }
    end
  end

  def mark_done(i)
    @recipes[i].done = true
  end
end
