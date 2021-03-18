class AlcoholsController < ApplicationController


  
# ----------------------------------------------------------------------------------------------------------
  
  def index

    matching_alcohols = Alcohol.all

    @list_of_alcohols = matching_alcohols.order({ :created_at => :desc })

    render({ :template => "alcohols/index.html.erb" })

  end


  
# ----------------------------------------------------------------------------------------------------------

  def show

    the_id = params.fetch("path_id")

    matching_alcohols = Alcohol.where({ :id => the_id })

    @the_alcohol = matching_alcohols.at(0)

    render({ :template => "alcohols/show.html.erb" })

  end


  
# ----------------------------------------------------------------------------------------------------------

  def create_form

    if params.has_key?(:query_source_url) == false
      @source_url = "/bottles"

    else
      @source_url = params.fetch("query_source_url")

    end
    
    render({ :template => "alcohols/create_form.html.erb" })
    
  end


  
# ----------------------------------------------------------------------------------------------------------

  def create

    if params.has_key?(:query_source_url) == false
      @source_url = "/bottles"

    else
      @source_url = params.fetch("query_source_url")

    end
    
    the_alcohol = Alcohol.new
    the_alcohol.name = params.fetch("query_name").downcase

    if the_alcohol.valid?
      the_alcohol.save
      redirect_to("#{@source_url}", { :notice => "Alcohol created successfully." })

    else
      redirect_to("#{@source_url}", { :alert => "#{the_alcohol.errors.full_messages.to_sentence}" })

    end

  end


  
# ----------------------------------------------------------------------------------------------------------

  def update

    the_id = params.fetch("path_id")
    the_alcohol = Alcohol.where({ :id => the_id }).at(0)
    the_alcohol.name = params.fetch("query_name").downcase
    the_alcohol.description = params.fetch("query_description")

    if the_alcohol.valid?
      the_alcohol.save
      redirect_to("/alcohols/#{the_alcohol.id}", { :notice => "Alcohol updated successfully."} )

    else
      redirect_to("/alcohols/#{the_alcohol.id}", { :alert => "Alcohol failed to update successfully." })

    end

  end


  
# ----------------------------------------------------------------------------------------------------------

  def destroy

    the_id = params.fetch("path_id")

    the_alcohol = Alcohol.where({ :id => the_id }).at(0)

    the_alcohol.destroy

    redirect_to("/alcohols", { :notice => "Alcohol deleted successfully."} )

  end

end
