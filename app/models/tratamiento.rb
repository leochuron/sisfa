# == Schema Information
#
# Table name: tratamientos
#
#  id         :integer          not null, primary key
#  nombre     :string(255)
#  numeracion :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Tratamiento < ActiveRecord::Base
	validates :nombre, :presence => true 
end