extends Node2D

func _ready():
	$Label.text = self.get_meta("text")
