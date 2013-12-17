init_autocomplete = ->
  $(".numero_de_identificacion").autocomplete
    minLength: 3
    source: "/clientes/autocomplete.json"
    select: (event, ui) ->
      $(".nombre").val ui.item.nombre
      $(".direccion").val ui.item.direccion
      $(".telefono").val ui.item.telefono

  $(".autocomplete_producto").autocomplete
    minLength: 3
    source: "/productos/autocomplete.json"
    select: (event, ui) ->
      $this = $(this)
      $this.closest(".fields").find("td:nth-child(1)").find(".codigo").val ui.item.codigo
      $this.closest(".fields").find("td:nth-child(4)").find(".valor_unitario").val ui.item.precio_a

  $(".cantidad").on "input", ->
    $this = $(this)
    cantidad = $this.val()
    valor_unitario = $this.closest(".fields").find("td:nth-child(4)").find(".valor_unitario").val()
    total = $this.closest(".fields").find("td:nth-child(7)").find(".total")
    total.val(cantidad * valor_unitario)

jQuery ->
  init_autocomplete()
$(document).on "page:load", init_autocomplete
$(document).on "nested:fieldAdded", init_autocomplete
