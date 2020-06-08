extends Node2D

onready var healthtext:Label = $Health
var health:int = 1
var decksize:int = -1
var total = 0
var onecost:Array = []
var twocost:Array = []
var threecost:Array = []
var mana:int = 1
var turns:int = 1
var type
var cards_in_hand:Array = []
var Obsidian_Fly:Dictionary = {"name":"Obsidian Fly", "type":"creature", "damage":1, "cost":1, "health":1}
var Fire_Spirit:Dictionary = {"name":"Fire Spirit", "type":"creature", "damage":1, "health":1, "cost":1}
var Magma_Ooze:Dictionary = {"name":"Magma Ooze", "type":"creature", "damage":2, "health":1, "cost":1}
var Flame_Spider:Dictionary = {"name":"Flame Spider", "type":"creature", "damage":3, "health":1, "cost":2}
var Fire_Drake:Dictionary = {"name":"Fire Drake", "type":"creature", "damage":2, "health":2, "cost":2}
var Fire_Giant:Dictionary = {"name":"Fire Giant", "type":"creature", "damage":3, "health":3, "cost":3}
var Pheonix:Dictionary
var Kobold:Dictionary
var Fire_Beetle:Dictionary
var Roc:Dictionary
var savedeck:Array = [
	Obsidian_Fly, Obsidian_Fly, Obsidian_Fly, Fire_Spirit, Fire_Spirit, Fire_Spirit,Magma_Ooze, Magma_Ooze,
	Magma_Ooze, Flame_Spider, Flame_Spider, Fire_Drake, Fire_Drake, Fire_Giant
]
var deck:Array = [
	Obsidian_Fly, Obsidian_Fly, Obsidian_Fly, Fire_Spirit, Fire_Spirit, Fire_Spirit,Magma_Ooze, Magma_Ooze,
	Magma_Ooze, Flame_Spider, Flame_Spider, Fire_Drake, Fire_Drake, Fire_Giant
]
signal played(card)
signal turn_over
signal died

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
	if deck.size() > 0:
		for _x in range(0,number):
			randomize()
			type = int(round(rand_range(0,deck.size()-1)))
			cards_in_hand.append(deck[type])
			deck.remove(type)

func _on_Main_damage_done_to_enemy(damage:int):
	health -= damage
	if health <= 0:
		emit_signal("died")

func _on_Main_enemy_turn():
	take_turn()

func _on_Main_cards_died(number):
	total -= number

func _on_Main_card_not_played(card):
	cards_in_hand.append(card)

func _on_Main_restart():
	restart()

func restart():
	health = 12
	deck = savedeck
	mana = 1
	turns = 1
	cards_in_hand.clear()
	total = 0
