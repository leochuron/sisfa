window.Helpers ||= {}

window.Helpers.AutocompleteHelper = {
  init_autocomplete: ->
    $(".numero_de_identificacion").autocomplete
      minLength: 3
      source: "/clientes/autocomplete.json"
      response: (event, ui) ->
        unless ui.content.length
          a = $("<a>")
          $(a).attr('data-remote', 'true')
          addNew =
            label:  "Agregar: #{event.target.value}"
          # console.log addNew
          ui.content.push addNew
        else
          $("#message").empty()
      select: (event, ui) ->
        $(".cliente_id").val ui.item.id
        $(".nombre").val ui.item.nombre
        $(".direccion").val ui.item.direccion
        $(".telefono").val ui.item.telefono
    .data("ui-autocomplete")._renderItem = (ul, item) ->
      a = $('<a>', 
        text: item.label)
      $(a).attr('href', "/clientes/new")
      $(a).attr('data-remote', 'true')
      $(a).attr('data-target', '#myModal')
      $(a).attr('data-toggle', 'modal')
      # f = items
      # console.log $("<li></li>").data("item.autocomplete", item).append(a).appendTo ul
      $("<li></li>").data("item.autocomplete", item).append(a).appendTo ul

    $(".autocomplete_producto").autocomplete
      minLength: 3
      source: "/productos/autocomplete.json"
      response: (event, ui) ->
        unless ui.content.length
          noResult =
            value: event.target.value
            label: "Agregar: #{event.target.value}"
            # kind: "<a href='#'>t</a>"
          ui.content.push noResult
        else
          $("#message").empty()
      select: (event, ui) ->
        $this = $(this)
        $this.closest(".fields").find("td:nth-child(2)").find(".producto_id").val ui.item.id
        # $this.closest(".fields").find("td:nth-child(1)").find(".codigo").val ui.item.codigo
        $this.closest(".fields").find("td:nth-child(3)").find(".valor_unitario").val ui.item.precio_a
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

  call_modal: ->
    # $.ui.autocomplete::_renderItem = (ul, item) ->

  calcular_total_producto: (componente) ->
    cantidad = componente.closest(".fields").find("td:nth-child(2)").find(".cantidad").val()
    valor_unitario = componente.closest(".fields").find("td:nth-child(3)").find(".valor_unitario").val()
    total = componente.closest(".fields").find("td:nth-child(6)").find(".total")
    total.val(cantidad * valor_unitario)

  calcular_valores_factura: ->
    sum = 0
    $(".total").each ->
      sum += parseFloat($(this).val())
    $(".subtotal_0").val sum
    $(".subtotal_12").val sum
    $(".descuento_factura").val 0
    $(".iva_factura").val((sum*0.12).toFixed(2));
    $(".total_factura").val((sum*0.12+sum).toFixed(2));

  init_autocompleteProveedor: ->
    $(".numero_de_identificacion_proveedor").autocomplete
      minLength: 3
      source: "/proveedors/autocomplete.json"
      select: (event, ui) ->
        $(".proveedor_id").val ui.item.id
        $(".nombre").val ui.item.nombre_o_razon_social
        $(".direccion").val ui.item.direccion
        $(".telefono").val ui.item.telefono

  autocomplete_precio_producto: ->
    $(".precio_a").on "input", ->
      # $this = $(this)
      console.log "cambiar"
      # $(".precio_b").val($this.val())
}

jQuery window.Helpers.AutocompleteHelper.init
$(document).on "page:load", window.Helpers.AutocompleteHelper.init_autocomplete
$(document).on "page:load", window.Helpers.AutocompleteHelper.init_autocompleteProveedor
$(document).on "page:load", window.Helpers.AutocompleteHelper.autocomplete_precio_producto
# jQuery ->
#   init_autocomplete()
# $(document).on "page:load", init_autocomplete
$(document).on "nested:fieldAdded", window.Helpers.AutocompleteHelper.init_autocomplete
$(document).on "nested:fieldAdded", window.Helpers.AutocompleteHelper.init_autocompleteProveedor
$(document).on "nested:fieldAdded", window.Helpers.AutocompleteHelper.autocomplete_precio_producto
# $(document).on "nested:fieldRemoved", init_autocomplete
