module DashboardHospitalHelper
	def estadisticas(date)
		@emergencias = EmergenciaRegistro.where(:created_at => date).count()
		@turnos = Turno.where(:fecha => date, :atendido => true).count()
		@hospitalizados = HospitalizacionRegistro.where(:created_at => date).count()
		@preventivas = ConsultaExternaPreventiva.where(:created_at => date).count()
		@morbilidads = ConsultaExternaMorbilidad.where(:created_at => date).count()
	end

# make space calendar
	def number_space(date)
		number = 0
		day = date.beginning_of_month.strftime("%a")
		case day
		when "Sun"
			number = 6
		when "Sat"
			number = 5
		when "Fri"
			number = 4
		when "Thu"
			number = 3
		when "Wed"
			number = 2
		when "Thu"
			number = 1
		when "Mon"					
			number = 0
		end
		number
	end
	
#numero de dias del mes
	def numero_dias(date)
		numero_mes = date.strftime("%m").to_i
    (Date.new(Time.now.year,12,31).to_date<<(12-numero_mes)).day
  end
end
