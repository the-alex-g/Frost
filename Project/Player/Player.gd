extends Node2D

onready var hand = $HBoxContainer
var cards:PackedScene = preload("res://Player/Cards/Card.tscn")
var decksize:int = -1
var type
var handspace:Vector2 = Vector2(0,0)
var deck:Array = [
	{"name":"Fire Blast", "damage":2, "cost":1, "health":0, "number":3}, {"name":"Flame Spirit", "damage":1, "health":1, "cost":1, "number":3},
	{"name":"Flame Shield", "damage":0, "health":2, "cost":1, "number":3}, {"name":"Fire Crab", "damage":1, "health":3, "cost":2, "number":2},
	{"name":"Drake", "damage":2, "health":2, "cost":2, "number":2}, {"name":"Fire Giant", "damage":3, "health":3, "cost":3, "number":1}
]

func _ready():
	drawcards(3)

func findvar(variable:String):
	var foundvar = deck[type][variable]
	return foundvar

func drawcards(number:int):
	for item in deck:
		decksize += 1
	for _x in range(0,number):
		randomize()
		type = int(round(rand_range(0,decksize)))
		var card = cards.instance()
		card.cardname = findvar("name")
		card.damage = findvar("damage")
		card.health = findvar("health")
		card.cost = findvar("cost")
		if findvar("number") == 1:
			deck.remove(type)
			decksize -= 1
		else:
			deck[type]["number"] -= 1
		card.position = handspace
		handspace.x += 100
		hand.add_child(card)
