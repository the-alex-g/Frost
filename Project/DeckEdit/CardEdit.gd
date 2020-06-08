extends Node2D

onready var selectspace:Position2D = $Position2D
onready var slider:VSlider = $VSlider
var spacemod:int = 0
var selected_index:int = 0
var select:PackedScene = preload("res://DeckEdit/Cardselect/CardSelect.tscn")
var Ice_Beetle:Dictionary = {"name":"Ice Beetle", "type":"creature", "damage":1, "health":2, "cost":1}
var Snow_Drake:Dictionary = {"name":"Snow Drake", "type":"creature", "damage":2, "health":2, "cost":2}
var Yeti:Dictionary = {"name":"Yeti", "type":"creature", "damage":3, "health":3, "cost":2}
var Ice_Spider:Dictionary = {"name":"Ice Spider", "type":"creature", "damage":2, "health":3, "cost":2}
var Wolf:Dictionary = {"name":"Wolf", "type":"creature", "damage":1, "health":1, "cost":1}
var Ice_Giant:Dictionary = {"name":"Ice Giant", "type":"creature", "damage":3, "health":3, "cost":3}
var Ice_Wurm:Dictionary = {"name":"Ice Wurm", "type":"creature", "damage":4, "health":4, "cost":3}
var Frost_Sword:Dictionary = {"name":"Frost Sword", "type":"enchantment", "damage":2, "cost":1, "health":0,}
var Ice_Shield:Dictionary = {"name":"Ice Shield","type":"enchantment", "damage":0, "health":2, "cost":1}
var Snow_Crab:Dictionary = {"name":"Snow Crab", "type":"creature", "damage":1, "health":3, "cost":2}
var Frost_Spirit:Dictionary = {"name":"Frost Spirit", "type":"creature", "damage":1, "health":1, "cost":1}
var notavailable:Array = [
	Wolf, Ice_Spider, Ice_Wurm, Yeti,Ice_Beetle]
var available:Array = [Frost_Sword, Frost_Spirit, Ice_Shield, Snow_Crab, Ice_Giant, Snow_Drake]
var deck:Array = [
	Frost_Sword, Frost_Sword, Frost_Sword, Ice_Shield, Ice_Shield, Ice_Shield, Frost_Spirit, Frost_Spirit,
	Frost_Spirit, Snow_Crab, Snow_Crab, Snow_Drake, Snow_Drake, Ice_Giant
]
var foo:Array = []
signal value_changed(value)
signal used(card, index2)
signal deck_ready(deck)

func _ready():
	position = Vector2(2000,2000)

func _on_VSlider_value_changed(value):
	emit_signal("value_changed", value)

func generate_deck():
	var number:int = 1
	for item in deck:
		get_node("Node/DeckEdit"+str(number)).generate_text(item)
		get_node("Node/DeckEdit"+str(number)).cardindex = deck.find(item)
		get_node("Node/DeckEdit"+str(number)).index = number
		number += 1

func selected(index, card):
	selected_index = index

func _on_Node_selected(index, card):
#	if selected_index != 0:
		deck.remove(card)
		deck.append(available[selected_index])
		print(str(available[selected_index]))
		emit_signal("used", available[selected_index], index)

func _on_Button_pressed():
	emit_signal("deck_ready", deck)

func _on_Main_edit():
	position = Vector2(0,0)
	reset()

func _on_Main_fight():
	position = Vector2(2000,2000)

func reset():
	for item in foo:
		deck.append(item)
	foo.clear()
	for _x in range(0,1):
		randomize()
		var number:int = int(round(rand_range(0, notavailable.size()-1)))
		var card = notavailable[number]
		available.append(card)
		notavailable.remove(number)
	generate_deck()
	for item in available:
		var Select = select.instance()
		Select.damage = item["damage"]
		Select.health = item["health"]
		Select.cardname = item["name"]
		Select.type = item["type"]
		Select.cost = item["cost"]
		Select.index = available.find(item)
		Select.card = item
		Select.position = Vector2(50,selectspace.position.y+spacemod)
		var _error = connect("value_changed", Select, "slide")
		Select.connect("selected", self, "selected")
		add_child(Select)
		slider.max_value += 50
		slider.min_value -= 50
		spacemod += 150
