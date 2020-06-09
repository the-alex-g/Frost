extends Node2D

onready var selectspace:Position2D = $Position2D
onready var slider:VSlider = $VSlider
onready var button_pressed:AudioStreamPlayer = $AudioStreamPlayer
onready var music:AudioStreamPlayer = $Music
onready var show_unlocked:Sprite = $Unlocked
var spacemod:int = 0
var won:bool
var selected_index = null
var select:PackedScene = preload("res://DeckEdit/Cardselect/CardSelect.tscn")
var Ice_Beetle:Dictionary = {"name":"Ice Beetle", "type":"creature", "damage":2, "health":1, "cost":1}
var Snow_Drake:Dictionary = {"name":"Snow Drake", "type":"creature", "damage":2, "health":2, "cost":2}
var Yeti:Dictionary = {"name":"Yeti", "type":"creature", "damage":3, "health":2, "cost":2}
var Ice_Spider:Dictionary = {"name":"Ice Spider", "type":"creature", "damage":2, "health":3, "cost":2}
var Snow_Snail:Dictionary = {"name":"Snow Snail", "type":"creature", "damage":1, "health":2, "cost":1}
var Ice_Giant:Dictionary = {"name":"Ice Giant", "type":"creature", "damage":3, "health":3, "cost":3}
var Ice_Wurm:Dictionary = {"name":"Ice Wurm", "type":"creature", "damage":4, "health":4, "cost":3}
var Frost_Sword:Dictionary = {"name":"Frost Sword", "type":"enchantment", "damage":2, "cost":1, "health":0,}
var Ice_Shield:Dictionary = {"name":"Ice Shield","type":"enchantment", "damage":0, "health":2, "cost":1}
var Snow_Crab:Dictionary = {"name":"Snow Crab", "type":"creature", "damage":1, "health":3, "cost":2}
var Frost_Spirit:Dictionary = {"name":"Frost Spirit", "type":"creature", "damage":1, "health":1, "cost":1}
var notavailable:Array = [Snow_Snail, Ice_Spider, Ice_Wurm, Yeti, Ice_Beetle]
var available:Array = [Frost_Sword, Frost_Spirit, Ice_Shield, Snow_Crab, Ice_Giant, Snow_Drake]
var deck:Array = [
	Frost_Sword, Frost_Sword, Frost_Sword, Ice_Shield, Ice_Shield, Ice_Shield, Frost_Spirit, Frost_Spirit,
	Frost_Spirit, Snow_Crab, Snow_Crab, Snow_Drake, Snow_Drake, Ice_Giant
]
var deck2:Array = [
	Frost_Sword, Frost_Sword, Frost_Sword, Ice_Shield, Ice_Shield, Ice_Shield, Frost_Spirit, Frost_Spirit,
	Frost_Spirit, Snow_Crab, Snow_Crab, Snow_Drake, Snow_Drake, Ice_Giant
]
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
		get_node("Node/DeckEdit"+str(number)).cardindex = item
		get_node("Node/DeckEdit"+str(number)).index = number
		number += 1

func selected(_index, card):
	selected_index = card

func _on_Node_selected(index, card):
	if selected_index != null and deck2.count(selected_index) < 3:
		var dooble:String = space_to_underscore(selected_index["name"])
		var number = 0
		for item in deck:
			if item == card and number == index-1:
				deck.erase(item)
				deck2.erase(item)
				break
			number += 1
		deck.insert(number,get(dooble))
		deck2.insert(number, get(dooble))
		generate_deck()
		emit_signal("used", get(dooble), index)

func _on_Button_pressed():
	button_pressed.play()
	yield(get_tree().create_timer(0.5), "timeout")
	yield(get_tree().create_timer(0.5), "timeout")
	emit_signal("deck_ready", deck)

func _on_Main_edit(won2):
	position = Vector2(0,0)
	won = won2
	reset()

func _on_Main_fight():
	music.stop()
	position = Vector2(2000,2000)

func reset():
	var card
	if won:
		for _x in range(0,1):
			randomize()
			var number:int = int(round(rand_range(0, notavailable.size()-1)))
			card = notavailable[number]
			available.append(card)
			notavailable.remove(number)
		show_unlocked.visible = true
		show_unlocked.generate_text(card)
		yield(get_tree().create_timer(1), "timeout")
		show_unlocked.visible = false
	var children = selectspace.get_child_count()
	for x in range(0,children):
		var child = selectspace.get_child(x)
		child.queue_free()
	spacemod = 0
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
		selectspace.add_child(Select)
		slider.max_value += 50
		slider.min_value -= 50
		spacemod += 125
	deck.clear()
	for item in deck2:
		var foo:String = space_to_underscore(item["name"])
		deck.append(get(foo))
	music.play()
	generate_deck()

func space_to_underscore(string:String):
	var freddie:String = ""
	for character in string:
		if character == " ":
			freddie += "_"
		else:
			freddie += character
	return freddie
