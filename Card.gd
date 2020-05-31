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

export(Rank) var rank: int
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    $Rank.text = RANK_TEXT[rank]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
