# == Schema Information
#
# Table name: bottles
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  alcohol_id :integer
#  user_id    :integer
#
class Bottle < ApplicationRecord
end
