extends Node2D

signal damaged(damage)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("damage test"):
		hit()

func hit():
	damaged.emit(10)
