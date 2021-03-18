class RecipesController < ApplicationController
  before_action(:get_inventory)
  before_action(:bar_check, { :only => [:index, :random_bar, :show] })


  
# ----------------------------------------------------------------------------------------------------------

  def get_inventory

    @bar = Array.new

    @current_user.bar.each do | a_alcohol |

      @bar.push( a_alcohol.id )

    end

  end


  
# ----------------------------------------------------------------------------------------------------------
  
  def bar_check

    @zero = Array.new
    @one = Array.new
    @two = Array.new
    @three = Array.new

    Recipe.all.each do | a_recipe |

      missing_count = 0

      a_recipe.ingredients.each do | a_ingredient |

        if @bar.exclude?( a_ingredient.alcohol_id )
          missing_count = missing_count + 1

        end

      end

      if missing_count == 0
        @zero.push( a_recipe.id )
        @one.push( a_recipe.id )
        @two.push( a_recipe.id )
        @three.push( a_recipe.id )

      elsif missing_count == 1
        @one.push( a_recipe.id )
        @two.push( a_recipe.id )
        @three.push( a_recipe.id )

      elsif missing_count == 2
        @two.push( a_recipe.id )
        @three.push( a_recipe.id )

      elsif missing_count == 3
        @three.push( a_recipe.id )

      end

    end

  end



# ----------------------------------------------------------------------------------------------------------

  def index

    if params.has_key?(:path_id)
      @query_missing_count = params.fetch("path_id")
      
      if @bar.length == 0
        @empty_bar = "true"

      elsif @query_missing_count == "0"
        @matching_recipes = Recipe.where({ :id => @zero })

      elsif @query_missing_count == "1"
        @matching_recipes = Recipe.where({ :id => @one })

      elsif @query_missing_count == "2"
        @matching_recipes = Recipe.where({ :id => @two })

      elsif @query_missing_count == "3"
        @matching_recipes = Recipe.where({ :id => @three })

      else
        @matching_recipes = Recipe.all

      end

    else
      @matching_recipes = Recipe.all

    end

    if @empty_bar == "true"
      redirect_to("/bottles", { :alert => "You need to add bottles before you can view your bar menu!"})

    else
      @list_of_recipes = @matching_recipes.order({ :name => :asc })

      render({ :template => "recipes/index.html.erb" })

    end

  end


  
# ----------------------------------------------------------------------------------------------------------

  def show

    the_id = params.fetch("path_id")

    matching_recipes = Recipe.where({ :id => the_id })

    @the_recipe = matching_recipes.at(0)

    @missing_count = 0

    @the_recipe.ingredients.each do | a_ingredient |

      if @bar.exclude?( a_ingredient.alcohol_id )
        @missing_count = @missing_count + 1

      end

    end

    render({ :template => "recipes/show.html.erb" })

  end


  
# ----------------------------------------------------------------------------------------------------------

  def create_form

    if params.has_key?(:query_source_url) == false
      @source_url = "/saved_recipes"

    else
      @source_url = params.fetch("query_source_url")

    end
    
    render({ :template => "/recipes/create_form.html.erb" })
    
  end



# ----------------------------------------------------------------------------------------------------------

  def create

    # @source_url = params.fetch("query_source_url")

    if params.has_key?(:query_iba_status) == false
      @iba_status = false

    else
      @iba_status = params.fetch("query_iba_status")

    end

    the_recipe = Recipe.new
    the_recipe.name = params.fetch("query_name")
    the_recipe.preparation = params.fetch("query_preparation")
    the_recipe.iba_status = @iba_status
    the_recipe.user_id = @current_user.id

    if the_recipe.valid?
      the_recipe.save
      redirect_to("/modify_recipe_form/#{the_recipe.id}", { :notice => "Recipe created successfully." })

    else
      redirect_to("/recipes", { :notice => "#{the_recipe.errors.full_messages.to_sentence}" })

    end

  end


    
# ----------------------------------------------------------------------------------------------------------

  def update

    the_id = params.fetch("path_id")

    the_recipe = Recipe.where({ :id => the_id }).at(0)

    if params.has_key?(:query_iba_status) == false
      @iba_status = false

    else
      @iba_status = params.fetch("query_iba_status")

    end

    the_recipe.name = params.fetch("query_name")
    the_recipe.preparation = params.fetch("query_preparation")
    the_recipe.iba_status = @iba_status

    if the_recipe.valid?
      the_recipe.save
      redirect_to("/recipes/#{the_recipe.id}", { :notice => "Recipe updated successfully."} )

    else
      redirect_to("/recipes/#{the_recipe.id}", { :alert => "#{the_recipe.errors.full_messages.to_sentence}" })

    end

  end


  
# ----------------------------------------------------------------------------------------------------------

  def update_form

    the_id = params.fetch("path_id")

    @the_recipe = Recipe.where({ :id => the_id }).at(0)

    @ingredient_count = @the_recipe.ingredients.count
    @na_ingredient_count = @the_recipe.na_ingredients.count

    if @the_recipe.iba_status == true
      @iba_status = "checked"

    end
    
    render({ :template => "recipes/update_form.html.erb" })

  end


  
# ----------------------------------------------------------------------------------------------------------

  def destroy

    the_id = params.fetch("path_id")

    the_recipe = Recipe.where({ :id => the_id }).at(0)

    the_recipe.destroy

    redirect_to("/recipes", { :notice => "Recipe deleted successfully."} )

  end


  
# ----------------------------------------------------------------------------------------------------------

  def random

    the_id = Recipe.all.sample.id
    
    redirect_to("/recipes/#{the_id}")

  end



# ----------------------------------------------------------------------------------------------------------

  def random_bar

    the_id = @zero.sample

    if @bar.length == 0
      redirect_to("/bottles", { :alert => "You need to add bottles before you can view a random recipe from your bar menu!"})

    else
      redirect_to("/recipes/#{the_id}")

    end

  end

end
