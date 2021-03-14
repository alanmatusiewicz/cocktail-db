# == Schema Information
#
# Table name: recipes
#
#  id          :integer          not null, primary key
#  iba_status  :boolean
#  name        :string
#  preparation :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
class Recipe < ApplicationRecord
  # Direct Associations
  belongs_to(:user, { :required => true })
  has_many(:ingredients, { :dependent => :destroy })
  has_many(:saved_recipes, { :dependent => :destroy })
  has_many(:na_ingredients, { :dependent => :destroy })

  # Indirect Associations
  has_many(:users, { :through => :saved_recipes, :source => :user })
  has_many(:alcohols, { :through => :ingredients, :source => :alcohol })

  # Validations
  validates(:name, { :presence => true })
  validates(:iba_status, { :inclusion => {:in => [true, false]}, :default => false })

  # Additional Methods
  def Recipe.all_ingredients
    full_list = Array.new
      Recipe.ingredients.order({ :measure_ml => :desc }).each do |a_ingredient|
        full_list.push(a_ingredient)
      end
      Recipe.na_ingredients.order({ :name => :desc }).each do |a_na_ingredient|
        full_list.push(a_na_ingredient)
      end
    
    return full_list    
  end
end
