class PacientesController < ApplicationController
	before_action :set_paciente, only: [:show]

	def index
		respond_to do |format|
      format.html
      format.json { render json: PacientesDatatable.new(view_context) }
    end
	end

	def show
	end

	def new
		@paciente= Paciente.new
		@paciente.registros.build
		@paciente.build_cliente
		@paciente.build_informacion_adicional_paciente
	end
	
	def create
		@paciente = Paciente.new(paciente_params)
		if @paciente.save
			redirect_to pacientes_path, :notice => "Almacenado"
		else
			render action: 'new'
		end
	end

	def update
		respond_to do |format|
			@paciente.update(cliente_params)
			format.js { render "success"}
		end
	end

	private

	def paciente_params
		params.require(:paciente).permit :tipo,
			:n_hclinica,
			:grado,
			:estado,
			:codigo_issfa,
			:pertenece_a,
			:unidad,
			:parentesco,
			:cliente_attributes => [
				:id,
				:fecha_de_nacimiento,
				:nombre,
				:direccion,
				:telefono,
				:numero_de_identificacion,
				:sexo,
				:edad,
				:estado_civil
			],
			:informacion_adicional_paciente_attributes => [
				:ciudad,
				:provincia,
				:canton,
				:jefe_de_reparto,
				:familiar_cercano,
				:familiar_direccion,
				:familiar_telefono,
				:observacion,
				:paciente_id
			],
			:registros_attributes => [
				:especialidad,
				:medico_asignado
			]
	end

	def set_paciente
		@paciente = Paciente.find(params[:id])
	end
end
