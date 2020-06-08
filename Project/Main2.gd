extends Node2D

signal new_deck(deck)
signal edit
signal fight

func _on_CardEdit_deck_ready(deck):
	emit_signal("new_deck", deck)
	emit_signal("fight")

func _on_Battlefield_fight_over():
	emit_signal("edit")

func _on_Battlefield_dooble():
	emit_signal("edit")
