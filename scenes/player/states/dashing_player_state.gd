class_name DashingPlayerState
extends PlayerMovementState

@export var SPEED: float = 15.0
@export_range(0, 1, 0.1) var ACCELERATION: float = 0.1
@export_range(0, 1, 0.1) var DECELERATION: float = 0.25
@export var DASH_SPEED: float = 20.0

var previusState: NodeState

func enter(previousState) -> void:
    PLAYER.velocity = PLAYER.velocity * Vector3(DASH_SPEED, 0, DASH_SPEED)
    self.previusState = previousState
    # ANIMATION.play("JumpStart")

func update(delta):
    PLAYER.update_gravity(delta)
    PLAYER.update_input(SPEED, ACCELERATION, DECELERATION)
    PLAYER.update_velocity()

    if Input.is_action_just_pressed("jump") and previusState.name != NodeStateMachine.DOUBLE_JUMPING_STATE:
        transition.emit(NodeStateMachine.DOUBLE_JUMPING_STATE)

    if PLAYER.velocity.y < -3.0 and not PLAYER.is_on_floor():
        transition.emit(NodeStateMachine.FALLING_STATE)

    if PLAYER.is_on_floor():
        # ANIMATION.play("JumpEnd")
        transition.emit(NodeStateMachine.IDLE_STATE)
