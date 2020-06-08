extends Panel

var original_alpha

func _ready():
    var panel_stylebox = get("custom_styles/panel")
    original_alpha = panel_stylebox.border_color.a

func can_drop_data(position, data):
    return get_parent().can_drop_data(position, data)

func drop_data(position, data):
    get_parent().drop_data(position, data)
    rpc("remove_highlight")

func _on_EmptyDeck_mouse_entered():
    if get_viewport().gui_is_dragging():
        rpc("highlight")

func _on_EmptyDeck_mouse_exited():
    rpc("remove_highlight")

remotesync func highlight():
    var panel_stylebox = get("custom_styles/panel")
    original_alpha = panel_stylebox.border_color.a
    panel_stylebox.border_color.a = 0.8

remotesync func remove_highlight():
    var panel_stylebox = get("custom_styles/panel")
    panel_stylebox.border_color.a = original_alpha
