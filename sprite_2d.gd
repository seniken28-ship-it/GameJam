extends Sprite2D

var x = 10

func _process(_delta: float):
	if Input.is_action_pressed("left"):
		self.global_position.x -= 10
	if Input.is_action_pressed("right"):
		self.global_position.x += 10
