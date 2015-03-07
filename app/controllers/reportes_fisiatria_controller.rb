class ReportesFisiatriaController < ApplicationController
	def index
		@last_registros = ResultadoTratamiento.where(:atendido => true)
	end

	def personal
		@terapista = Personal.find(params[:personal])
		@start_date = params[:fecha_inicial]
		@end_date = params[:fecha_final]
		@resultados = ResultadoTratamiento.where(:personal_id => params[:personal], :created_at => params[:fecha_inicial].to_time.beginning_of_day..params[:fecha_final].to_time.end_of_day)
		respond_to do |format|
			format.js
			format.pdf do
				render :pdf => "reporte de terapista", :layout => 'report.html', :template => "reportes_fisiatria/reporte_personal.pdf.erb"
			end
		end
	end

	def paciente
		@paciente = Paciente.find(params[:paciente_id])
		@start_date = params[:fecha_inicial]
		@end_date = params[:fecha_final]
		@resultados =  ResultadoTratamiento.includes(:asignar_horario).where("asignar_horarios.paciente_id = #{@paciente.id} and atendido = true").references(:asignar_horario)
		respond_to do |format|
			format.js
			format.pdf do
				render :pdf => "reporte de paciente", :layout => 'report.html', :template => "reportes_fisiatria/reporte_paciente.pdf.erb", :orientation => 'Landscape'
			end
		end
	end

	def factura
		@start_date = params[:fecha_inicial]
		@end_date = params[:fecha_final]
		@resultados =  AsignarHorario.where(:created_at => params[:fecha_inicial].to_time.beginning_of_day..params[:fecha_final].to_time.end_of_day)
		respond_to do |format|
			format.js
			format.pdf do
				render :pdf => "reporte de factura", :layout => 'report.html', :template => "reportes_fisiatria/reporte_factura.pdf.erb"
			end
		end
	end
end
