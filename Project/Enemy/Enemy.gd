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
	{"name":"Flame Sword", "damage":2, "cost":1, "health":0, "number":3}, {"name":"Fire Spirit", "damage":1, "health":1, "cost":1, "number":3},
	{"name":"Flame Wall", "damage":0, "health":2, "cost":1, "number":3}, {"name":"Fire Crab", "damage":1, "health":3, "cost":2, "number":2},
	{"name":"Fire Drake", "damage":2, "health":2, "cost":2, "number":2}, {"name":"Fire Giant", "damage":3, "health":3, "cost":3, "number":1}
]
signal played(card)
signal turn_over

func _ready():
	drawcards(2)

func _process(delta):
	healthtext.text = str(health)

func take_turn():
	randomize()
	drawcards(1)
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
		var card = int(round(rand_range(0,onecost.size())))
		var played = cards_in_hand[card]
		onecost.remove(card)
		emit_signal("played", played)
		total += 1
	elif mana == 2:
		var choice = int(round(rand_range(1,2)))
		if choice == 1 and onecost.size() >= 2 and total <= 1:
			for _x in range(0,2):
				var card = int(round(rand_range(0, onecost.size())))
				var played = cards_in_hand[card]
				onecost.remove(card)
				emit_signal("played", played)
			total += 2
		elif choice == 2 and twocost.size() >= 2 and total <= 2:
			var card = int(round(rand_range(0, twocost.size())))
			var played = cards_in_hand[card]
			twocost.remove(card)
			emit_signal("played", played)
			total += 1
		elif twocost.size() == 0 and onecost.size() > 0 and total <= 2:
			var card = int(round(rand_range(0, onecost.size())))
			var played = cards_in_hand[card]
			onecost.remove(card)
			emit_signal("played", played)
			total += 1
	emit_signal("turn_over")

func drawcards(number:int):
	decksize = -1
	for item in deck:
		decksize += 1
	if decksize != -1:
		for _x in range(0,number):
			randomize()
			type = int(round(rand_range(0,decksize)))
			cards_in_hand.append(deck[type])
			if deck[type]["number"] == 1:
				deck.remove(type)
				decksize -= 1
			else:
				deck[type]["number"] -= 1

func _on_Main_damage_done_to_enemy(damage:int):
	health -= damage

func _on_Main_enemy_turn():
	take_turn()
