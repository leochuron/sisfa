# == Schema Information
#
# Table name: productos
#
#  id              :integer          not null, primary key
#  nombre          :string(255)      not null
#  codigo          :string(255)
#  categoria       :string(255)
#  casa_comercial  :string(255)
#  nombre_generico :string(255)
#  precio_compra   :decimal(4, 2)    not null
#  precio_venta    :decimal(4, 2)    not null
#  ganancia        :decimal(4, 2)    not null
#  hasiva          :boolean          default(FALSE)
#

class Producto < ActiveRecord::Base

#callbacks 
  before_create :set_precios
  before_update :set_precios
  after_create :set_kardex

#validations  
  validates :nombre, :ganancia, :precio_compra, :presence => true
  validates :nombre, :length => { :maximum => 100 }
 
#relations
  has_many :ingreso_productos
  has_one :kardex
  has_one :factura_compras_producto

#nested
  accepts_nested_attributes_for :ingreso_productos, :allow_destroy => true, reject_if: :all_blank

#methods

  def cantidad_disponible
    unless self.ingreso_productos.empty? then self.ingreso_productos.sum(:cantidad) else 0 end
  end

  private
  def set_kardex
    Kardex.create(:producto => self, :fecha => Time.now)
  end

  def set_precios
    self.precio_venta = self.precio_compra * self.ganancia/100 + self.precio_compra
  end
end
