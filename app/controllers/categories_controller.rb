<<<<<<< HEAD
class CategoriesController < ApplicationController
  def index
    @categories = Category.includes(:products)
  end

  def show
    @category = Category.includes(:products).find(params[:id])
  end
end
=======
class CategoriesController < ApplicationController
  def index
    @categories = Category.includes(:products)
  end

  def show
    @category = Category.includes(:products).find(params[:id])
  end
end
>>>>>>> Redesign-Layout-for-products-and-categories
