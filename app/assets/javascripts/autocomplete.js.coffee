window.Helpers ||= {}

window.Helpers.AutocompleteHelper = {
  init_autocomplete: ->
    $(".numero_de_identificacion").autocomplete
      minLength: 3
      source: "/clientes/autocomplete.json"
      response: (event, ui) ->
        unless ui.content.length
          addNewCliente =
            id: "vacio"
            label:  "Agregar: #{event.target.value}"
            cedula: event.target.value
          ui.content.push addNewCliente
        else
          $("#message").empty()
      select: (event, ui) ->
        if ui.item.id == "vacio"
          $.getScript "/clientes/new"
          $('#myModal').modal
            remote: ""
          $('#myModal').on "shown.bs.modal", ->
            $('#cliente_numero_de_identificacion').val(ui.item.cedula)
        else
          $(".cliente_id").val ui.item.id
          $(".nombre").val ui.item.nombre
          $(".direccion").val ui.item.direccion
          $(".telefono").val ui.item.telefono

    $(".autocomplete_producto").autocomplete
      minLength: 3
      source: "/productos/autocomplete.json"
      response: (event, ui) ->
        unless ui.content.length
          NoExiste =
            id: "vacio"
            label: "No existe: #{event.target.value}"
          ui.content.push NoExiste
        else
          $("#message").empty()
      select: (event, ui) ->
        $this = $(this)
        $this.closest(".fields").find("td:nth-child(2)").find(".ingreso_producto_id").val ui.item.id_ingreso
        $this.closest(".fields").find("td:nth-child(3)").find(".valor_unitario").val ui.item.precio_venta
        if ui.item.iva == true
          precio_venta = ui.item.precio_venta
          iva_producto = precio_venta * 0.12
          precio_sin_iva = precio_venta - iva_producto
          $this.closest(".fields").find("td:nth-child(5)").find(".iva").val iva_producto.toFixed(2)
          $this.closest(".fields").find("td:nth-child(3)").find(".valor_unitario").val precio_sin_iva.toFixed(2)
        window.Helpers.AutocompleteHelper.calcular_total_producto($this)
        window.Helpers.AutocompleteHelper.calcular_valores_factura()

    $(".cantidad").on "input", ->
      $this = $(this)
      window.Helpers.AutocompleteHelper.calcular_total_producto($this)
      window.Helpers.AutocompleteHelper.calcular_valores_factura()

    $(".eliminar_item").on "click", ->
      $this = $(this)
      $this.closest(".fields").remove()
      window.Helpers.AutocompleteHelper.calcular_valores_factura()

  calcular_total_producto: (componente) ->
    cantidad = componente.closest(".fields").find("td:nth-child(2)").find(".cantidad").val()
    valor_unitario = componente.closest(".fields").find("td:nth-child(3)").find(".valor_unitario").val()
    total = componente.closest(".fields").find("td:nth-child(6)").find(".total")
    total.val(cantidad * valor_unitario)

  calcular_valores_factura: ->
    sum = 0
    $(".total").each ->
      sum += parseFloat($(this).val())
    $(".subtotal_0").val sum.toFixed(2)
    $(".subtotal_12").val sum.toFixed(2)
    $(".descuento_factura").val 0
    $(".iva_factura").val((sum*0.12).toFixed(2));
    $(".total_factura").val((sum*0.12+sum).toFixed(2));

  init_autocompleteProveedor: ->
    $(".numero_de_identificacion_proveedor").autocomplete
      minLength: 3
      source: "/proveedors/autocomplete.json"
      response: (event, ui) ->
        unless ui.content.length
          addNewProveedor =
            id: "vacio"
            label:  "Agregar: #{event.target.value}"
            cedula: event.target.value
          ui.content.push addNewProveedor
        else
          $("#message").empty()
      select: (event, ui) ->
        if ui.item.id == "vacio"
          $.getScript "/proveedors/new"
          $('#myModal').modal
            remote: ""
          $('#myModal').on "shown.bs.modal", ->
            $('#proveedor_numero_de_identificacion').val(ui.item.cedula)
        else
          $(".proveedor_id").val ui.item.id
          $(".nombre").val ui.item.nombre_o_razon_social
          $(".direccion").val ui.item.direccion
          $(".telefono").val ui.item.telefono

  init_autocompleteProductosCompra: ->  
    $(".autocomplete_producto_compra").autocomplete
      minLength: 3
      source: "/productos/autocomplete.json"
      response: (event, ui) ->
        unless ui.content.length
          addNewProducto =
            id: "vacio"
            label:  "Agregar: #{event.target.value}"
            producto: event.target.value
          ui.content.push addNewProducto
        else
          $("#message").empty()
      select: (event, ui) ->
        if ui.item.id == "vacio"
          $.getScript "/productos/new"
          $('#myModal').modal
            remote: ""
          $('#myModal').on "shown.bs.modal", ->
            $('#producto_nombre').val(ui.item.producto)
        else
        $this = $(this)
        $this.closest(".fields").find("td:nth-child(2)").find(".producto_id").val ui.item.id
        # $this.closest(".fields").find("td:nth-child(1)").find(".codigo").val ui.item.codigo
        $this.closest(".fields").find("td:nth-child(3)").find(".valor_unitario").val ui.item.precio_venta
        window.Helpers.AutocompleteHelper.calcular_total_producto($this)
        window.Helpers.AutocompleteHelper.calcular_valores_factura()
}

jQuery window.Helpers.AutocompleteHelper.init
$(document).on "ready page:load", window.Helpers.AutocompleteHelper.init_autocomplete
$(document).on "ready page:load", window.Helpers.AutocompleteHelper.init_autocompleteProveedor
$(document).on "ready page:load", window.Helpers.AutocompleteHelper.init_autocompleteProductosCompra

$(document).on "nested:fieldAdded", window.Helpers.AutocompleteHelper.init_autocomplete
$(document).on "nested:fieldAdded", window.Helpers.AutocompleteHelper.init_autocompleteProveedor
$(document).on "nested:fieldAdded", window.Helpers.AutocompleteHelper.init_autocompleteProductosCompra
