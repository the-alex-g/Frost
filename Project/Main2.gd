extends Node2D

onready var main = $Battlefield
signal new_deck(deck)
signal edit
signal fight

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		main.player.reset()
		main.enemy.restart()
		var _error = get_tree().change_scene("res://Main_Menu.tscn")

func _on_CardEdit_deck_ready(deck):
	emit_signal("new_deck", deck)
	emit_signal("fight")

func _on_Battlefield_fight_over(won):
	emit_signal("edit", won)
