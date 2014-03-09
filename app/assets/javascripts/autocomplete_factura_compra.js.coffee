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

    $(".nombre_producto").on "input", ->
      $this = $(this)
      texto = $this.val()
      $this.closest(".fields").find(".nombre_item").text(texto + " $")

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