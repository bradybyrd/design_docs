# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'click', 'form .remove_fields', (event) ->
  $(this).prev('input[type=hidden]').val('1')
  $(this).closest('fieldset').hide()
  event.preventDefault()

$(document).on 'change', 'select', ->
    if $(this).val() == "-1"
        cur_id = $(this).attr('id').replace("select_property_id", "new_name")
        $(this).hide()
        $("input#" + cur_id).show();

$(document).on 'click', 'form #add_property', (event) ->
  event.preventDefault();
  form_increment = $('#form_increment').val()
  target_url = $('#add_property_target_url').val()
  associated_model = $('#associated_model').val()
  $.ajax window.location.origin + target_url,
           type: 'GET',
           data: {'form_increment' : form_increment, 'add_property' : 'add', 'associated_model' : associated_model}
           success: (data) ->
             $('#add_new_property').replaceWith(data);

$(document).on 'click', 'form #add_property_table', (event) ->
  event.preventDefault();
  form_increment = $('#form_increment').val()
  target_url = $('#add_property_target_url').val()
  associated_model = $('#associated_model').val()
  add_action = $('#add_action').val()
  $.ajax window.location.origin + target_url,
           type: 'GET',
           data: {'form_increment' : form_increment, 'add_action' : add_action, 'associated_model' : associated_model}
           success: (data) ->
             $('#form_increment').parent().parent().replaceWith(data);
             

