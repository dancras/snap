extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


func get_drag_data(position):
    var preview = duplicate()
    preview.add_stylebox_override(
        "normal",
        preview.get("custom_styles/pressed")
    )
    set_drag_preview(preview)

    return get_parent().get_drag_data(position)
