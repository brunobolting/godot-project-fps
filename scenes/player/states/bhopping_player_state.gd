class_name BHoppingPlayerState
extends PlayerMovementState

@export_range(0, 1, 0.1) var ACCELERATION: float = 0.1
@export_range(0, 1, 0.1) var DECELERATION: float = 0.25
@export_range(0, 0.5, 0.1) var BHOP_TIME: float = 0.1
var previusState: NodeState
var timer: Timer

func enter(previousState: NodeState) -> void:
    self.previusState = previousState
    timer = Timer.new()
    add_child(timer)
    timer.connect("timeout", _on_timer_timeout)
    timer.start(BHOP_TIME)

func update(delta: float):
    PLAYER.update_gravity(delta)
    PLAYER.update_input(PLAYER.velocity.length(), ACCELERATION, DECELERATION)
    PLAYER.update_velocity()

    if Input.is_action_pressed("jump"):
        timer.queue_free()
        transition.emit(NodeStateMachine.JUMPING_STATE)


func _on_timer_timeout():
    timer.queue_free()
    transition.emit(NodeStateMachine.IDLE_STATE)

