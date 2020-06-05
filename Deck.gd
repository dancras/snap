extends Control

# A card is [suit: int, rank: int]
var cards = []

const TOP_DECK_BASE = 18
const PILE_BASE = 121


func _ready():
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

    $EmptyDeck.show()

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
    var card_data = cards.back()

    if (card_data == null):
        $TopDeck.hide()
    else:
        $TopDeck.show()
        $TopDeck.set_suit_and_rank(card_data[0], card_data[1])


func _on_TopDeck_dragged():
    $TopDeck.rect_global_position = rect_global_position
