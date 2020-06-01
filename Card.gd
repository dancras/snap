extends Button

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

export(Rank) var rank: int
export(Suit) var suit: int
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    set_rank_to_nodes()

    $Rank.add_color_override("font_color", SUIT_CONFIG[suit].color)
    $Suit.add_color_override("font_color", SUIT_CONFIG[suit].color)
    $SuitLarge.add_color_override("font_color", SUIT_CONFIG[suit].color)

func set_rank_to_nodes():
    var rank_config = RANK_CONFIG[rank]
    var active_suit = $Suit

    if (rank == Rank.R_10):
        $Rank.margin_left -= 5

    if (rank >= Rank.R_JACK):
        active_suit = $SuitLarge

    $Suit.hide()
    $SuitLarge.hide()
    active_suit.show()

    $Rank.text = rank_config.text
    active_suit.text = rank_config.symbol_format.replace("x", SUIT_CONFIG[suit].symbol)


func can_drop_data(position, data):
    return true

func drop_data(position, data):
    rank += 1
    set_rank_to_nodes()
