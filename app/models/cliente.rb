# == Schema Information
#
# Table name: clientes
#
#  id                       :integer          not null, primary key
#  nombre                   :string(255)
#  direccion                :string(255)
#  numero_de_identificacion :string(255)
#  telefono                 :string(255)
#  email                    :string(255)
#  created_at               :datetime
#  updated_at               :datetime
#

class Cliente < ActiveRecord::Base

#validations

# relationships
	has_one :user
	has_many :proformas
	has_many :facturas

#method

end
