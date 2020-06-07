extends Control

export var face_up = false

# A card is [suit: int, rank: int]
var cards = []

const TOP_DECK_BASE = 18
const PILE_BASE = 121


func _ready():
    $TopDeck/CardBack.visible = !face_up
    $TopDeck/CardFront.visible = face_up

    update_children()


func fill_deck():
    var numbers = range(52)
    numbers.shuffle()

    for number in numbers:
        cards.append([
            number / 13,
            number % 13
        ])

    update_children()

func update_children():
    update_pile_nodes()
    update_top_deck()

func update_pile_nodes():
    var total_cards = len(cards)

    for child in get_children():
        child.hide()

    $EmptyDeck.visible = total_cards == 0

    $TopDeck.visible = total_cards > 0
    $TopDeck.rect_position.y = TOP_DECK_BASE - (total_cards / 54.0) * 18

    $Pile5.visible = $TopDeck.visible && $TopDeck.rect_position.y < TOP_DECK_BASE
    $Pile5.rect_position.y = PILE_BASE - TOP_DECK_BASE + ceil($TopDeck.rect_position.y / 3) * 3

    var previous_pile = $Pile5

    for current_pile in [$Pile4, $Pile3, $Pile2, $Pile1, $Pile0]:
        current_pile.rect_position.y = 1 + ceil(previous_pile.rect_position.y / 3) * 3
        current_pile.visible = previous_pile.visible && current_pile.rect_position.y <= PILE_BASE
        previous_pile = current_pile


func update_top_deck():
    if (len(cards) == 0):
        $TopDeck.hide()
    else:
        var card_data = cards.back()
        $TopDeck.show()
        $TopDeck.set_suit_and_rank(card_data[0], card_data[1])

func get_drag_data(_position):
    var drag_card = cards.pop_back()
    rpc("pop_card")
    get_node("/root/Main/DragManager").starting_drag(self, drag_card)
    update_children()
    return drag_card

func revert_drag(data):
    rpc("push_card", data)

func can_drop_data(_position, _data):
    return true

func drop_data(_position, data):
    rpc("push_card", data)
    get_node("/root/Main/DragManager").drop_success()

remotesync func push_card(data):
    cards.push_back(data)
    update_children()


remote func pop_card():
    cards.pop_back()
