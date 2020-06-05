extends Node2D

var selected = {}
var index:int = -1
signal selected_card(card)
signal used(index)

func _on_Player_selected(card, index2):
	selected = card
	index = index2

func _on_Battlefield_pressed():
	if not selected.empty():
		emit_signal("selected_card", selected)
		emit_signal("used", index)
