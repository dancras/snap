extends Node

var players = []
var turn_queue = []
var turn_status

enum TurnStatus {
    WAIT_CARD,
    WAIT_SNAP
}

enum TableEvents {
    NEW_TABLE,
    NEW_GAME,
}


master func start_new_table(new_players):
    players = new_players
    rpc("on_event", TableEvents.NEW_TABLE, {
        "players": players
    })

master func start_new_game():
    _init_turn_queue()
    turn_status = TurnStatus.WAIT_CARD
    rpc("on_event", TableEvents.NEW_GAME, {
        "current_turn": turn_queue[0]
    })

func _init_turn_queue():
    var p1 = players[0]
    var p2 = players[1]

    turn_queue = [p1]

    if randi() % 2 == 0:
        turn_queue.push_front(p2)
    else:
        turn_queue.push_back(p2)


remotesync func on_event(event_id, data):
    if TableEvents.NEW_TABLE == event_id:
        get_parent().init_table(data.players)
    elif TableEvents.NEW_GAME == event_id:
        get_parent().init_game(data.current_turn)
