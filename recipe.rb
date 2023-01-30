class Recipe
  attr_reader :name, :description, :rating, :prep_time
  attr_accessor :done

  def initialize(hash)
    @name = hash[:name]
    @description = hash[:description]
    @rating = hash[:rating]
    @prep_time = hash[:prep_time]
    @done = hash[:done]
  end
end
