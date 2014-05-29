class DoctorsController < ApplicationController
	before_filter :require_login
	before_filter :suspendido
	before_action :set_doctor, only: [:edit, :update, :destroy, :turnos_dia, :turnos_manana, :suspender, :pacientes_emergencia]

	def index
		@doctores = Doctor.all
	end

	def dashboard
		@doctor = current_user.cliente.doctor
		@turnos_hoy = @doctor.turnos.turnos_today
		@turnos_manana = @doctor.turnos.turnos_tomorrow
		@pacientes = @doctor.emergencia_registros
		@enviado = @doctor.jornada_morbilidads.was_send
	end

	def autocomplete
    respond_to do |format|
      format.json { render :json => Doctor.autocomplete(params[:term]) }
    end
  end

	def new
		@doctor = Doctor.new
		@doctor.build_cliente
    respond_to do |format|
      format.js{ render "new_or_edit" }
    end
	end
	
	def pacientes_emergencia
		@fecha = Time.now.to_date
		@pacientes = @doctor.emergencia_registros
		respond_to do |format|
			format.html
			format.js
		end
	end

	def turnos_dia
		@fecha = Time.now.to_date
		@turnos = @doctor.turnos.turnos_today
		respond_to do |format|
			format.html
			format.js
			format.pdf do
				render :pdf => "turnos de hoy", :layout => 'report.html', :template => "doctors/lista_turnos.pdf.erb"
			end
		end
	end

	def turnos_manana
		@fecha = Time.now.tomorrow.to_date
		@turnos = @doctor.turnos.turnos_tomorrow
		respond_to do |format|
			format.html
			format.js
			format.pdf do
				render :pdf => "turnos de manana", :layout => 'report.html', :template => "doctors/lista_turnos.pdf.erb"
			end
		end
	end

	def imprimir_listado
		@fecha = Time.now.to_date
		@lista = Doctor.list_turnos_all_doctor
		respond_to do |format|
			format.html
			format.pdf do
				render :pdf => "turnos doctores", :layout => 'report.html', :template => "doctors/imprimir_listado.pdf.erb"
			end
		end
	end
  
  def suspender
    if @doctor.suspendido
      @doctor.suspendido = false
    else
      @doctor.suspendido = true
    end
    @doctor.save
    redirect_to doctors_path, :notice => "Doctor modificado"    
  end

  def jornada_morbilidad
  	
  end

	def edit
		respond_to do |format|
      format.js { render "new_or_edit"}
    end
	end

	def create
		@doctor = Doctor.new(doctor_params)
    respond_to do |format|
      @doctor.save
      format.js { 
				@doctores = Doctor.all
      	render "success"
      }
    end
	end

  def update
    respond_to do |format|
      @doctor.update(doctor_params)
      format.html
      format.js { 
				@doctores = Doctor.all
      	render "success"
      }
    end
  end

	def destroy
		@doctor.destroy
		respond_to do |format|
			format.html { redirect_to doctors_url }
		end
	end

	private

	def set_doctor
		@doctor = Doctor.find(params[:id])
	end

	def doctor_params
		params.require(:doctor).permit :especialidad,
		 :cantidad_turno,
		 :suspendido,
		 :cliente_attributes => [
				:id,
				:nombre,
				:direccion,
				:telefono,
				:numero_de_identificacion
			]
	end
end
