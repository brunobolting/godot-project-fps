class_name HealthPickup
extends PlayerPickup

@export var HEALTH: float = 10

func add_health() -> void:
    print("Health added: ", HEALTH)
    queue_free()
