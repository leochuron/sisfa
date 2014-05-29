# == Schema Information
#
# Table name: pacientes
#
#  id              :integer          not null, primary key
#  tipo            :string(255)
#  grado           :string(255)
#  estado          :string(255)
#  codigo_issfa    :string(255)
#  pertenece_a     :string(255)
#  unidad          :string(255)
#  parentesco      :string(255)
#  cliente_id      :integer
#  created_at      :datetime
#  updated_at      :datetime
#  n_hclinica      :integer
#  fecha_hclinica  :date
#  jefe_de_reparto :string(255)
#  afiliado        :string(255)
#  discapacidad    :string(255)
#

class Paciente < ActiveRecord::Base
	belongs_to :cliente
	has_many :condicions, dependent: :destroy
	has_many :turnos, dependent: :destroy
	has_one :informacion_adicional_paciente, dependent: :destroy
	accepts_nested_attributes_for :cliente, :informacion_adicional_paciente
	
	#callbacks
	before_validation :set_values

	#validation
	validates :tipo, :n_hclinica, :presence => true
  validates :cliente_id, :uniqueness =>  { :message => "Esta persona ya tiene una historia clinica" }
  validates :n_hclinica, :uniqueness =>  true

#methods
	def cliente_attributes=(attributes)
		if attributes['id'].present?
	    self.cliente = Cliente.find(attributes['id'])
	  end
	  super
	end

	def set_values
		self.fecha_hclinica = Time.now
	end

	def self.autocomplete(params)
    pacientes = Paciente.includes(:cliente).where("clientes.nombre like ?", "%#{params}%").references(:cliente)
    pacientes = pacientes.map do |paciente|
      {
        :id => paciente.id,
        :label => paciente.cliente.nombre + " / " + paciente.cliente.numero_de_identificacion,
        :value => paciente.cliente.nombre,
        :nombre => paciente.cliente.nombre,
        :cliente_id => paciente.cliente.id,
        :n_hclinica => paciente.n_hclinica
      }
    end
    pacientes 
  end

end
