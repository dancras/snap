extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass

func master_init_table():
    var p1_deck_position = $P1Deck.rect_position
    $P1Deck.rect_position = $P2Deck.rect_position
    $P2Deck.rect_position = p1_deck_position

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

remote func update_dragging_card(drag_data, position):
    $DraggingCard.set_face_up(drag_data.face_up)
    $DraggingCard.set_suit_and_rank(drag_data.card[0], drag_data.card[1])
    $DraggingCard.show()
    $DraggingCard.set_global_position(
        get_viewport().size - position - $DraggingCard.rect_size
    )

remote func hide_dragging_card():
    $DraggingCard.hide()


func notify_dragging(drag_data, position):
    rpc("update_dragging_card", drag_data, position)


func notify_drag_complete():
    rpc("hide_dragging_card")
