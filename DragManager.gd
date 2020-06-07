extends Node

signal drag_position(drag_data, position)
signal drag_complete

var drag_origin
var drag_data

func _input(event):
    if is_dragging() && event is InputEventMouseMotion:
        emit_signal("drag_position", drag_data, event.position);

func is_dragging():
    return drag_origin != null

func poll_viewport_for_grab_status():
    yield(get_tree().create_timer(0.05), "timeout")

    if get_viewport().gui_is_dragging():
        poll_viewport_for_grab_status()
    elif is_dragging():
        drag_origin.revert_drag(drag_data)
        clear_drag_data()
        emit_signal("drag_complete")

func starting_drag(origin, data):
    drag_origin = origin
    drag_data = data
    poll_viewport_for_grab_status()

func drop_success():
    clear_drag_data()
    emit_signal("drag_complete")

func clear_drag_data():
    drag_origin = null
    drag_data = null
