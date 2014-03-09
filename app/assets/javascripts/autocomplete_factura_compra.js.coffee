window.Helpers ||= {}

window.Helpers.AutocompleteCompraHelper = {
  init_autocomplete: ->
    $(".precio_compra").on "input", ->
      $this = $(this)
      window.Helpers.AutocompleteCompraHelper.total_producto($this)
      window.Helpers.AutocompleteCompraHelper.suma_productos_factura_compra()

    $(".cantidad_producto").on "input", ->
      $this = $(this)
      window.Helpers.AutocompleteCompraHelper.total_producto($this)
      window.Helpers.AutocompleteCompraHelper.suma_productos_factura_compra()

    # $(".nombre_producto").on "input", ->
    #   $this = $(this)
    #   texto = $this.val()
    #   $this.closest(".fields").find(".nombre_item").text(texto + " $")

    $(".eliminar_item_producto").on "click", ->
      $this = $(this)
      $this.closest(".fields_producto").remove()
      window.Helpers.AutocompleteCompraHelper.total_producto($this)
      window.Helpers.AutocompleteCompraHelper.suma_productos_factura_compra()

    $(".eliminar_item_compra").on "click", ->
      $this = $(this)
      $this.closest(".fields").remove()
      window.Helpers.AutocompleteCompraHelper.total_producto($this)
      window.Helpers.AutocompleteCompraHelper.suma_productos_factura_compra()

    $(".nombre_producto").autocomplete
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
        $this.closest(".fields").find(".nombre_item").text($this.val() + " $")
        $this.closest(".fields").find(".nombre_generico").val ui.item.nombre_generico
        $this.closest(".fields").find(".codigo").val ui.item.codigo
        $this.closest(".fields").find(".categoria").val ui.item.categoria
        $this.closest(".fields").find(".casa_comercial").val ui.item.casa_comercial
        $this.closest(".fields").find(".precio_compra").val ui.item.precio_compra
        $this.closest(".fields").find(".ganancia").val ui.item.ganancia


  total_producto: (componente) ->
    sum = 0
    componente.closest(".fields").find(".fields_producto").find(".cantidad_producto").each ->
      sum += parseFloat($(this).val())
    cantidad_total = sum
    precio = componente.closest(".fields").find(".precio_compra").val()
    total = cantidad_total * precio
    componente.closest(".fields").find(".total_item").text(total.toFixed(2))

  suma_productos_factura_compra: ->
    sum = 0
    $(".total_item").each ->
      sum += parseFloat($(this).text())
    $(".subtotal_compra").val sum.toFixed(2)
    $(".iva_compra").val((sum*0.12).toFixed(2));
    $(".total_compra").val((sum*0.12+sum).toFixed(2));

}

jQuery window.Helpers.AutocompleteCompraHelper.init
$(document).on "ready page:load", window.Helpers.AutocompleteCompraHelper.init_autocomple

$(document).on "nested:fieldAdded", window.Helpers.AutocompleteCompraHelper.init_autocomplete
