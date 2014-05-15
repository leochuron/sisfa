# == Schema Information
#
# Table name: condicions
#
#  id                       :integer          not null, primary key
#  paciente_id              :integer
#  doctor_id                :integer
#  medico_asignado          :string(255)
#  antecedentes_personales  :string(255)
#  antecedentes_familiares  :string(255)
#  enfermedad_actual        :string(255)
#  revision_organos_sistema :string(255)
#  presion_arterial         :string(255)
#  pulso                    :string(255)
#  temperatua               :string(255)
#  examen_fisico            :string(255)
#  diagnostico_1            :string(255)
#  diagnostico_2            :string(255)
#  planes                   :string(255)
#  created_at               :datetime
#  updated_at               :datetime
#

class Condicion < ActiveRecord::Base
end
