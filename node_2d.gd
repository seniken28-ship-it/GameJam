extends Node2D

var lbl = preload("res://lbl.tscn")

func _ready():
	print("hello world")
	var new_child = lbl.instantiate()
	new_child.set_meta('text', "this is a metadata")
	self.add_child(new_child)
	print(read_json("res://lore.json"))

func read_json(path):
	var file = FileAccess.get_file_as_string(path)
	var data = JSON.parse_string(file)
	return data

func random_thing():
	var x = 10
	match x:
		5:
			print('x = 5')
		10:
			print("10 is the value of this thing")
		15:
			print("idk man")

func _on_button_pressed() -> void:
	$Sprite2D.visible = not($Sprite2D.visible)
