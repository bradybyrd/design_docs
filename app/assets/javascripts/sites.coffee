# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'click', 'form #add_zone_table', (event) ->
  event.preventDefault();
  form_increment = $('#form_increment').val()
  site_id = $('#add_zone_table').closest('form')[0].id.replace("edit_site_","")
  $.ajax window.location.origin + "/zones/add_zone",
           type: 'GET',
           data: {'form_increment' : form_increment, 'site_id' : site_id}
           success: (data) ->
             $('#form_increment').parent().parent().replaceWith(data);

$(document).on 'click', 'form #add_basin_table', (event) ->
  event.preventDefault();
  form_increment = $('#form_increment').val()
  #zone_id = $('#add_zone_table').closest('input')[0].id.replace("zone_name_","")
  zone_id = $("[id^=zone_name_]")[0].id.replace("zone_name_","")
  $.ajax window.location.origin + "/basins/add_basin",
           type: 'GET',
           data: {'form_increment' : form_increment, 'zone_id' : zone_id}
           success: (data) ->
             $('#add_basin_table').parent().replaceWith(data);
             
$(document).on 'click', '.comment-reply', (event) ->
  event.preventDefault();
  $(this).closest('.comment').find('.reply-form').toggle()

