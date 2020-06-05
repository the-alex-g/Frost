extends Node2D

var selected = {}
signal selected_card(card)

func _on_Player_selected(card):
	selected = card

func _on_Battlefield_pressed():
	if not selected.empty():
		emit_signal("selected_card", selected)
