extends Node2D

onready var hand = $HBoxContainer
var cards:PackedScene = preload("res://Player/Cards/Card.tscn")
var decksize:int = -1
var type
var handspace:Vector2 = Vector2(0,0)
var deck:Array = [
	{"damage":2, "cost":1, "health":0, "number":3}, {"damage":1, "health":1, "cost":1, "number":3},
	{"damage":1, "health":3, "cost":2, "number":2}
]

func _ready():
	drawcard(3)

func findvar(variable:String):
	var foundvar = deck[type][variable]
	return foundvar

func drawcard(size):
	for item in deck:
		decksize += 1
	for x in range(0,size):
		randomize()
		type = int(round(rand_range(0,decksize)))
		var card = cards.instance()
		card.damage = findvar("damage")
		card.health = findvar("health")
		card.cost = findvar("cost")
		if findvar("number") == 1:
			deck.remove(type)
			decksize -= 1
		else:
			deck[type]["number"] -= 1
		card.position = handspace
		handspace.x += 20
		hand.add_child(card)
