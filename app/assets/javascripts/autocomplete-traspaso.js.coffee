window.Helpers ||= {}

window.Helpers.AutocompleteTraspaso = {
  init_autocomplete: ->
    $(".producto_traspaso").autocomplete
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
        $this.closest(".productos_traspaso").find(".ingreso_producto_id").val ui.item.id_ingreso
        $this.closest(".productos_traspaso").find(".casa_comercial").text ui.item.casa_comercial
        $this.closest(".productos_traspaso").find(".precio_unitario").val ui.item.precio_venta
        window.Helpers.AutocompleteTraspaso.calcular_total_producto($this)
        window.Helpers.AutocompleteTraspaso.calcular_valores_factura()

    $(".cantidad").on "input", ->
      $this = $(this)
      window.Helpers.AutocompleteTraspaso.calcular_total_producto($this)
      window.Helpers.AutocompleteTraspaso.calcular_valores_factura()

    $(".eliminar_item").on "click", ->
      $this = $(this)
      $this.closest(".productos_traspaso").remove()
      window.Helpers.AutocompleteTraspaso.calcular_valores_factura()

  calcular_total_producto: (componente) ->
    cantidad = componente.closest(".productos_traspaso").find(".cantidad").val()
    valor_unitario = componente.closest(".productos_traspaso").find(".precio_unitario").val()    
    total = cantidad * valor_unitario
    componente.closest(".productos_traspaso").find(".total_producto").val(total.toFixed(2))
    
  calcular_valores_factura: ->
    sum = 0
    $(".total_producto").each ->
      sum += parseFloat($(this).val())
    $(".subtotal_traspaso").val sum.toFixed(2)
    $(".iva_traspaso").val((sum*0.12).toFixed(2));
    total_final = (sum*0.12+sum).toFixed(2)
    $(".total_traspaso").val(total_final);
    $(".total").text("$" + total_final);
}

jQuery window.Helpers.AutocompleteTraspaso.init
$(document).on "ready page:load", window.Helpers.AutocompleteTraspaso.init_autocomplete
$(document).on "nested:fieldAdded", window.Helpers.AutocompleteTraspaso.init_autocomplete
