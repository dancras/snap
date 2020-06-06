extends Node

var drag_origin
var drag_data

func poll_viewport_for_grab_status():
    yield(get_tree().create_timer(0.05), "timeout")

    if get_viewport().gui_is_dragging():
        poll_viewport_for_grab_status()
    elif drag_origin != null:
        drag_origin.revert_drag(drag_data)

func starting_drag(origin, data):
    drag_origin = origin
    drag_data = data
    poll_viewport_for_grab_status()

func drop_success():
    drag_origin = null
    drag_data = null
