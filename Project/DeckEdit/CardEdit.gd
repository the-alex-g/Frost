extends Node2D

onready var selectspace:Position2D = $Position2D
onready var slider:VSlider = $VSlider
var spacemod:int = 0
var selected_index:int = 0
var select:PackedScene = preload("res://DeckEdit/Cardselect/CardSelect.tscn")
var notavailable:Array = [
	{"name":"Wolf", "type":"creature", "damage":1, "health":1, "cost":1, "number":0}, {"name":"Ice Spider", "type":"creature", "damage":2, "health":3, "cost":2, "number":0},
	{"name":"Ice Wurm", "type":"creature", "damage":4, "health":4, "cost":3, "number":0}, {"name":"Yeti", "type":"creature", "damage":3, "health":3, "cost":2, "number":0}
]
var available:Array = [{"name":"Frost Sword", "type":"enchantment", "damage":2, "cost":1, "health":0, "number":3}, {"name":"Frost Spirit", "type":"creature", "damage":1, "health":1, "cost":1, "number":3},
	{"name":"Ice Shield","type":"enchantment", "damage":0, "health":2, "cost":1, "number":3}, {"name":"Snow Crab", "type":"creature", "damage":1, "health":3, "cost":2, "number":2},
	{"name":"Snow Drake", "type":"creature", "damage":2, "health":2, "cost":2, "number":2}, {"name":"Ice Giant", "type":"creature", "damage":3, "health":3, "cost":3, "number":1}
]
var deck:Array = [{"name":"Frost Sword", "type":"enchantment", "damage":2, "cost":1, "health":0, "number":3}, {"name":"Frost Spirit", "type":"creature", "damage":1, "health":1, "cost":1, "number":3},
	{"name":"Ice Shield","type":"enchantment", "damage":0, "health":2, "cost":1, "number":3}, {"name":"Snow Crab", "type":"creature", "damage":1, "health":3, "cost":2, "number":2},
	{"name":"Snow Drake", "type":"creature", "damage":2, "health":2, "cost":2, "number":2}, {"name":"Ice Giant", "type":"creature", "damage":3, "health":3, "cost":3, "number":1},
	{"name":"Wolf", "type":"creature", "damage":1, "health":1, "cost":1, "number":0}, {"name":"Ice Spider", "type":"creature", "damage":2, "health":3, "cost":2, "number":0},
	{"name":"Ice Wurm", "type":"creature", "damage":4, "health":4, "cost":3, "number":0}, {"name":"Yeti", "type":"creature", "damage":3, "health":3, "cost":2, "number":0}
]
var foo:Array = []
signal value_changed(value)
signal used(card, index2)
signal deck_ready(deck)

func _ready():
	generate_deck()
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
			var _error = connect("value_changed", Select, "slide")
			Select.connect("selected", self, "selected")
			add_child(Select)
			slider.max_value += 25
			slider.min_value -= 25
			spacemod += 100

func _on_VSlider_value_changed(value):
	emit_signal("value_changed", value)

func generate_deck():
	var number:int = 1
	for item in deck:
		for _x in range(0, item["number"]):
			get_node("Node/DeckEdit"+str(number)).generate_text(item)
			get_node("Node/DeckEdit"+str(number)).cardindex = deck.find(item)
			get_node("Node/DeckEdit"+str(number)).index = number
			number += 1

func selected(index):
	selected_index = index
	print(str(index))

func _on_Node_selected(index, card):
	if selected_index != 0:
		if deck[card]["number"] == 1:
			deck.remove(card)
		else:
			deck[card]["number"] -= 1
		deck[selected_index]["number"] += 1
		print(str(deck))
		emit_signal("used", available[selected_index], index)

func _on_Button_pressed():
	for item in deck:
		if item["number"] == 0:
			foo.append(item)
	for item in foo:
		deck.remove(deck.find(item))
	print(str(deck))
	print(str(foo))
	emit_signal("deck_ready", deck)

func _on_Main_edit():
	position = Vector2(0,0)
	reset()

func _on_Main_fight():
	position = Vector2(2000,2000)

func reset():
	deck.append(foo)
	foo.clear()
