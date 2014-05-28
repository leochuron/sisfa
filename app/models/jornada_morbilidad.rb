# == Schema Information
#
# Table name: jornada_morbilidads
#
#  id                           :integer          not null, primary key
#  inicio_atencion              :datetime
#  fin_atencion                 :datetime
#  horas_trabajadas             :datetime
#  doctor_id                    :integer
#  total_discapacitados         :integer          default(0)
#  total_hombre                 :integer          default(0)
#  total_mujer                  :integer          default(0)
#  total_blanco                 :integer          default(0)
#  total_mestizo                :integer          default(0)
#  total_afroecuatoriano        :integer          default(0)
#  total_indigena               :integer          default(0)
#  total_montubio               :integer          default(0)
#  total_colombiano             :integer          default(0)
#  total_peruano                :integer          default(0)
#  total_otra_nacionalidad      :integer          default(0)
#  total_iess                   :integer          default(0)
#  total_issfa                  :integer          default(0)
#  total_ispol                  :integer          default(0)
#  total_otros_seguros          :integer          default(0)
#  total_aerea                  :integer          default(0)
#  total_naval                  :integer          default(0)
#  total_terrestre              :integer          default(0)
#  total_activo                 :integer          default(0)
#  total_pasivo                 :integer          default(0)
#  total_aspirante              :integer          default(0)
#  total_conscripto             :integer          default(0)
#  total_activo_familiar        :integer          default(0)
#  total_pasivo_familiar        :integer          default(0)
#  total_derecho_hab            :integer          default(0)
#  total_civilies               :integer          default(0)
#  total_atencion_primera       :integer          default(0)
#  total_atencion_subsecuente   :integer          default(0)
#  total_atencion_interconsulta :integer          default(0)
#  total_memor_1_mes            :integer          default(0)
#  total_memor_1_11_mes         :integer          default(0)
#  total_1_4_anios              :integer          default(0)
#  total_5_9_anios              :integer          default(0)
#  total_10_44_anios            :integer          default(0)
#  total_15_19_anios            :integer          default(0)
#  total_20_49_anios            :integer          default(0)
#  total_50_64_anios            :integer          default(0)
#  total_65_anios               :integer          default(0)
#  total_presuntivo             :integer          default(0)
#  total_inicial                :integer          default(0)
#  total_control                :integer          default(0)
#  total_interconsulta          :integer          default(0)
#  total_referencia             :integer          default(0)
#  total_certificado_medico     :integer          default(0)
#  created_at                   :datetime
#  updated_at                   :datetime
#

class JornadaMorbilidad < ActiveRecord::Base

	belongs_to :doctor
	before_create :set_values

	def set_values
		horas = self.fin_atencion - self.inicio_atencion
		self.horas_trabajadas = Time.now.beginning_of_day + horas.to_i - 5.hour #config local zone -5
		consultas = ConsultaExternaMorbilidad.where(:doctor_id => self.doctor, :created_at => Time.now.beginning_of_day..Time.zone.now)
		valores = calculate(consultas)
		self.total_hombre = valores[0]
    self.total_mujer = valores[1]
    self.total_blanco = valores[2]
    self.total_mestizo = valores[3]
    self.total_afroecuatoriano = valores[4]
    self.total_indigena = valores[5]
    self.total_montubio = valores[6]
    self.total_colombiano = valores[7]
    self.total_peruano = valores[8]
    self.total_otra_nacionalidad = valores[9]
    self.total_iess = valores[0]
    self.total_issfa = valores[0]
    self.total_ispol = valores[0]
    self.total_otros_seguros = valores[0]
		# values = [ejerct, avcn, marn,civil, mil_activo, mil_pasivo, mil_aspirante, mil_conscripto, fam,const_primera, const_sub, const_intc,edad_1, edad_1_4, edad_5_9, edad_10_14, edad_15_19, edad_20_49, edad_50_64, edad_65,condc_presuntivo, condc_confirmado, condc_control,ordn_intc, ordn_ref, certificado]
    self.total_terrestre             = valores[10]		
    self.total_aerea                 = valores[11]
    self.total_naval                 = valores[12]
    self.total_activo                = valores[0]
    self.total_pasivo                = valores[0]
    self.total_aspirante             = valores[0]
    self.total_conscripto            = valores[0]
    self.total_activo_familiar       = valores[0]
    self.total_pasivo_familiar       = valores[0]
    self.total_derecho_hab           = valores[0]
    self.total_civilies              = valores[0]
    self.total_atencion_primera      = valores[0]
    self.total_atencion_subsecuente  = valores[0]
    self.total_atencion_interconsulta= valores[0]
    self.total_memor_1_mes           = valores[0]
    self.total_memor_1_11_mes        = valores[0]
    self.total_1_4_anios             = valores[0]
    self.total_5_9_anios             = valores[0]
    self.total_10_44_anios           = valores[0]
    self.total_15_19_anios           = valores[0]
    self.total_20_49_anios           = valores[0]
    self.total_50_64_anios           = valores[0]
    self.total_65_anios              = valores[0]
    self.total_presuntivo            = valores[0]
    self.total_inicial               = valores[0]
    self.total_control               = valores[0]
    self.total_interconsulta         = valores[0]
    self.total_referencia            = valores[0]
    self.total_certificado_medico    = valores[0]
		raise
	end

	private

	def calculate(consultas)
		m, f = 0,0
		blanco, mestz, afro, indg, montb = 0,0,0,0
		colbn, prn, otro_ncl = 0,0,0
		ejerct, avcn, marn = 0,0,0
		civil, mil_activo, mil_pasivo, mil_aspirante, mil_conscripto, fam_activo, fam_pasivo, fam_der = 0,0,0,0,0,0,0,0
		const_primera, const_sub, const_intc = 0,0,0
		edad_1, edad_1_4, edad_5_9, edad_10_14, edad_15_19, edad_20_49, edad_50_64, edad_65 = 0,0,0,0,0,0,0,0
		condc_presuntivo, condc_confirmado, condc_control = 0,0,0		
		ordn_intc, ordn_ref, certificado = 0,0,0
		consultas.each do |c|
			#total sexo
			if c.paciente.cliente.sexo == "Masculino"
				m = m + 1
			else
				f = f + 1
			end
			#total raza
			case c.paciente.informacion_adicional_paciente.raza
			when "Blanco"
				blanco += 1
			when "Mestizo"
				mestz += 1
			when "Afroecuatoriano/Afrodesenciende"
				afro += 1
			when "Indigena"
				indg += 1
			when "Montubio"
				montb += 1
			end
			#total nacionalidad
			case c.paciente.informacion_adicional_paciente.nacionalidad
			when "Colombiano"
				colbn += 1
			when "Peruano"
				prn += 1
			when "Otro"
				otro_ncl += 1
			end
			#total fuerza
			case c.paciente.pertenece_a
			when "Ejercito"
				ejerct += 1
			when "Aviacion"
				avcn += 1
			when "Marina"
				marn += 1
			end
			#total tipo paciente
			case c.paciente.tipo
			when "civil"
				civil += 1
			when "militar"
				case c.paciente.estado
				when "Activo"
					mil_activo += 1
				when "Pasivo"
					mil_pasivo += 1
				when "Aspirante"
					mil_aspirante += 1
				when "Conscripto"
					mil_conscripto += 1
				end
			when "familiar"
				case c.paciente.estado
				when "Activo"
					fam_activo += 1
				when "Pasivo"
					fam_pasivo += 1
				when "Derecho hab"
					fam_der += 1
				end
			end
			#total atencion
			case c.tipo_de_atencion
			when "Primera"
				const_primera += 1
			when "Subsecuente"
				const_sub += 1
			when "Interconsulta Realizada"
				const_intc += 1
			end
			#total edad
			case c.grupos_de_edad
			when "1 AÑO"
				edad_1 += 1
			when "1-4 AÑOS"
				edad_1_4 += 1
			when "5-9 AÑOS"
				edad_5_9 += 1
			when "10-14 AÑOS"
				edad_10_14 += 1
			when "15-19 AÑOS"
				edad_15_19 += 1
			when "20-49 AÑOS"
				edad_20_49 += 1
			when "50-64 AÑOS"
				edad_50_64 += 1
			when "65 AÑOS +"
				edad_65 += 1
			end
			#total condicion_diagnostico
			case c.condicion_diagnostico
			when "Presuntivo/Sospechoso"
				condc_presuntivo += 1
			when "Definitivo/Inicial/Confirmado"
				condc_confirmado+= 1
			when "Definitivo/Control"
				condc_control += 1
			end
			#total ordenes
			if c.ordenes == "Interconsulta Solicitada"
				ordn_intc += 1
			else
				ordn_ref += 1
			end
			#total certificado
			if c.certificado_medico == true
				certificado += 1
			end
		end
		values = [m,f,blanco,mestz,afro,indg,montb,colbn,prn,otro_ncl,ejerct, avcn, marn,civil, mil_activo, mil_pasivo, mil_aspirante, mil_conscripto, fam,const_primera, const_sub, const_intc,edad_1, edad_1_4, edad_5_9, edad_10_14, edad_15_19, edad_20_49, edad_50_64, edad_65,condc_presuntivo, condc_confirmado, condc_control,ordn_intc, ordn_ref, certificado]
		# raise
	end
end
