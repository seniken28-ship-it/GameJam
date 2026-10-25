extends Node2D

#signal max_health_changed(difference)
#signal health_changed(damage)
#signal health_depleted

var damage = 10
@onready var hurtbox = get_parent().get_node("hurtbox_component")

@export var max_health = 130

var health:
	set(value):
		health = clamp(value, 0, max_health)

func _ready():
	health = max_health
	#hurtbox.connect("damaged", took_damage(damage))
	
func took_damage(damage):
		health -= damage
		print(health)
