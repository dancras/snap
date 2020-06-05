extends Panel

var original_alpha
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func can_drop_data(position, data):
    return get_parent().can_drop_data(position, data)

func drop_data(position, data):
    get_parent().drop_data(position, data)

func _on_EmptyDeck_mouse_entered():
    var panel_stylebox = get("custom_styles/panel")
    original_alpha = panel_stylebox.border_color.a
    panel_stylebox.border_color.a = 0.8


func _on_EmptyDeck_mouse_exited():
    var panel_stylebox = get("custom_styles/panel")
    panel_stylebox.border_color.a = original_alpha
