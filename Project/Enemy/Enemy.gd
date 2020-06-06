extends Node2D

onready var healthtext:Label = $Health
var health:int = 10
var decksize:int = -1
var total = 0
var onecost:Array = []
var twocost:Array = []
var threecost:Array = []
var mana:int = 1
var turns:int = 1
var type
var cards_in_hand:Array = []
var deck:Array = [
	{"name":"Flame Sword", "enchantment":true, "damage":2, "cost":1, "health":0, "number":3}, {"name":"Fire Spirit", "enchantment":false, "damage":1, "health":1, "cost":1, "number":3},
	{"name":"Flame Wall", "enchantment":true, "damage":0, "health":2, "cost":1, "number":3}, {"name":"Fire Crab", "enchantment":false, "damage":1, "health":3, "cost":2, "number":2},
	{"name":"Fire Drake", "enchantment":false, "damage":2, "health":2, "cost":2, "number":2}, {"name":"Fire Giant", "enchantment":false, "damage":3, "health":3, "cost":3, "number":1}
]
signal played(card)
signal turn_over

func _ready():
	drawcards(2)

func _process(delta):
	healthtext.text = str(health)

func take_turn():
	yield(get_tree().create_timer(0.5), "timeout")
	drawcards(1)
	if turns <= 3:
		mana = turns
		turns += 1
	else:
		mana = 3
	onecost.clear()
	twocost.clear()
	threecost.clear()
	for item in cards_in_hand:
		if item["cost"] == 1:
			onecost.append(item)
		elif item["cost"] == 2:
			twocost.append(item)
		elif item["cost"] == 3:
			threecost.append(item)
	if mana == 1:
		if onecost.size() > 0:
			play1()
	elif mana == 2:
		if twocost.size() > 0 and total <= 2:
			play2()
		elif twocost.size() == 0 and onecost.size() > 0:
			if total == 2:
				play1()
			if total <= 1 and onecost.size() >= 2:
				play1()
				play1()
	elif mana == 3:
		if threecost.size() > 0:
			play3()
		elif twocost.size() > 0:
			if onecost.size() > 0 and total <= 1:
				play1()
				play2()
			elif total <= 2:
				play2()
		elif onecost.size() > 0:
			if total <= 2:
				play1()
			elif total <= 1 and onecost.size() > 1:
				play1()
				play1()
			elif total == 0 and onecost.size() > 2:
				play1()
				play1()
				play1()
	yield(get_tree().create_timer(0.5), "timeout")
	emit_signal("turn_over")

func play1():
	randomize()
	var card = int(round(rand_range(0, onecost.size()-1)))
	var played = cards_in_hand[card]
	onecost.remove(card)
	cards_in_hand.erase(cards_in_hand[card])
	emit_signal("played", played)
	total += 1

func play2():
	randomize()
	var card = int(round(rand_range(0, twocost.size()-1)))
	var played = cards_in_hand[card]
	twocost.remove(card)
	cards_in_hand.erase(cards_in_hand[card])
	emit_signal("played", played)
	total += 1

func play3():
	randomize()
	var card = int(round(rand_range(0,threecost.size()-1)))
	var played = cards_in_hand[card]
	threecost.remove(card)
	cards_in_hand.erase(cards_in_hand[card])
	emit_signal("played", played)
	total += 1

func drawcards(number:int):
	decksize = deck.size()-1
	if decksize != -1:
		for _x in range(0,number):
			randomize()
			type = int(round(rand_range(0,decksize)))
			cards_in_hand.append(deck[type])
			if deck[type]["number"] == 1:
				deck.erase(deck[type])
				decksize -= 1
			else:
				deck[type]["number"] -= 1

func _on_Main_damage_done_to_enemy(damage:int):
	health -= damage

func _on_Main_enemy_turn():
	take_turn()

func _on_Main_cards_died(number):
	total -= number