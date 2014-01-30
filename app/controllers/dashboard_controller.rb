class DashboardController < ApplicationController
  before_filter :require_login
  def index
    #estas son las consultas referentes a hoy... no olvides
    @facturas_dia = consulta_facturas(Time.now.beginning_of_day..Time.now.end_of_day,"compra")
    @cantidad_dia_ventanilla = cantidad_facturas(@facturas_dia, "ventanilla")
    @totaldia_ventanilla = valor_total_por_facturas(@facturas_dia, "ventanilla")
    @cantidad_dia_consultaexterna = cantidad_facturas(@facturas_dia, "consulta_externa")
    @totaldia_consultaexterna = valor_total_por_facturas(@facturas_dia, "consulta_externa")
    @cantidad_dia_hospitalizacion = cantidad_facturas(@facturas_dia, "hospitalizacion")
    @totaldia_hospitalizacion = valor_total_por_facturas(@facturas_dia, "hospitalizacion")
    @totalfacturashoy = valor_total_facturas(@facturas_dia)
    @cantidadfacturashoy = @cantidad_dia_ventanilla + @cantidad_dia_hospitalizacion + @cantidad_dia_consultaexterna
    @porcentajedia_ventanilla = regla_de_tres(@cantidad_dia_ventanilla, @cantidadfacturashoy)
    @porcentajedia_hospitalizacion = regla_de_tres(@cantidad_dia_hospitalizacion, @cantidadfacturashoy)
    @porcentajedia_consultaexterna = regla_de_tres(@cantidad_dia_consultaexterna, @cantidadfacturashoy)
    #estas son las consultas referentes al mes
    facturas_mes = consulta_facturas(Time.now.beginning_of_month..Time.now.end_of_month, "compra")
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
    end

  def generar_reporte
    @start_date = params[:fecha_inicial]
    @end_date = params[:fecha_final]
    @tipo_factura = params[:tipo_factura]
    @search = Factura.where(:fecha_de_emision => params[:fecha_inicial].to_time.beginning_of_day..params[:fecha_final].to_time.end_of_day, :tipo => params[:tipo_factura]).where(:anulada => false)
    render :pdf => "reporte", :layout => 'report.html', :template => "dashboard/generar_reporte", :orientation => 'Landscape'
  end

  def cierre_de_caja_dia
    @facturas_dia = consulta_facturas(Time.now.beginning_of_day..Time.now.end_of_day,"compra")
    @cantidad_dia_ventanilla = cantidad_facturas(@facturas_dia, "ventanilla")
    @totaldia_ventanilla = valor_total_por_facturas(@facturas_dia, "ventanilla")
    @cantidad_dia_consultaexterna = cantidad_facturas(@facturas_dia, "consulta_externa")
    @totaldia_consultaexterna = valor_total_por_facturas(@facturas_dia, "consulta_externa")
    @cantidad_dia_hospitalizacion = cantidad_facturas(@facturas_dia, "hospitalizacion")
    @totaldia_hospitalizacion = valor_total_por_facturas(@facturas_dia, "hospitalizacion")
    @totalfacturashoy = valor_total_facturas(@facturas_dia)
    @cantidadfacturashoy = @cantidad_dia_ventanilla + @cantidad_dia_hospitalizacion + @cantidad_dia_consultaexterna
    @ventanilla_subtotal = sumar_impuesto(@facturas_dia, "ventanilla", "subtotal_0")
    @hospitalizacion_subtotal = sumar_impuesto(@facturas_dia, "hospitalizacion", "subtotal_0")
    @consultaexterna_subtotal = sumar_impuesto(@facturas_dia, "consulta_externa", "subtotal_0")
    @total_subtotal = @ventanilla_subtotal + @hospitalizacion_subtotal + @consultaexterna_subtotal
    @ventanilla_iva = sumar_impuesto(@facturas_dia, "ventanilla", "iva")
    @hospitalizacion_iva = sumar_impuesto(@facturas_dia, "hospitalizacion", "iva")
    @consultaexterna_iva = sumar_impuesto(@facturas_dia, "consulta_externa", "iva")
    @total_iva = @ventanilla_iva + @hospitalizacion_iva + @consultaexterna_iva
    respond_to do |format|
      format.html
      format.js
      format.pdf do
        render :pdf => "reporte", :layout => 'report.html', :template => "dashboard/cierre_de_caja_dia.html.erb"
      end
    end
    # raise 'error'
  end

  def cierre_de_caja_mes
    @facturas_mes = consulta_facturas(Time.now.beginning_of_month..Time.now.end_of_month,"compra")
    @cantidad_mes_ventanilla = cantidad_facturas(@facturas_mes, "ventanilla")
    @totalmes_ventanilla = valor_total_por_facturas(@facturas_mes, "ventanilla")
    @cantidad_mes_consultaexterna = cantidad_facturas(@facturas_mes, "consulta_externa")
    @totalmes_consultaexterna = valor_total_por_facturas(@facturas_mes, "consulta_externa")
    @cantidad_mes_hospitalizacion = cantidad_facturas(@facturas_mes, "hospitalizacion")
    @totalmes_hospitalizacion = valor_total_por_facturas(@facturas_mes, "hospitalizacion")
    @totalfacturasmes = valor_total_facturas(@facturas_mes)
    @cantidadfacturasmes = @cantidad_mes_ventanilla + @cantidad_mes_hospitalizacion + @cantidad_mes_consultaexterna
    @ventanilla_subtotal = sumar_impuesto(@facturas_mes, "ventanilla", "subtotal_0")
    @hospitalizacion_subtotal = sumar_impuesto(@facturas_mes, "hospitalizacion", "subtotal_0")
    @consultaexterna_subtotal = sumar_impuesto(@facturas_mes, "consulta_externa", "subtotal_0")
    @total_subtotal = @ventanilla_subtotal + @hospitalizacion_subtotal + @consultaexterna_subtotal
    @ventanilla_iva = sumar_impuesto(@facturas_mes, "ventanilla", "iva")
    @hospitalizacion_iva = sumar_impuesto(@facturas_mes, "hospitalizacion", "iva")
    @consultaexterna_iva = sumar_impuesto(@facturas_mes, "consulta_externa", "iva")
    @total_iva = @ventanilla_iva + @hospitalizacion_iva + @consultaexterna_iva
    respond_to do |format|
      format.html
      format.js
      format.pdf do
        render :pdf => "reporte", :layout => 'report.html', :template => "dashboard/cierre_de_caja_mes.html.erb"
      end
    end
  end

  def caducados
    respond_to do |format|
      format.json { render json: ProductosDatatable.new(view_context, "caducados") }
    end
    # @caducados = Producto.where(:fecha_de_caducidad =>Time.now.end_of_day..Time.now.months_since(4))    
  end

  private

  def consulta_facturas(query, tipo)
    if tipo
    todasfacturas = Factura.where(:created_at => query).where(:anulada => false).where.not(:tipo => tipo)
  else
    todasfacturas = Factura.where(:created_at => query)  
  end
    return :json => todasfacturas
  end

  def regla_de_tres (total_tipo_factura, total_facturas)
    if total_facturas == 0
      porcentaje = 0        
    else
      porcentaje = (100 * total_tipo_factura)/total_facturas
    end
    return porcentaje
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
    return '%.2f' %total
  end

  def valor_total_facturas(facturas)
    total = 0
    facturas.each do |value, key|
      key.each do |factura|
          total += factura.total
      end
    end
    return '%.2f' %total
  end

  def sumar_impuesto (todas_facturas, tipo_factura, tipo_impuesto)
    impuesto = tipo_impuesto
    sumar = 0
    todas_facturas.each do |value, key|
      key.each do |factura|
        if factura.tipo == tipo_factura
          case impuesto
          when 'iva'
            sumar += factura.iva
          when 'subtotal_0'
            sumar += factura.subtotal_0
          when 'subtotal_12'
            sumar += factura.subtotal_12
          when 'descuento'
            sumar += factura.descuento
          end
          sumar
        end
      end
    end
    return sumar
  end

end