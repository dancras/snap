extends Button

const Card = preload("Card.gd")
const Rank = Card.Rank
const Suit = Card.Suit

const RANK_TEXT = {
    Rank.R_2: "2",
    Rank.R_3: "3",
    Rank.R_4: "4",
    Rank.R_5: "5",
    Rank.R_6: "6",
    Rank.R_7: "7",
    Rank.R_8: "8",
    Rank.R_9: "9",
    Rank.R_10: "10",
    Rank.R_JACK: "J",
    Rank.R_QUEEN: "Q",
    Rank.R_KING: "K",
    Rank.R_ACE: "A",
}

const RANK_CONFIG = {
    Rank.R_2: {
        "text": "2",
        "symbol_format": "x\nx"
    },
    Rank.R_3: {
        "text": "3",
        "symbol_format": "x\nxx"
    },
    Rank.R_4: {
        "text": "4",
        "symbol_format": "xx\nxx"
    },
    Rank.R_5: {
        "text": "5",
        "symbol_format": "x\nxx\nxx"
    },
    Rank.R_6: {
        "text": "6",
        "symbol_format": "x\nxx\nxxx"
    },
    Rank.R_7: {
        "text": "7",
        "symbol_format": "x\nxx\nxx\nxx"
    },
    Rank.R_8: {
        "text": "8",
        "symbol_format": "xx\nxx\nxx\nxx"
    },
    Rank.R_9: {
        "text": "9",
        "symbol_format": "xxx\nxxx\nxxx"
    },
    Rank.R_10: {
        "text": "10",
        "symbol_format": "x\nxx\nxxx\nxxxx"
    },
    Rank.R_JACK: {
        "text": "J",
        "symbol_format": "x"
    },
    Rank.R_QUEEN: {
        "text": "Q",
        "symbol_format": "x"
    },
    Rank.R_KING: {
        "text": "K",
        "symbol_format": "x"
    },
    Rank.R_ACE: {
        "text": "A",
        "symbol_format": "x"
    },
}

const SUIT_CONFIG = {
    Suit.HEARTS: {
        "symbol": "♥",
        "color": Color.red
    },
    Suit.DIAMONDS: {
        "symbol": "♦",
        "color": Color.red
    },
    Suit.CLUBS: {
        "symbol": "♣",
        "color": Color.black
    },
    Suit.SPADES: {
        "symbol": "♠",
        "color": Color.black
    }
}

var default_margin

# Called when the node enters the scene tree for the first time.
func _ready():
    default_margin = $Rank.margin_left


func set_suit_and_rank(suit, rank):

    var rank_config = RANK_CONFIG[rank]
    var active_suit = $Suit

    if (rank == Card.Rank.R_10):
        $Rank.margin_left = default_margin - 5
    else:
        $Rank.margin_left = default_margin

    if (rank >= Rank.R_JACK):
        active_suit = $SuitLarge

    $Suit.hide()
    $SuitLarge.hide()
    active_suit.show()

    $Rank.text = rank_config.text
    active_suit.text = rank_config.symbol_format.replace("x", SUIT_CONFIG[suit].symbol)

    $Rank.add_color_override("font_color", SUIT_CONFIG[suit].color)
    $Suit.add_color_override("font_color", SUIT_CONFIG[suit].color)
    $SuitLarge.add_color_override("font_color", SUIT_CONFIG[suit].color)


func can_drop_data(position, data):
    return get_parent().can_drop_data(position, data)

func drop_data(position, data):
    get_parent().drop_data(position, data)
