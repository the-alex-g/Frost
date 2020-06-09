extends Node2D

onready var music:AudioStreamPlayer = $AudioStreamPlayer
onready var pressed:AudioStreamPlayer = $Pressed
onready var instrux:Node2D = $Instrux
onready var play:Button = $VBoxContainer/Play
onready var back:Button = $Instrux/Sprite/Back
onready var Instrux:Button = $VBoxContainer/Instructions
var scene:PackedScene = preload("res://Control.tscn")

func _ready():
	music.play()

func _on_Play_pressed():
	pressed.play()
	yield(get_tree().create_timer(0.5), "timeout")
	var _error = get_tree().change_scene_to(scene)

func _on_Instructions_pressed():
	instrux.visible = true
	Instrux.disabled = true
	play.disabled = true
	back.disabled = false

func _on_Back_pressed():
	instrux.visible = false
	Instrux.disabled = false
	play.disabled = false
	back.disabled = true
