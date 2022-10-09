class RecipesController < ApplicationController
  before_action :authorize

  def index
    recipes = Recipe.all
    render json: recipes, status: :created
  end

  def create
    # recipe = Recipe.create(recipe_params)
    recipe = Recipe.new(recipe_params)
    recipe.user_id = session[:user_id]
    if recipe.valid?
      # recipe.user_id = session[:user_id]
      recipe.save
      render json: recipe, status: :created
    else
      render json: { errors: recipe.errors.full_messages  }, status: :unprocessable_entity
    end
  end

  private

  def authorize
    render json: { errors: ["Unauthorized"] }, status: :unauthorized unless session.include? :user_id
  end

  def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete)
  end
  
end
