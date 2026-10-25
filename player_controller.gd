extends CharacterBody2D


@export var speed := 600.0
@export_range(0,1) var deceleration := 0.7
@export_range(0,1) var acceleration := 0.7
@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

@onready var buffer_timer = $BufferTImer
@onready var coyotetimer = $CoyoteTimer
var can_jump := true
@export var dash_speed := 3300
var is_dashing := false
var direction := 1
var kinetic_gauge = 0:
	set(limits):
		kinetic_gauge = clamp(limits, 0, 100)
@onready var health = $Health_component

func _physics_process(delta: float) -> void:
	
	if !is_on_floor():
		
		if can_jump == true:
			if coyotetimer.is_stopped():
				coyotetimer.start()
		if !is_dashing:
			velocity.y += get_Gravity() * delta
	else:
		can_jump = true
		coyotetimer.stop()
		if !buffer_timer.is_stopped():
			buffer_timer.stop()
			jump()

	if Input.is_action_just_pressed("temporary_kinetic_gauge_input"):
		kinetic_gauge_fill()
		print(kinetic_gauge)
	
	if Input.is_action_just_pressed("dash"):
		dash()
		
		
	if Input.is_action_just_pressed("jump"):
			if can_jump:
				jump()
			else:
				buffer_timer.start()
	
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y = fall_gravity * delta

	if Input.is_action_pressed("left"):
		direction = -1
		velocity.x = move_toward(velocity.x, direction * speed, speed * acceleration)
	elif Input.is_action_pressed("right"):
		direction = 1
		velocity.x = move_toward(velocity.x, direction * speed, speed * acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, speed * deceleration)

	move_and_slide()

	
func jump():
		velocity.y = jump_velocity
		can_jump = false

func coyoteTime():
	can_jump = false
	
func jumpBuffer():
	can_jump = false

func get_Gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity
	
func dash():
	is_dashing = true
	velocity.x = move_toward(velocity.x, dash_speed * direction, dash_speed)
	if velocity.y != 0:
		velocity.y = 0
	await get_tree().create_timer(0.1).timeout
	velocity.x = 0
	is_dashing = false
	
func kinetic_gauge_fill():
	kinetic_gauge += 10
