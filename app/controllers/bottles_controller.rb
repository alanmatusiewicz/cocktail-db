class BottlesController < ApplicationController
  def index
    matching_bottles = Bottle.where({ :user_id => @current_user.id })

    @list_of_bottles = matching_bottles.order({ :name => :asc })

    render({ :template => "bottles/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_bottles = Bottle.where({ :id => the_id })

    @the_bottle = matching_bottles.at(0)

    render({ :template => "bottles/show.html.erb" })
  end

  def create
    the_bottle = Bottle.new
    the_bottle.user_id = @current_user.id
    the_bottle.alcohol_id = params.fetch("query_alcohol_id")

    if the_bottle.valid?
      the_bottle.save
      redirect_to("/bottles", { :notice => "Bottle created successfully." })
    else
      redirect_to("/bottles", { :notice => "Bottle failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_bottle = Bottle.where({ :id => the_id }).at(0)

    the_bottle.user_id = @current_user.id
    the_bottle.alcohol_id = params.fetch("query_alcohol_id")

    if the_bottle.valid?
      the_bottle.save
      redirect_to("/bottles/#{the_bottle.id}", { :notice => "Bottle updated successfully."} )
    else
      redirect_to("/bottles/#{the_bottle.id}", { :alert => "Bottle failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_bottle = Bottle.where({ :id => the_id }).at(0)

    the_bottle.destroy

    redirect_to("/bottles", { :notice => "Bottle deleted successfully."} )
  end
end
