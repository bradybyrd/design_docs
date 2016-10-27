# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'change', '#basin_basin_type', ->
    cur_id = $(this).val()
    img_url = window.location.origin + "/assets/basin_type_" + cur_id + ".gif"
    new_link = "<div id='basin_image'><img src='" + img_url
    new_link += "' alt='basin image' size='210x140' class='img-responsive'></img></div>"
    $("#basin_image").replaceWith(new_link)
    if cur_id == 'cylindrical'
        $(".basin_width").hide()
        $(".basin_length").hide()
        $(".basin_diameter").show()
    else
        $(".basin_width").show()
        $(".basin_length").show()
        $(".basin_diameter").hide()


$(document).on 'click', "[id^=edit_basin_id]", ->
  event.preventDefault()
  basin_id = $(this).attr('id').replace("edit_basin_id_","")
  target_url = $('#edit_basin_url').val()
  site_id = window.location.pathname.replace("/sites/","").replace("/edit","")
  $.ajax window.location.origin + "/basins/" + basin_id + "/edit_form",
           type: 'GET',
           data: {'basin_action' : 'ajax_embed', 'site_id' : site_id}
           success: (data) ->
             $('#basin_info').replaceWith(data);


$(document).on 'click', "#calculate_basin", ->
  event.preventDefault()
  cur_form = $("form.edit_basin")
  basin_type = cur_form.find('select[id="basin_basin_type"]').val()
  width = cur_form.find('input[id="basin_width"]').val()
  length = cur_form.find('input[id="basin_length"]').val()
  diameter = cur_form.find('input[id="basin_diameter"]').val()
  depth = cur_form.find('input[id="basin_depth"]').val()
  slope = cur_form.find('input[id="basin_side_slope_ratio"]').val()
  if slope != ""
      ratio = parseFloat(slope)
  else
      ratio = 0

  e_depth = parseFloat(depth)
  if basin_type == 'cylindrical'
      e_radius = (parseFloat(diameter) + e_depth * ratio) * 0.5
      surface_area = Math.PI * Math.pow((parseFloat(diameter) * .5), 2)
      volume = surface_area * e_depth
  else
      e_width = parseFloat(width) + e_depth * ratio
      e_length = parseFloat(length) + e_depth * ratio
      surface_area = parseFloat(width) * parseFloat(length)
      volume = e_width * e_length * e_depth
      
  cur_form.find('input[id="basin_surface_area"]').val(surface_area.toFixed(2))
  cur_form.find('input[id="basin_volume"]').val(volume.toFixed(2))
  