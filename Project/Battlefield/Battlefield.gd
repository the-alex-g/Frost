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
signal cards_died(number)
signal player_turn
signal used

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
		if card["type"] != "enchantment":
			card1.damage = card["damage"]
			card1.health = card["health"]
			card1.cardname = card["name"]
			card1.cost = card["cost"]
			card1.type = card["type"]
			emit_signal("used")
		elif card["type"] == "enchantment" and card1.cardname != "":
			card1.health += card["health"]
			card1.damage += card["damage"]
			emit_signal("used")
		card1.generate_text(true)
	elif lastpressed == 2:
		if card["type"] != "enchantment":
			card2.damage = card["damage"]
			card2.health = card["health"]
			card2.cardname = card["name"]
			card2.cost = card["cost"]
			card2.type = card["type"]
			emit_signal("used")
		elif card["type"] == "enchantment" and card2.cardname != "":
			card2.health += card["health"]
			card2.damage += card["damage"]
			emit_signal("used")
		card2.generate_text(true)
	elif lastpressed == 3:
		if card["type"] != "enchantment":
			card3.damage = card["damage"]
			card3.health = card["health"]
			card3.cardname = card["name"]
			card3.cost = card["cost"]
			card3.type = card["type"]
			emit_signal("used")
		elif card["type"] == "enchantment" and card3.cardname != "":
			card3.health += card["health"]
			card3.damage += card["damage"]
			emit_signal("used")
		card3.generate_text(true)

func _on_Main_attack():
	var enemy_died:int = 0
	card1.health -= enemy1.damage
	enemy1.health -= card1.damage
	if card1.health <= 0:
		card1.reset()
	if enemy1.health <= 0:
		enemy1.reset()
		enemy_died +=1
	card2.health -= enemy2.damage
	enemy2.health -= card2.damage
	if card2.health <= 0:
		card2.reset()
	if enemy2.health <= 0:
		enemy2.reset()
		enemy_died += 1
	card3.health -= enemy3.damage
	enemy3.health -= card3.damage
	if card3.health <= 0:
		card3.reset()
	if enemy3.health <= 0:
		enemy3.reset()
		enemy_died += 1
	enemy1.generate_text(false)
	enemy2.generate_text(false)
	enemy3.generate_text(false)
	card1.generate_text(false)
	card2.generate_text(false)
	card3.generate_text(false)
	emit_signal("cards_died", enemy_died)
	var enemydamage = (card1.damage - enemy1.health)+(card2.damage-enemy2.health)+(card3.damage-enemy3.health)
	if enemydamage > 0:
		emit_signal("damage_done_to_enemy", enemydamage)
	var playerdamage = (enemy1.damage - card1.health)+(enemy2.damage-card2.health)+(enemy3.damage-card3.health)
	if playerdamage > 0:
		emit_signal("damage_done_to_player", playerdamage)
	emit_signal("player_turn")

func _on_Main_enemy_played(card):
	randomize()
	var choice = int(round(rand_range(1,2)))
	var played1:bool = false
	var played2:bool = false
	var played3:bool = false
	if card["type"] != "enchantment":
		if choice == 1:
			played1 = c1p1(card)
			played2 = c1p2(card)
			played3 = c1p3(card)
		elif choice == 2:
			played1 = c2p1(card)
			played2 = c2p2(card)
			played3 = c2p3(card)
		if not played1 and not played2 and not played3:
			var choice2 = int(round(rand_range(1,3)))
			if choice2 == 1:
				gen1(card)
			elif choice2 == 2:
				gen2(card)
			elif choice2 == 3:
				gen3(card)

func c1p1(card):
	if card1.damage < card2.damage and card1.damage < card3.damage and enemy1.cardname != "":
		gen1(card)
		return true
	else:
		return false

func c1p2(card):
	if card2.damage < card1.damage and card2.damage < card3.damage and enemy2.cardname != "":
		gen2(card)
		return true
	else:
		return false

func c1p3(card):
	if card3.damage < card2.damage and card3.damage < card1.damage and enemy3.cardname != "":
		gen3(card)
		return true
	else:
		return false

func c2p1(card):
	if card1.health < card2.health and card1.health < card3.health and enemy1.cardname != "":
		gen1(card)
		return true
	else:
		return false

func c2p2(card):
	if card2.health < card1.health and card2.health < card3.health and enemy2.cardname != "":
		gen2(card)
		return true
	else:
		return false

func c2p3(card):
	if card3.health < card2.health and card3.health < card1.health and enemy3.cardname != "":
		gen3(card)
		return true
	else:
		return false

func gen1(card):
	enemy1.cardname = card["name"]
	enemy1.damage = card["damage"]
	enemy1.health = card["health"]
	enemy1.cost = card["cost"]
	enemy1.type = card["type"]
	enemy1.generate_text(true)

func gen3(card):
	enemy3.cardname = card["name"]
	enemy3.damage = card["damage"]
	enemy3.health = card["health"]
	enemy3.cost = card["cost"]
	enemy3.type = card["type"]
	enemy3.generate_text(true)

func gen2(card):
	enemy2.cardname = card["name"]
	enemy2.damage = card["damage"]
	enemy2.health = card["health"]
	enemy2.cost = card["cost"]
	enemy2.type = card["type"]
	enemy2.generate_text(true)
