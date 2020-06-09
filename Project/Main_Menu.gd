extends Node2D

onready var music:AudioStreamPlayer = $AudioStreamPlayer
onready var pressed:AudioStreamPlayer = $Pressed
var play:PackedScene = preload("res://Control.tscn")

func _ready():
	music.play()

func _on_Play_pressed():
	pressed.play()
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().change_scene_to(play)
