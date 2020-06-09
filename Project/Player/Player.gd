extends Node2D

onready var hand = $HBoxContainer
onready var manatext:Label = $Label
onready var healthtext:Label = $Health
onready var pressed:AudioStreamPlayer = $AudioStreamPlayer
onready var draw_card:AudioStreamPlayer = $AudioStreamPlayer2
var cards:PackedScene = preload("res://Player/Cards/Card.tscn")
var decksize:int = -1
var type:int
var playphase:bool = true
var health:int = 12
var handspace:Vector2 = Vector2(0,0)
var cards_in_hand:Array = []
var turn:int = 1
var mana:int = 1
var Ice_Beetle:Dictionary = {"name":"Ice Beetle", "type":"creature", "damage":1, "health":2, "cost":1}
var Snow_Drake:Dictionary = {"name":"Snow Drake", "type":"creature", "damage":2, "health":2, "cost":2}
var Yeti:Dictionary = {"name":"Yeti", "type":"creature", "damage":3, "health":2, "cost":2}
var Ice_Spider:Dictionary = {"name":"Ice Spider", "type":"creature", "damage":2, "health":3, "cost":2}
var Wolf:Dictionary = {"name":"Wolf", "type":"creature", "damage":1, "health":1, "cost":1}
var Ice_Giant:Dictionary = {"name":"Ice Giant", "type":"creature", "damage":3, "health":3, "cost":3}
var Ice_Wurm:Dictionary = {"name":"Ice Wurm", "type":"creature", "damage":4, "health":4, "cost":3}
var Frost_Sword:Dictionary = {"name":"Frost Sword", "type":"enchantment", "damage":2, "cost":1, "health":0,}
var Ice_Shield:Dictionary = {"name":"Ice Shield","type":"enchantment", "damage":0, "health":2, "cost":1}
var Snow_Crab:Dictionary = {"name":"Snow Crab", "type":"creature", "damage":1, "health":3, "cost":2}
var Frost_Spirit:Dictionary = {"name":"Frost Spirit", "type":"creature", "damage":1, "health":1, "cost":1}
var deck:Array = [
	Frost_Sword, Frost_Sword, Frost_Sword, Ice_Shield, Ice_Shield, Ice_Shield, Frost_Spirit, Frost_Spirit,
	Frost_Spirit, Snow_Crab, Snow_Crab, Snow_Drake, Snow_Drake, Ice_Giant
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
	for _x in range(0,number):
		if deck.size() > 0:
			randomize()
			type = int(round(rand_range(0,deck.size()-1)))
			var card = cards.instance()
			card.cardname = find("name")
			card.damage = find("damage")
			card.health = find("health")
			card.cost = find("cost")
			card.type = find("type")
			card.index = cards_in_hand.size()
			cards_in_hand.append(deck[type])
			deck.remove(type)
			card.position = handspace
			card.connect("selected", self, "selected")
			var _error = connect("used", card, "used")
			handspace.x += 100
			hand.add_child(card)
			draw_card.play()
			yield(get_tree().create_timer(0.5), "timeout")

func _process(_delta):
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
	pressed.play()
	yield(get_tree().create_timer(0.5), "timeout")
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
