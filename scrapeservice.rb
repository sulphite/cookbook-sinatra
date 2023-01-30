require "nokogiri"
require "open-uri"

class ScrapeService
  def scrape_5(keyword)
    url = "https://www.allrecipes.com/search?q=#{keyword}"
    doc = Nokogiri::HTML.parse(URI.open(url).read)
    doc.search(".mntl-card-list-items").reject {|x| x.search(".recipe-card-meta__rating-count").empty? }.take(5).map do |ele|
      {
        url: ele["href"],
        name: ele.search("div span .card__title-text")[0].text
      }
    end
  end

  def scrape_recipe(recipe)
    recipe_doc = Nokogiri::HTML.parse(URI.open(recipe[:url]).read)
    recipe[:description] = recipe_doc.search(".article-subheading")[0].text.strip
    recipe[:rating] = recipe_doc.search(".mntl-recipe-review-bar__rating")[0].text.strip
    recipe[:prep_time] = recipe_doc.search(".mntl-recipe-details__value")[0].text.strip
    recipe
  end

end
