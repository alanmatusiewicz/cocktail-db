class SavedRecipesController < ApplicationController
  def index
    matching_saved_recipes = SavedRecipe.where({ :user_id => @current_user.id })

    @list_of_saved_recipes = matching_saved_recipes.order({ :name => :asc })

    matching_recipes = Recipe.where({ :user_id => @current_user.id })

    @list_of_recipes = matching_recipes.order({ :name => :asc })
    
    matching_recipes = Recipe.where({ :user_id => @current_user.id })
  end

  def show
    the_id = params.fetch("path_id")

    matching_saved_recipes = SavedRecipe.where({ :id => the_id })

    @the_saved_recipe = matching_saved_recipes.at(0)

    render({ :template => "saved_recipes/show.html.erb" })
  end

  def create
    the_saved_recipe = SavedRecipe.new
    the_saved_recipe.user_id = @current_user.id
    the_saved_recipe.recipe_id = params.fetch("query_recipe_id")

    if the_saved_recipe.valid?
      the_saved_recipe.save
      redirect_to("/saved_recipes", { :notice => "Saved recipe created successfully." })
    else
      redirect_to("/saved_recipes", { :notice => "Saved recipe failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_saved_recipe = SavedRecipe.where({ :id => the_id }).at(0)

    the_saved_recipe.user_id = @current_user.id
    the_saved_recipe.recipe_id = params.fetch("query_recipe_id")

    if the_saved_recipe.valid?
      the_saved_recipe.save
      redirect_to("/saved_recipes/#{the_saved_recipe.id}", { :notice => "Saved recipe updated successfully."} )
    else
      redirect_to("/saved_recipes/#{the_saved_recipe.id}", { :alert => "Saved recipe failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_saved_recipe = SavedRecipe.where({ :id => the_id }).at(0)

    the_saved_recipe.destroy

    redirect_to("/saved_recipes", { :notice => "Saved recipe deleted successfully."} )
  end
end
