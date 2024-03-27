class_name PlayerPickup
extends Area3D

@export var CALLBACK_ON_ENTERED: String
@export var CALLBACK_ON_EXIT: String

func _ready():
    connect("body_entered", _on_body_entered)
    connect("body_exited", _on_body_exited)

func _on_body_entered(body: Node) -> void:
    if body.is_in_group("player"):
        if self.has_method(CALLBACK_ON_ENTERED):
            self.call(CALLBACK_ON_ENTERED)

func _on_body_exited(body: Node) -> void:
    if body.is_in_group("player"):
        if self.has_method(CALLBACK_ON_EXIT):
            self.call(CALLBACK_ON_EXIT)
