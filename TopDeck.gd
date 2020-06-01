extends Button

var dragging = false
var drag_offset

signal dragged

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


func _process(delta):
    if dragging:
        var mousepos = get_viewport().get_mouse_position()
        rect_global_position = mousepos + drag_offset

func _on_TopDeck_button_down():
    dragging = true
    drag_offset = rect_global_position - get_viewport().get_mouse_position()


func _on_TopDeck_button_up():
    dragging = false
    emit_signal("dragged")
