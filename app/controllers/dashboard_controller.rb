class DashboardController < ApplicationController
  before_filter :require_login
  def index
    #estas son las consultas referentes a hoy... no olvides
    facturas_dia = consulta_facturas(Time.now.beginning_of_day..Time.now.end_of_day)
    @cantidad_dia_ventanilla = cantidad_facturas(facturas_dia, "ventanilla")
    @totaldia_ventanilla = valor_total_por_facturas(facturas_dia, "ventanilla")
    @cantidad_dia_consultaexterna = cantidad_facturas(facturas_dia, "consulta_externa")
    @totaldia_consultaexterna = valor_total_por_facturas(facturas_dia, "consulta_externa")
    @cantidad_dia_hospitalizacion = cantidad_facturas(facturas_dia, "hospitalizacion")
    @totaldia_hospitalizacion = valor_total_por_facturas(facturas_dia, "hospitalizacion")
    @totalfacturashoy = valor_total_facturas(facturas_dia)
    @cantidadfacturashoy = @cantidad_dia_ventanilla + @cantidad_dia_hospitalizacion + @cantidad_dia_consultaexterna
    @porcentajedia_ventanilla = regla_de_tres(@cantidad_dia_ventanilla, @cantidadfacturashoy)
    @porcentajedia_hospitalizacion = regla_de_tres(@cantidad_dia_hospitalizacion, @cantidadfacturashoy)
    @porcentajedia_consultaexterna = regla_de_tres(@cantidad_dia_consultaexterna, @cantidadfacturashoy)
    # raise 'error'
    #estas son las consultas referentes al mes
    facturas_mes = consulta_facturas(Time.now.beginning_of_month..Time.now.end_of_month)
    @cantidad_mes_ventanilla = cantidad_facturas(facturas_mes, "ventanilla")
    @totalmes_ventanilla = valor_total_por_facturas(facturas_mes, "ventanilla")
    @cantidad_mes_consultaexterna = cantidad_facturas(facturas_mes, "consulta_externa")
    @totalmes_consultaexterna = valor_total_por_facturas(facturas_mes, "consulta_externa")
    @cantidad_mes_hospitalizacion = cantidad_facturas(facturas_mes, "hospitalizacion")
    @totalmes_hospitalizacion = valor_total_por_facturas(facturas_mes, "hospitalizacion")
    @totalfacturasmes = valor_total_facturas(facturas_mes)
    @cantidadfacturasmes = @cantidad_mes_ventanilla + @cantidad_mes_hospitalizacion + @cantidad_mes_consultaexterna
    @porcentajemes_ventanilla = regla_de_tres(@cantidad_mes_ventanilla, @cantidadfacturasmes)
    @porcentajemes_hospitalizacion = regla_de_tres(@cantidad_mes_hospitalizacion, @cantidadfacturasmes)
    @porcentajemes_consultaexterna = regla_de_tres(@cantidad_mes_consultaexterna, @cantidadfacturasmes)
    # @facturasmes = Factura.where(:created_at => Time.now.beginning_of_month..Time.now.end_of_month)
    # @facturasmesventanilla = Factura.where(:created_at => Time.now.beginning_of_month..Time.now.end_of_month, :tipo => "ventanilla")
    # @facturasmeshospitalizacion = Factura.where(:created_at => Time.now.beginning_of_month..Time.now.end_of_month, :tipo => "hospitalizacion")
    # @facturasmesconsultaexterna = Factura.where(:created_at => Time.now.beginning_of_month..Time.now.end_of_month, :tipo => "consulta_externa")
    # @porcentajemes_ventanilla = regla_de_tres(@facturasmesventanilla,@facturasmes)
    # @porcentajemes_hospitalizacion = regla_de_tres(@facturasmeshospitalizacion,@facturasmes)
    # @porcentajemes_consultaexterna = regla_de_tres(@facturasmesconsultaexterna,@facturasmes)
    # # raise 'error'
    # #estas son las consultas referentes al año
    facturas_año = consulta_facturas(Time.now.beginning_of_year..Time.now.end_of_year)
    @cantidad_año_ventanilla = cantidad_facturas(facturas_año, "ventanilla")
    @totalaño_ventanilla = valor_total_por_facturas(facturas_año, "ventanilla")
    @cantidad_año_consultaexterna = cantidad_facturas(facturas_año, "consulta_externa")
    @totalaño_consultaexterna = valor_total_por_facturas(facturas_año, "consulta_externa")
    @cantidad_año_hospitalizacion = cantidad_facturas(facturas_año, "hospitalizacion")
    @totalaño_hospitalizacion = valor_total_por_facturas(facturas_año, "hospitalizacion")
    @totalfacturasaño = valor_total_facturas(facturas_año)
    @cantidadfacturasaño = @cantidad_año_ventanilla + @cantidad_año_hospitalizacion + @cantidad_año_consultaexterna
    @porcentajeaño_ventanilla = regla_de_tres(@cantidad_año_ventanilla, @cantidadfacturasaño)
    @porcentajeaño_hospitalizacion = regla_de_tres(@cantidad_año_hospitalizacion, @cantidadfacturasaño)
    @porcentajeaño_consultaexterna = regla_de_tres(@cantidad_año_consultaexterna, @cantidadfacturasaño)
    # @facturasaño = Factura.where(:created_at => Time.now.beginning_of_year..Time.now.end_of_year)
    # @facturasañoventanilla = Factura.where(:created_at => Time.now.beginning_of_year..Time.now.end_of_year, :tipo => "ventanilla")
    # @facturasañohospitalizacion = Factura.where(:created_at => Time.now.beginning_of_year..Time.now.end_of_year, :tipo => "hospitalizacion")
    # @facturasañoconsultaexterna = Factura.where(:created_at => Time.now.beginning_of_year..Time.now.end_of_year, :tipo => "consulta_externa")  
  end

  private

  def consulta_facturas(query)
    todasfacturas = Factura.where(:created_at => query)
    return :json => todasfacturas
  end

  def regla_de_tres (total_tipo_factura, total_facturas)
    if total_facturas == 0
      porcentaje = 0        
    else
      porcentaje = (100 * total_tipo_factura)/total_facturas
    end
  end

  def cantidad_facturas(facturas, tipo_factura)
    cantidad = 0
    facturas.each do |value, key|
      key.each do |factura|
        if factura.tipo == tipo_factura
          cantidad += 1
        end
      end
    end
    return cantidad
  end

  def valor_total_por_facturas(facturas, tipo_factura)
    total = 0
    facturas.each do |value, key|
      key.each do |factura|
        if factura.tipo == tipo_factura
          total += factura.total
        end
      end
    end
    return total
  end

  def valor_total_facturas(facturas)
    total = 0
    facturas.each do |value, key|
      key.each do |factura|
          total += factura.total
      end
    end
    return total
  end
end

