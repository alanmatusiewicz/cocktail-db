class NaIngredientsController < ApplicationController


  
# ----------------------------------------------------------------------------------------------------------
  
  def index

    matching_na_ingredients = NaIngredient.all

    @list_of_na_ingredients = matching_na_ingredients.order({ :created_at => :desc })

    render({ :template => "na_ingredients/index.html.erb" })

  end


  
# ----------------------------------------------------------------------------------------------------------

  def show

    the_id = params.fetch("path_id")

    matching_na_ingredients = NaIngredient.where({ :id => the_id })

    @the_na_ingredient = matching_na_ingredients.at(0)

    render({ :template => "na_ingredients/show.html.erb" })

  end


  
# ----------------------------------------------------------------------------------------------------------

  def create

    @recipe_id = params.fetch("query_recipe_id")

    the_na_ingredient = NaIngredient.new
    the_na_ingredient.recipe_id = @recipe_id
    the_na_ingredient.name = params.fetch("query_name").downcase
    the_na_ingredient.measure = params.fetch("query_measure").downcase
    the_na_ingredient.unit = params.fetch("query_unit").downcase

    if the_na_ingredient.valid?
      the_na_ingredient.save
      redirect_to("/modify_recipe_form/#{@recipe_id}", { :notice => "Non-alcoholic ingredient added successfully." })

    else
      redirect_to("/modify_recipe_form/#{@recipe_id}", { :alert => "#{the_na_ingredient.errors.full_messages.to_sentence}" })

    end

  end


  
# ----------------------------------------------------------------------------------------------------------

  def update

    @recipe_id = params.fetch("query_recipe_id")

    the_id = params.fetch("path_id")

    the_na_ingredient = NaIngredient.where({ :id => the_id }).at(0)

    the_na_ingredient.name = params.fetch("query_name").downcase
    the_na_ingredient.measure = params.fetch("query_measure").downcase
    the_na_ingredient.unit = params.fetch("query_unit").downcase

    if the_na_ingredient.valid?
      the_na_ingredient.save
      redirect_to("/modify_recipe_form/#{@recipe_id}", { :notice => "Non-alcoholic ingredient updated successfully."} )

    else
      redirect_to("/modify_recipe_form/#{@recipe_id}", { :alert => "#{the_na_ingredient.errors.full_messages.to_sentence}" })

    end

  end


  
# ----------------------------------------------------------------------------------------------------------

  def destroy

    @recipe_id = params.fetch("query_recipe_id")

    the_id = params.fetch("path_id")

    the_na_ingredient = NaIngredient.where({ :id => the_id }).at(0)

    the_na_ingredient.destroy

    redirect_to("/modify_recipe_form/#{@recipe_id}", { :notice => "Non-alcoholic ingredient deleted successfully."} )

  end
  
end
