extends Node2D

onready var hand = $HBoxContainer
onready var manatext:Label = $Label
onready var healthtext:Label = $Health
var cards:PackedScene = preload("res://Player/Cards/Card.tscn")
var decksize:int = -1
var type:int
var playphase:bool = true
var health:int = 12
var handspace:Vector2 = Vector2(0,0)
var cards_in_hand:Array = []
var turn:int = 1
var mana:int = 1
var deck:Array = [
	{"name":"Frost Sword", "type":"enchantment", "damage":2, "cost":1, "health":0, "number":3}, {"name":"Frost Spirit", "type":"creature", "damage":1, "health":1, "cost":1, "number":3},
	{"name":"Ice Shield","type":"enchantment", "damage":0, "health":2, "cost":1, "number":3}, {"name":"Snow Crab", "type":"creature", "damage":1, "health":3, "cost":2, "number":2},
	{"name":"Snow Drake", "type":"creature", "damage":2, "health":2, "cost":2, "number":2}, {"name":"Ice Giant", "type":"creature", "damage":3, "health":3, "cost":3, "number":1}
]
signal selected(card, index)
signal used(index)
signal next_pressed()

func _ready():
	drawcards(3)

func find(variable:String):
	var foundvar = deck[type][variable]
	return foundvar

func drawcards(number:int):
	decksize = deck.size()-1
	#for item in deck:
		#decksize += 1
	for _x in range(0,number):
		if decksize >= 0:
			randomize()
			type = int(round(rand_range(0,decksize)))
			var card = cards.instance()
			card.cardname = find("name")
			card.damage = find("damage")
			card.health = find("health")
			card.cost = find("cost")
			card.type = find("type")
			card.index = cards_in_hand.size()
			cards_in_hand.append(deck[type])
			if find("number") == 1:
				deck.erase(deck[type])
				decksize -= 1
			else:
				deck[type]["number"] -= 1
			card.position = handspace
			card.connect("selected", self, "selected")
			var _error = connect("used", card, "used")
			handspace.x += 100
			hand.add_child(card)

func _process(delta):
	healthtext.text = str(health)
	manatext.text = str(mana)

func selected(index):
	if mana >= cards_in_hand[index]["cost"]:
		emit_signal("selected", cards_in_hand[index], index)

func _on_Main_used(index):
	mana -= cards_in_hand[index]["cost"]
	cards_in_hand.erase(cards_in_hand[index])
	handspace.x -= 100
	emit_signal("used", index)

func new_turn():
	turn += 1
	if turn < 3:
		mana = turn
	else:
		mana = 3
	drawcards(1)

func _on_Button_pressed():
	emit_signal("next_pressed")

func _on_Main_damage_done_to_player(damage):
	health -= damage

func _on_Main_new_deck(newdeck):
	deck = newdeck

func _on_Main_restart():
	reset()

func reset():
	health = 12
	mana = 1
	turn = 1
	cards_in_hand.clear()
	handspace = Vector2.ZERO
	position = Vector2.ZERO
	drawcards(3)
