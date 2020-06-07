extends Node2D

onready var selectspace:Position2D = $Position2D
var spacemod:int = 0
var select:PackedScene = preload("res://DeckEdit/Cardselect/CardSelect.tscn")
var cards:Array = [
	{"name":"Frost Sword", "type":"enchantment", "damage":2, "cost":1, "health":0, "number":0}, {"name":"Frost Spirit", "type":"creature", "damage":1, "health":1, "cost":1, "number":0},
	{"name":"Ice Shield","type":"enchantment", "damage":0, "health":2, "cost":1, "number":0}, {"name":"Snow Crab", "type":"creature", "damage":1, "health":3, "cost":2, "number":0},
	{"name":"Snow Drake", "type":"creature", "damage":2, "health":2, "cost":2, "number":0}, {"name":"Ice Giant", "type":"creature", "damage":3, "health":3, "cost":3, "number":0},
	{"name":"Wolf", "type":"creature", "damage":1, "health":1, "cost":1, "number":0}, {"name":"Ice Spider", "type":"creature", "damage":2, "health":3, "cost":2, "number":0},
	{"name":"Ice Wurm", "type":"creature", "damage":4, "health":4, "cost":3, "number":0}, {"name":"Yeti", "type":"creature", "damage":3, "health":3, "cost":2, "number":0}
]
var available:Array = [{"name":"Frost Sword", "type":"enchantment", "damage":2, "cost":1, "health":0, "number":3}, {"name":"Frost Spirit", "type":"creature", "damage":1, "health":1, "cost":1, "number":3},
	{"name":"Ice Shield","type":"enchantment", "damage":0, "health":2, "cost":1, "number":3}, {"name":"Snow Crab", "type":"creature", "damage":1, "health":3, "cost":2, "number":2},
	{"name":"Snow Drake", "type":"creature", "damage":2, "health":2, "cost":2, "number":2}, {"name":"Ice Giant", "type":"creature", "damage":3, "health":3, "cost":3, "number":1}
]
var deck:Array = [{"name":"Frost Sword", "type":"enchantment", "damage":2, "cost":1, "health":0, "number":3}, {"name":"Frost Spirit", "type":"creature", "damage":1, "health":1, "cost":1, "number":3},
	{"name":"Ice Shield","type":"enchantment", "damage":0, "health":2, "cost":1, "number":3}, {"name":"Snow Crab", "type":"creature", "damage":1, "health":3, "cost":2, "number":2},
	{"name":"Snow Drake", "type":"creature", "damage":2, "health":2, "cost":2, "number":2}, {"name":"Ice Giant", "type":"creature", "damage":3, "health":3, "cost":3, "number":1}
]

func _ready():
	for item in available:
		if not deck.has(item):
			var Select = select.instance()
			Select.damage = item["damage"]
			Select.health = item["health"]
			Select.cardname = item["name"]
			Select.type = item["type"]
			Select.cost = item["cost"]
			Select.index = available.find(item)
			Select.position = Vector2(50,selectspace.position.y+spacemod)
			add_child(Select)
			spacemod += 100
