extends Node2D

onready var card1 = $CardOnField
onready var card2 = $CardOnField2
onready var card3 = $CardOnField3
onready var enemy1 = $EnemyCard
onready var enemy2 = $EnemyCard2
onready var enemy3 = $EnemyCard3
var lastpressed:int = 0
signal pressed
signal damage_done_to_player(damage)
signal damage_done_to_enemy(damage)

func _on_CardOnField_selected():
	emit_pressed(1)

func _on_CardOnField2_selected():
	emit_pressed(2)

func _on_CardOnField3_selected():
	emit_pressed(3)

func emit_pressed(section:int):
	lastpressed = section
	emit_signal("pressed")

func _on_Main_selected_card(card):
	if lastpressed == 1:
		card1.damage = card["damage"]
		card1.health = card["health"]
		card1.cardname = card["name"]
		card1.cost = card["cost"]
		card1.generate_text()
	elif lastpressed == 2:
		card2.damage = card["damage"]
		card2.health = card["health"]
		card2.cardname = card["name"]
		card2.cost = card["cost"]
		card2.generate_text()
	elif lastpressed == 3:
		card3.damage = card["damage"]
		card3.health = card["health"]
		card3.cardname = card["name"]
		card3.cost = card["cost"]
		card3.generate_text()

func _on_Main_attack():
	card1.health -= enemy1.damage
	enemy1.health -= card1.damage
	if card1.health <= 0:
		card1.reset()
	if enemy1.health <= 0:
		enemy1.reset()
	card2.health -= enemy2.damage
	enemy2.health -= card2.damage
	if card2.health <= 0:
		card2.reset()
	if enemy2.health <= 0:
		enemy2.reset()
	card3.health -= enemy3.damage
	enemy3.health -= card3.damage
	if card3.health <= 0:
		card3.reset()
	if enemy3.health <= 0:
		enemy3.reset()
	var enemydamage = (card1.damage+card2.damage+card3.damage)-(enemy1.health+enemy2.health+enemy3.health)
	if enemydamage > 0:
		emit_signal("damage_done_to_enemy", enemydamage)
	var playerdamage = (enemy1.damage+enemy2.damage+enemy3.damage)-(card1.health+card2.health+card3.health)
	if playerdamage > 0:
		emit_signal("damage_done_to_player", playerdamage)
