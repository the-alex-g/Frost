extends Node2D

onready var music:AudioStreamPlayer = $AudioStreamPlayer
signal new_deck(deck)
signal edit
signal fight

func _ready():
	music.play()

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		var _error = get_tree().change_scene("res://Main_Menu.tscn")

func _on_CardEdit_deck_ready(deck):
	emit_signal("new_deck", deck)
	emit_signal("fight")

func _on_Battlefield_fight_over():
	emit_signal("edit")

func _on_Battlefield_dooble():
	emit_signal("edit")
