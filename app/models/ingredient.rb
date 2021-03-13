# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  measure    :float
#  measure_ml :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  alcohol_id :integer
#  recipe_id  :integer
#
class Ingredient < ApplicationRecord
end
