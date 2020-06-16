extends ColorRect

const Deck = preload("res://Deck.tscn")

var master_turn = true
var card_reveal_local_time
var master_snap_time = null
var puppet_snap_time = null

enum TurnOutcome {
    NONE,
    MASTER_WIN,
    PUPPET_WIN
}

# Called when the node enters the scene tree for the first time.
func _ready():
    $DraggingCard.set_always_pressed()
    $SnapButton.hide()

func master_init_table(players):
    $TableState.start_new_table(players)
    $TableState.start_new_game()

func init_table(players):

    var my_id = get_tree().get_network_unique_id()

    for child in $PlayerDecks.get_children():
        $PlayerDecks.remove_child(child)
        child.queue_free()

    for player_id in players:
        var player_deck = Deck.instance()
        var position_node = $MyDeckPosition if player_id == my_id else $TheirDeckPosition
        player_deck.rect_position = position_node.position

    if players[0] == my_id:
        $DrawDeck.rect_position = $DrawDeckAltPosition.position


func init_game(current_turn_id):
    $DrawDeck.fill_deck()
    rpc("receive_draw_deck", $DrawDeck.cards)

    master_turn = current_turn_id == 1
    next_turn()

remote func receive_draw_deck(cards):
    $DrawDeck.cards = cards
    $DrawDeck.update_children()


remote func set_decks_disabled(disable):
    $DrawDeck.set_disabled(disable)
    $PlayDeck.set_disabled(disable)


master func next_turn():
    master_turn = !master_turn
    set_decks_disabled(!master_turn)
    rpc("set_decks_disabled", master_turn)


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

func _on_PlayDeck_card_pushed():
    card_reveal_local_time = OS.get_system_time_msecs()
    set_decks_disabled(true)
    $SnapButton.show()
    $SnapTimer.start()
    yield($SnapTimer, "timeout")
    $SnapButton.hide()
    rpc("process_snap_times")
    next_turn()

master func process_snap_times():
    var outcome = get_turn_outcome()

    if outcome == TurnOutcome.MASTER_WIN:
        $P1Deck.push_cards_sync($PlayDeck.cards)
        $PlayDeck.clear_cards_sync()
    elif outcome == TurnOutcome.PUPPET_WIN:
        $P2Deck.push_cards_sync($PlayDeck.cards)
        $PlayDeck.clear_cards_sync()

    master_snap_time = null
    puppet_snap_time = null


func get_turn_outcome():
    var master_snap = TurnOutcome.MASTER_WIN
    var puppet_snap = TurnOutcome.PUPPET_WIN

    if master_snap_time == null && puppet_snap_time == null:
        return TurnOutcome.NONE

    if $PlayDeck.cards[-1][1] != $PlayDeck.cards[-2][1]:
        if master_snap_time != null && puppet_snap_time != null:
            return TurnOutcome.NONE

        master_snap = TurnOutcome.PUPPET_WIN
        puppet_snap = TurnOutcome.MASTER_WIN

    if master_snap_time != null && (puppet_snap_time == null || master_snap_time < puppet_snap_time):
        return master_snap
    else:
        return puppet_snap


func _on_SnapButton_button_down():
    $SnapButton.disabled = true
    var local_snap_time = OS.get_system_time_msecs() - card_reveal_local_time
    set_snap_time(local_snap_time)
    send_snap_time(local_snap_time)

master func set_snap_time(snap_time):
    master_snap_time = snap_time

remote func receive_snap_time(snap_time):
    puppet_snap_time = snap_time

puppet func send_snap_time(snap_time):
    rpc("receive_snap_time", snap_time)
