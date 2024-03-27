class_name IdlePlayerState
extends PlayerMovementState

@export_range(0, 1, 0.1) var ACCELERATION: float = 0.1
@export_range(0, 1, 0.1) var DECELERATION: float = 0.25

func enter(_previousState) -> void:
    pass
    # if ANIMATION.is_playing() and ANIMATION.current_animation == "JumpEnd":
    #     await ANIMATION.animation_finished
    #     ANIMATION.pause()
    # else:
    #     ANIMATION.pause()

func update(delta):
    PLAYER.update_gravity(delta)
    PLAYER.update_input(PLAYER.velocity.length(), ACCELERATION, DECELERATION)
    PLAYER.update_velocity()

    if PLAYER.velocity.length() > 0.0 and PLAYER.is_on_floor():
        transition.emit(NodeStateMachine.WALKING_STATE)

    if Input.is_action_just_pressed("jump") and PLAYER.is_on_floor():
        transition.emit(NodeStateMachine.JUMPING_STATE)

    if Input.is_action_just_pressed("dash"):
        transition.emit(NodeStateMachine.DASHING_STATE)

    if PLAYER.velocity.y < -3.0 and not PLAYER.is_on_floor():
        transition.emit(NodeStateMachine.FALLING_STATE)


