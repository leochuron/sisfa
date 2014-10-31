class TurnosController < ApplicationController
	before_filter :require_login
	before_filter :is_admin_or_auxiliar_estadistica
	before_action :set_turno, only: [:atendido, :destroy]
	before_action :find_user, only: [:index]

	def index
		@doctores = Doctor.turnos_doctores
	end

	def hoy
		respond_to do |format|
			@turnos = Doctor.list_turnos_query(Time.now.beginning_of_day..Time.now.end_of_day)
			@fecha =  Time.now
			format.html
			format.pdf do
				render :pdf => "turnos de hoy", :layout => 'report.html', :template => "turnos/print_turnos.html.erb"
			end
		end
	end

	def manana
		@turnos = Doctor.list_turnos_query(Time.now.tomorrow.beginning_of_day..3.days.from_now.end_of_day)
		respond_to do |format|
			format.html
			format.pdf do
				render :pdf => "turnos de manana", :layout => 'report.html', :template => "turnos/print_turnos.html.erb"
			end
		end
	end

	def consulta_turnos
	end

	def consulta_resultados
		@start_date = params[:fecha_inicial]
		@end_date = params[:fecha_final]
		@turnos = Doctor.list_turnos_query(params[:fecha_inicial].to_time.beginning_of_day..params[:fecha_final].to_time.end_of_day)
		respond_to do |format|
			format.js
			format.pdf do
				render :pdf => "turnos consulta", :layout => 'report.html', :template => "turnos/print_resultados.html.erb"
			end
		end
	end

	def new
		@turno = Turno.new
		respond_to do |format|
			format.js
		end
	end

	def create
		@turno = Turno.new(turno_params)
		respond_to do |format|
			@turno.save
			format.js {
				@doctores = Doctor.turnos_doctores
				render "success"
			}
		end
	end

	def destroy
		@turno.destroy
		respond_to do |format|
			format.html { redirect_to turnos_url }
		end
	end
	
	private

	def turno_params
		params.require(:turno).permit :fecha,
		:hora,
		:doctor_a_cargo,
		:numero,
		:atendido,
		:paciente_id,
		:doctor_id
	end

	def set_turno
		@turno = Turno.find(params[:id])
	end

	def find_user #views
		if current_user.rol == Rol.administrador_estadistica or current_user.rol == Rol.administrador
			@permiso = true
		else
			@permiso = false
		end
	end
end
