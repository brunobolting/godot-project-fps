class_name EnemyNavigation
extends Node

var _player: Player

func _ready():
    _player = get_tree().get_nodes_in_group("player")[0]
    if _player == null:
        print("Player not found")
        return

func _physics_process(_delta):
    get_tree().call_group("enemies", "update_target_location", _player.global_transform.origin)
