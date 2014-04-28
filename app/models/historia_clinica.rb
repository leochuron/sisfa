# == Schema Information
#
# Table name: historia_clinicas
#
#  id          :integer          not null, primary key
#  numero      :integer
#  fecha       :date
#  paciente_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class HistoriaClinica < ActiveRecord::Base

#validations
  validates :fecha, :presence => true

#relations
	belongs_to :paciente
	has_many :registros  
	accepts_nested_attributes_for :registros, :paciente

#callbacks
before_validation :set_values
	
#methods
	def paciente_attributes=(attributes)
		if attributes[:cliente_attributes][:id].present?
			self.paciente = Paciente.new(:cliente_id => attributes[:cliente_attributes][:id])
		end
		super
	end

	def set_values
		self.registros.each do |f|
			f.fecha_de_ingreso = Time.now
		end
		if self.paciente.tipo == "familiar"
			self.paciente.estado = ""
			self.paciente.grado = ""
			self.paciente.pertenece_a = ""
			self.paciente.unidad = ""
		else if self.paciente.tipo == "civil"
			self.paciente.estado = ""
			self.paciente.grado = ""
			self.paciente.pertenece_a = ""
			self.paciente.unidad = ""
			self.paciente.parentesco = ""
			self.paciente.codigo_issfa = ""
		end
	end
	end
	
	def self.autocomplete(params)
		historias = HistoriaClinica.where("numero like ?", "%#{params}%")
    historias = historias.map do |historia|
      {
        :id => historia.paciente.cliente.id,
        :label => historia.numero.to_s+ " / " + historia.paciente.cliente.nombre,
        :value => historia.numero.to_s,
        :numero_de_identificacion => historia.paciente.cliente.numero_de_identificacion,
        :nombre => historia.paciente.cliente.nombre,
        :direccion => historia.paciente.cliente.direccion,
        :telefono => historia.paciente.cliente.telefono
      }
    end
    historias 
	end
end
