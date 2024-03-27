class_name JumpPad
extends Area3D

@export var POWER: Vector3 = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
    connect("body_entered", _on_body_entered)

func _on_body_entered(player: Player) -> void:
    player.velocity = POWER
