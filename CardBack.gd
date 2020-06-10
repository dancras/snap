extends Button

var original_disabled_style

# Called when the node enters the scene tree for the first time.
func _ready():
    original_disabled_style = get("custom_styles/disabled")


func get_drag_data(position):
    return get_parent().get_drag_data(position)

func can_drop_data(position, data):
    return get_parent().can_drop_data(position, data)

func drop_data(position, data):
    get_parent().drop_data(position, data)
    rpc("remove_hover_state")


func _on_CardBack_mouse_entered():
    if !disabled:
        rpc("set_hover_state")


func _on_CardBack_mouse_exited():
    rpc("remove_hover_state")


remote func set_hover_state():
    set("custom_styles/disabled", get("custom_styles/hover"))

remote func remove_hover_state():
    set("custom_styles/disabled", original_disabled_style)


func _on_CardBack_button_up():
    rpc("remove_hover_state")
