class_name Player
extends CharacterBody3D

@export var MOUSE_SENSITIVITY: float = 0.5
@export_range(-70.0, -120.0, 0.5) var TILT_LOWER_LIMIT: float = -90.0
@export_range(70.0, 120.0, 0.5) var TILT_UPPER_LIMIT: float = 90.0
@export var CAMERA_CONTROLLER: Camera3D
@export var ANIMATION_PLAYER: AnimationPlayer

var _mouse_input: bool = false
var _mouse_rotation: Vector3
var _rotation_input: float
var _tilt_input: float
var _player_rotation: Vector3
var _camera_rotation: Vector3
var _current_rotation: float

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 12.0
var direction: Vector3

func _ready():
    Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event):
    if event.is_action_pressed("exit"):
        get_tree().quit()


func _unhandled_input(event):
    _mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
    if _mouse_input:
        _rotation_input = -event.relative.x * MOUSE_SENSITIVITY
        _tilt_input = -event.relative.y * MOUSE_SENSITIVITY


func _update_camera(delta):
    _current_rotation = _rotation_input
    _mouse_rotation.x += _tilt_input * delta
    _mouse_rotation.x = clamp(_mouse_rotation.x, deg_to_rad(TILT_LOWER_LIMIT), deg_to_rad(TILT_UPPER_LIMIT))
    _mouse_rotation.y += _rotation_input * delta

    _player_rotation = Vector3(0.0, _mouse_rotation.y, 0.0)
    _camera_rotation = Vector3(_mouse_rotation.x, 0.0, 0.0)

    CAMERA_CONTROLLER.transform.basis = Basis.from_euler(_camera_rotation)
    CAMERA_CONTROLLER.rotation.z = 0.0

    global_transform.basis = Basis.from_euler(_player_rotation)

    _rotation_input = 0.0
    _tilt_input = 0.0


func _physics_process(delta):
    Debug.add_property("Velocity", "%.2f" % velocity.length(), 1)
    Debug.add_property("Velocity Y", "%.2f" % velocity.y, 2)
    Debug.add_property("Current Animation", ANIMATION_PLAYER.current_animation, 3)
    Debug.add_property("Is Falling", velocity.y < -3.0 and not is_on_floor(), 4)
    Debug.add_property("Mouse Direction", _mouse_rotation.normalized(), 5)
    _update_camera(delta)


func update_gravity(_delta) -> void:
    velocity.y -= gravity * _delta


func update_input(speed: float, acceleration: float, deceleration: float) -> void:
    var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
    direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

    if direction:
        velocity.x = lerp(velocity.x, direction.x * speed, acceleration)
        velocity.z = lerp(velocity.z, direction.z * speed, acceleration)
    else:
        velocity.x = move_toward(velocity.x, 0, deceleration)
        velocity.z = move_toward(velocity.z, 0, deceleration)


func update_velocity() -> void:
    move_and_slide()

