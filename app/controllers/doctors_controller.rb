class DoctorsController < ApplicationController
	before_filter :require_login
	before_filter :suspendido
	before_action :set_doctor, only: [:show, :edit, :update, :destroy, :turnos_dia, :turnos_manana]

	def index
		@doctores = Doctor.all
	end

	def show
	end

	def new
		@doctor = Doctor.new
    respond_to do |format|
      format.js{ render "new_or_edit" }
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

  def autocomplete
    respond_to do |format|
      format.json { render :json => Doctor.autocomplete(params[:term]) }
    end
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
		params.require(:doctor).permit(:nombre, :especialidad, :cantidad_turno)
	end
end
