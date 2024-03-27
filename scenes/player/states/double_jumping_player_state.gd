class_name DoubleJumpingPlayerState
extends PlayerMovementState

@export_range(0, 1, 0.1) var ACCELERATION: float = 0.1
@export_range(0, 1, 0.1) var DECELERATION: float = 0.25
@export var JUMP_HEIGHT: float = 6.5

func enter(_previousState) -> void:
    PLAYER.velocity.y = JUMP_HEIGHT
    ANIMATION.pause()

func update(delta):
    PLAYER.update_gravity(delta)
    PLAYER.update_input(PLAYER.velocity.length(), ACCELERATION, DECELERATION)
    PLAYER.update_velocity()

    if PLAYER.velocity.y < -3.0 and not PLAYER.is_on_floor():
        transition.emit(NodeStateMachine.FALLING_STATE)

    if Input.is_action_just_pressed("dash"):
        transition.emit(NodeStateMachine.DASHING_STATE)

    if PLAYER.is_on_floor():
        # ANIMATION.play("JumpEnd")
        transition.emit(NodeStateMachine.JUMPING_STATE)

