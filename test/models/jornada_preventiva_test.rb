# == Schema Information
#
# Table name: jornada_preventivas
#
#  id                               :integer          not null, primary key
#  inicio_atencion                  :datetime
#  fin_atencion                     :datetime
#  horas_trabajadas                 :datetime
#  doctor_id                        :integer
#  total_discapacitados             :integer          default(0)
#  total_hombre                     :integer          default(0)
#  total_mujer                      :integer          default(0)
#  total_blanco                     :integer          default(0)
#  total_mestizo                    :integer          default(0)
#  total_afroecuatoriano            :integer          default(0)
#  total_indigena                   :integer          default(0)
#  total_montubio                   :integer          default(0)
#  total_colombiano                 :integer          default(0)
#  total_peruano                    :integer          default(0)
#  total_otra_nacionalidad          :integer          default(0)
#  total_iess                       :integer          default(0)
#  total_issfa                      :integer          default(0)
#  total_ispol                      :integer          default(0)
#  total_otros_seguros              :integer          default(0)
#  total_aerea                      :integer          default(0)
#  total_naval                      :integer          default(0)
#  total_terrestre                  :integer          default(0)
#  total_activo                     :integer          default(0)
#  total_pasivo                     :integer          default(0)
#  total_aspirante                  :integer          default(0)
#  total_conscripto                 :integer          default(0)
#  total_activo_familiar            :integer          default(0)
#  total_pasivo_familiar            :integer          default(0)
#  total_derecho_hab                :integer          default(0)
#  total_civilies                   :integer          default(0)
#  total_prenatal_primera_10_19     :integer          default(0)
#  total_prenatal_primera_20_49     :integer          default(0)
#  total_prenatal_subsecuente_10_19 :integer          default(0)
#  total_prenatal_subsecuente_20_49 :integer          default(0)
#  total_partos                     :integer          default(0)
#  total_post_parto                 :integer          default(0)
#  total_primera_diu                :integer          default(0)
#  total_primera_go                 :integer          default(0)
#  total_primera_otros              :integer          default(0)
#  total_subsecuente_diu            :integer          default(0)
#  total_subsecuente_go             :integer          default(0)
#  total_subsecuente_otros          :integer          default(0)
#  total_cervico_uterino            :integer          default(0)
#  total_mamario                    :integer          default(0)
#  total_1_anio_primera             :integer          default(0)
#  total_1_4_anio_primera           :integer          default(0)
#  total_1_anio_subsecuente         :integer          default(0)
#  total_1_4_anio_subsecuente       :integer          default(0)
#  total_nino_consulta_p            :integer          default(0)
#  total_nino_consulta_s            :integer          default(0)
#  total_5_9_anios                  :integer          default(0)
#  total_10_14_anios                :integer          default(0)
#  total_15_19_anios                :integer          default(0)
#  total_20_49_anios                :integer          default(0)
#  total_50_64_anios                :integer          default(0)
#  total_65_anios                   :integer          default(0)
#  total_trabajadora_sexual         :integer          default(0)
#  total_certificado_medico         :integer          default(0)
#  created_at                       :datetime
#  updated_at                       :datetime
#

require 'test_helper'

class JornadaPreventivaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
