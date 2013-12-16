window.Helpers ||= {}

window.Helpers.ButtonsHelper = {
  init: ->
    $(".guardar_submit:not(.looks_like_button)").each ->
      $(this).addClass("looks_like_button btn btn-success")

    $(".mostrar_view:not(.looks_like_button)").each ->
      $(this).addClass("looks_like_button btn btn-info").html "<i class='fa fa-eye'></i> " + $(this).html()

    $(".nuevo_new:not(.looks_like_button)").each ->
      $(this).addClass("looks_like_button btn btn-primary").html "<i class='fa fa-plus'></i> " + $(this).html()

    $(".delete_destroy:not(.looks_like_button)").each ->
      $(this).addClass("looks_like_button btn btn-danger").html "<i class='fa fa-times'></i> " + $(this).html()

    $(".editar_edit:not(.looks_like_button)").each ->
      $(this).addClass("looks_like_button btn btn-warning").html "<i class='fa fa-pencil'></i> " + $(this).html()

    $(".atras_back:not(.looks_like_button)").each ->
      $(this).addClass("looks_like_button btn btn-inverse").html "<i class='fa fa-chevron-left'></i> " + $(this).html()

    $(".cancel_button:not(.looks_like_button)").each ->
      $(this).addClass("looks_like_button btn btn-inverse").html "<i class='icon-remove icon-white'></i> " + $(this).html()

    $(".pencil_button:not(.looks_like_button)").each ->
      $(this).addClass("looks_like_button btn").html "<i class='icon-pencil'></i> " + $(this).html()
}

jQuery window.Helpers.ButtonsHelper.init
$(document).on "page:load", window.Helpers.ButtonsHelper.init
$(document).on "nested:fieldAdded", window.Helpers.ButtonsHelper.init
$("#myModal").on "show.bs.modal", console.log "hola"
