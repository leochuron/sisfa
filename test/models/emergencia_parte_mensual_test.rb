# == Schema Information
#
# Table name: emergencia_parte_mensuals
#
#  id                           :integer          not null, primary key
#  doctor_id                    :integer
#  total_hombre                 :integer          default(0)
#  total_mujer                  :integer          default(0)
#  total_aerea                  :integer          default(0)
#  total_naval                  :integer          default(0)
#  total_terrestre              :integer          default(0)
#  total_militar_sa             :integer          default(0)
#  total_militar_sp             :integer          default(0)
#  total_militar_asp            :integer          default(0)
#  total_militar_cpto           :integer          default(0)
#  total_familiar_sa            :integer          default(0)
#  total_familiar_sp            :integer          default(0)
#  total_familiar_hab           :integer          default(0)
#  total_civil_convenio         :integer          default(0)
#  total_civil_particular       :integer          default(0)
#  total_memor_1_anio           :integer          default(0)
#  total_1_4_anios              :integer          default(0)
#  total_5_9_anios              :integer          default(0)
#  total_10_44_anios            :integer          default(0)
#  total_15_19_anios            :integer          default(0)
#  total_20_49_anios            :integer          default(0)
#  total_50_64_anios            :integer          default(0)
#  total_65_anios               :integer          default(0)
#  total_atencion_clinico       :integer          default(0)
#  total_atencion_quirurjico    :integer          default(0)
#  total_atencion_obstetrico    :integer          default(0)
#  total_atencion_traumatologia :integer          default(0)
#  total_accidente              :integer          default(0)
#  total_envenenamiento         :integer          default(0)
#  total_violencia              :integer          default(0)
#  total_otras                  :integer          default(0)
#  total_destino_alta           :integer          default(0)
#  total_destino_consulta       :integer          default(0)
#  total_destino_observacion    :integer          default(0)
#  total_destino_internamiento  :integer          default(0)
#  total_destino_tr_sal         :integer          default(0)
#  total_destino_tr_nom         :integer          default(0)
#  created_at                   :datetime
#  updated_at                   :datetime
#

require 'test_helper'

class EmergenciaParteMensualTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
