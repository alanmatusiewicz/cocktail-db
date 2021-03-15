class IngredientsController < ApplicationController
  def index
    matching_ingredients = Ingredient.all

    @list_of_ingredients = matching_ingredients.order({ :created_at => :desc })

    render({ :template => "ingredients/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_ingredients = Ingredient.where({ :id => the_id })

    @the_ingredient = matching_ingredients.at(0)

    render({ :template => "ingredients/show.html.erb" })
  end

  def create
    @recipe_id = params.fetch("query_recipe_id")
    
    the_ingredient = Ingredient.new
    the_ingredient.recipe_id = @recipe_id
    the_ingredient.alcohol_id = params.fetch("query_alcohol_id")
    the_ingredient.measure = params.fetch("query_measure")
    the_ingredient.measure_ml = the_ingredient.measure * 29.5735
    the_ingredient.unit = "oz"

    if the_ingredient.valid?
      the_ingredient.save
      redirect_to("/modify_recipe_form/#{@recipe_id}", { :notice => "Alcoholic ingredient added successfully." })
    else
      redirect_to("/modify_recipe_form/#{@recipe_id}", { :alert => "#{the_ingredient.errors.full_messages.to_sentence}" })
    end
  end

  def update
    @recipe_id = params.fetch("query_recipe_id")
    the_id = params.fetch("query_ingredient_id")
    the_ingredient = Ingredient.where({ :id => the_id }).at(0)

    the_ingredient.alcohol_id = params.fetch("query_alcohol_id")
    the_ingredient.measure = params.fetch("query_measure")
    the_ingredient.measure_ml = the_ingredient.measure * 29.5735

    if the_ingredient.valid?
      the_ingredient.save
      redirect_to("/modify_recipe_form/#{@recipe_id}", { :notice => "Alcoholic ingredient updated successfully."} )
    else
      redirect_to("/modify_recipe_form/#{@recipe_id}", { :alert => "#{the_ingredient.errors.full_messages.to_sentence}" })
    end
  end

  def destroy
    @recipe_id = params.fetch("query_recipe_id")
    the_id = params.fetch("path_id")
    the_ingredient = Ingredient.where({ :id => the_id }).at(0)

    the_ingredient.destroy

    redirect_to("/modify_recipe_form/#{@recipe_id}", { :notice => "Alcoholic ingredient deleted successfully."} )
  end
end
