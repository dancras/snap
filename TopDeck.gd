extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


func get_drag_data(position):
    var preview = duplicate()
    set_drag_preview(preview)
    return {
        "type": "card"
    }

