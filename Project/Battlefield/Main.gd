extends Node2D

var selected = {}
var index:int = -1
var phase:String = "Play"
signal selected_card(card)
signal damage_done_to_player(damage)
signal damage_done_to_enemy(damage)
signal used(index)
signal attack
signal enemy_played(card)
signal enemy_turn

func _on_Player_selected(card, index2):
	selected = card
	index = index2

func _on_Battlefield_pressed():
	if not selected.empty():
		emit_signal("selected_card", selected)
		emit_signal("used", index)
		selected.clear()

func _on_Player_next_pressed():
	emit_signal("enemy_turn")

func _on_Battlefield_damage_done_to_player(damage:int):
	emit_signal("damage_done_to_player", damage)

func _on_Battlefield_damage_done_to_enemy(damage:int):
	emit_signal("damage_done_to_enemy", damage)

func _on_Enemy_turn_over():
	emit_signal("attack")

func _on_Enemy_played(card):
	emit_signal("enemy_played", card)
