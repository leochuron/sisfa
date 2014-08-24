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
#  stock           :integer          default(0), not null
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
  has_many :factura_compras_productos
  has_many :factura_compras, :through => :factura_compras_productos
  has_many :canjes

#nested
  accepts_nested_attributes_for :ingreso_productos, :allow_destroy => true, reject_if: :all_blank

#methods

  def self.autocomplete_producto_compra(params)
    productos = Producto.where("nombre like ?", "%#{params}%")
    productos = productos.map do |producto|
    {
      :id => producto.id,
      :label => producto.nombre + " / " + producto.casa_comercial ,
      :value => producto.nombre,
      :precio_venta => producto.precio_venta,
      :precio_compra => producto.precio_compra,
      :ganancia => producto.ganancia,
      :codigo => producto.codigo,
      :casa_comercial => producto.casa_comercial,
      :categoria => producto.categoria,
      :iva => producto.hasiva,
      :nombre_generico => producto.nombre_generico
    }
    end
    productos
  end

  def ingreso_productos_attributes=(attributes)
    cantidad = 0
    attributes.each do |value,key|
      if key[:id]
        cantidad = 0 #is update
      else
        cantidad = cantidad + key[:cantidad].to_f
      end
    end
    self.stock = self.stock + cantidad
    super
  end

  def dinero_compra
    dinero = self.precio_compra * self.stock
  end

  def dinero_venta
    dinero = self.precio_venta * self.kardex.cantidad_salida
  end

  # def self.grouped_by_casa
  #   agrupados = []
  #   Producto.group("casa_comercial").each do |agrupado|
  #     agrupados << {:cantidad => agrupado.cantidad_disponible, :casa_comercial => agrupado.casa_comercial, :inversion => agrupado.precio_compra * agrupado.cantidad_disponible }
  #   end
  #   agrupados
  # end

  private
  def set_kardex
    Kardex.create(:producto => self, :fecha => Time.now)
  end

  def set_precios
    self.precio_venta = self.precio_compra * self.ganancia/100 + self.precio_compra
  end
end
