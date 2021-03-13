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
end
