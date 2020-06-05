extends Node2D

onready var hand = $HBoxContainer
var cards:PackedScene = preload("res://Player/Cards/Card.tscn")
var decksize:int = -1
var type
var handspace:Vector2 = Vector2(0,0)
var cards_in_hand:Array = []
var deck:Array = [
	{"name":"Frost Blast", "damage":2, "cost":1, "health":0, "number":3}, {"name":"Frost Spirit", "damage":1, "health":1, "cost":1, "number":3},
	{"name":"Ice Shield", "damage":0, "health":2, "cost":1, "number":3}, {"name":"Snow Crab", "damage":1, "health":3, "cost":2, "number":2},
	{"name":"Snow Drake", "damage":2, "health":2, "cost":2, "number":2}, {"name":"Ice Giant", "damage":3, "health":3, "cost":3, "number":1}
]
signal selected(card, index)
signal used(index)

func _ready():
	drawcards(3)

func find(variable:String):
	var foundvar = deck[type][variable]
	return foundvar

func drawcards(number:int):
	decksize = -1
	for item in deck:
		decksize += 1
	for _x in range(0,number):
		randomize()
		type = int(round(rand_range(0,decksize)))
		var card = cards.instance()
		card.cardname = find("name")
		card.damage = find("damage")
		card.health = find("health")
		card.cost = find("cost")
		card.index = cards_in_hand.size()
		cards_in_hand.append(deck[type])
		if find("number") == 1:
			deck.remove(type)
			decksize -= 1
		else:
			deck[type]["number"] -= 1
		card.position = handspace
		card.connect("selected", self, "selected")
		connect("used", card, "used")
		handspace.x += 100
		hand.add_child(card)

func selected(index):
	emit_signal("selected", cards_in_hand[index], index)

func _on_Main_used(index):
	cards_in_hand.remove(index)
	emit_signal("used", index)
