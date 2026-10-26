extends TileMapLayer

var power = 0.5

func _ready():
	update()

func _process(_delta: float) -> void:
	var mat = self.material as ShaderMaterial
	mat.set_shader_parameter("mouse_position", get_global_mouse_position())

func update():
	#don't need to call it every frame
	var mat = self.material as ShaderMaterial
	mat.set_shader_parameter("power", MAIN.flashlight_stats.power)
	mat.set_shader_parameter("radius", MAIN.flashlight_stats.radius)
