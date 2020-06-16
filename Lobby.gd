extends Control

const SERVER_PORT = 6050

var is_master = true

func _ready():
    get_tree().connect("network_peer_connected", self, "_player_connected")
#    get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
    get_tree().connect("connected_to_server", self, "_connected_ok")
#    get_tree().connect("connection_failed", self, "_connected_fail")
#    get_tree().connect("server_disconnected", self, "_server_disconnected")
    init_connection()

func init_connection():
    var peer = NetworkedMultiplayerENet.new()
    var create_error = peer.create_server(SERVER_PORT, 1)

    if create_error:
        is_master = false
        peer.create_client("127.0.0.1", SERVER_PORT)
    else:
        $Log.text += "\nServer Created: " + PoolStringArray(IP.get_local_addresses()).join(":" + str(SERVER_PORT) + " ")

    get_tree().network_peer = peer


func _player_connected(id):
    $Log.text += "\nPlayer Connected: " + str(id)
    hide()

    if is_master:
        get_parent().get_node("Table").master_init_table([1, id])

func _connected_ok():
    $Log.text += "\nConnection Success!"
