class AsignacionCamasController < ApplicationController
	before_action :find_hospitalizado, only: [:new, :create]

	def new
		@asignacion = AsignacionCama.new		
	end

	def index
	end

	def create
		@asignacion = AsignacionCama.new(asignacion_cama_params)
		@asignacion.hospitalizacion_registro = @hospitalizado
		if @asignacion.save
			redirect_to dashboard_enfermeria_index_path, :notice => "Almacenado"
		else
			redirect_to dashboard_enfermeria_index_path, :notice => "Error"
		end
	end

	private
	def asignacion_cama_params
		params.require(:asignacion_cama).permit :hospitalizacion_registro_id, :cama_id, :numero_cama
	end

	def find_hospitalizado
		@hospitalizado = HospitalizacionRegistro.find(params[:hospitalizacion_registro_id])
	end
end
