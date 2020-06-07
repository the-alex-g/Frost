extends Node2D

var selected = {}
var index:int = -1
var phase:String = "Play"
signal selected_card(card)
signal damage_done_to_player(damage)
signal damage_done_to_enemy(damage)
signal used(index)
signal attack
signal player_turn
signal enemy_played(card)
signal enemy_turn
signal fight_over
signal card_not_played(card)
signal cards_died(number)
signal restart
signal new_deck(deck)

func _on_Player_selected(card, index2):
	if phase == "Play":
		selected = card
		index = index2

func _on_Battlefield_pressed():
	if not selected.empty() and phase == "Play":
		emit_signal("selected_card", selected)
		selected = {}

func _on_Player_next_pressed():
	if phase == "Play":
		emit_signal("enemy_turn")

func _on_Battlefield_damage_done_to_player(damage:int):
	if phase == "Play":
		emit_signal("damage_done_to_player", damage)

func _on_Battlefield_damage_done_to_enemy(damage:int):
	if phase == "Play":
		emit_signal("damage_done_to_enemy", damage)

func _on_Enemy_turn_over():
	if phase == "Play":
		emit_signal("attack")

func _on_Enemy_played(card):
	if phase == "Play":
		emit_signal("enemy_played", card)

func _on_Battlefield_player_turn():
	if phase == "Play":
		emit_signal("player_turn")

func _on_Battlefield_cards_died(number):
	if phase == "Play":
		emit_signal("cards_died", number)

func _on_Battlefield_used():
	if phase == "Play":
		emit_signal("used", index)

func _on_Battlefield_not_used(card):
	if phase == "Play":
		emit_signal("card_not_played", card)

func _on_Main_new_deck(deck):
	if phase == "Play":
		emit_signal("new_deck", deck)

func _on_Main_fight():
	phase = "Play"
	emit_signal("restart")

func _on_Main_edit():
	phase = "Foo"

func _on_Enemy_died():
	if phase == "Play":
		emit_signal("fight_over")
