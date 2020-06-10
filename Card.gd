extends Control

enum Rank {
    R_2,
    R_3,
    R_4,
    R_5,
    R_6,
    R_7,
    R_8,
    R_9,
    R_10,
    R_JACK,
    R_QUEEN,
    R_KING,
    R_ACE,
}

enum Suit {
    HEARTS,
    DIAMONDS,
    CLUBS,
    SPADES
}

export(Rank) var rank: int
export(Suit) var suit: int

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func set_suit_and_rank(new_suit, new_rank):
    suit = new_suit
    rank = new_rank
    $CardFront.set_suit_and_rank(suit, rank)

func can_drop_data(position, data):
    return get_parent().can_drop_data(position, data)

func drop_data(position, data):
    return get_parent().drop_data(position, data)

func get_drag_data(position):
    return get_parent().get_drag_data(position)

func get_drag_preview(face_up):
    var card_node = $CardFront if face_up else $CardBack

    var preview = card_node.duplicate()
    preview.add_stylebox_override(
        "normal",
        preview.get("custom_styles/pressed")
    )
    return preview

func set_face_up(face_up):
    $CardBack.visible = !face_up
    $CardFront.visible = face_up

func set_always_pressed():
    $CardFront.add_stylebox_override(
        "normal",
        $CardFront.get("custom_styles/pressed")
    )
    $CardBack.add_stylebox_override(
        "normal",
        $CardBack.get("custom_styles/pressed")
    )

func set_disabled(disabled):
    $CardFront.disabled = disabled
    $CardBack.disabled = disabled
