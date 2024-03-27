class_name DummyEnemy
extends CharacterBody3D

@export var SPEED: float = 10.0
@export var AUDIO_STREAM: AudioStreamPlayer

@onready var nav_agent: NavigationAgent3D = %NavigationAgent3D

func _ready():
    nav_agent.target_reached.connect(_on_target_reached)
    nav_agent.velocity_computed.connect(_on_velocity_computed)

func _process(_delta):
    var rms = AUDIO_STREAM.volume_db
    Debug.add_property("Volume DB", "%.2f" % rms, 6)


func _physics_process(_delta):
    var current_location = global_transform.origin
    var next_location = nav_agent.get_next_path_position()
    var new_velocity = (next_location - current_location).normalized() * SPEED

    nav_agent.velocity = new_velocity


func update_target_location(target_location: Vector3) -> void:
    nav_agent.target_position = target_location


func _on_target_reached():
    print("Target reached!")


func _on_velocity_computed(_velocity: Vector3):
    velocity = velocity.move_toward(_velocity, 0.25)
    move_and_slide()
