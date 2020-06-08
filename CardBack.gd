extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


func get_drag_data(position):
    return get_parent().get_drag_data(position)

func can_drop_data(position, data):
    return get_parent().can_drop_data(position, data)

func drop_data(position, data):
    get_parent().drop_data(position, data)
