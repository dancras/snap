extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass

func master_init_table():
    $DrawDeck.rect_position = $DrawDeckAltPosition.position

    randomize()
    $DrawDeck.fill_deck()
    rpc("receive_draw_deck", $DrawDeck.cards)

remote func receive_draw_deck(cards):
    $DrawDeck.cards = cards
    $DrawDeck.update_children()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

remote func update_dragging_card(_drag_data, position):
    $DraggingCard.show()
    $DraggingCard.set_global_position(
        get_viewport().size - position - $DraggingCard.rect_size
    )


func notify_dragging(drag_data, position):
    rpc("update_dragging_card", drag_data, position)
