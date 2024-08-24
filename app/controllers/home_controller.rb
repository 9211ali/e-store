class HomeController < ApplicationController

  def index
    @main_categories = Category.first(4)
  end
end
