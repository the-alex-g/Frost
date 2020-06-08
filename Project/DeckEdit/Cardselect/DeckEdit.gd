extends Node2D

onready var nametext:Label = $Sprite/Name
onready var costtext:Label = $Sprite/Cost
onready var statstext:Label = $Sprite/Stats
onready var typetext:Label = $Sprite/Type
onready var image:AnimationPlayer = $AnimationPlayer
var cardname:String = ""
var damage:int = 0
var health:int = 0
var index:int = 0
var cardindex
var cost:int = 0
var type:String = ""
signal selected(index, cardindex)

func generate_text(card):
	image.play(card["name"])
	typetext.text = card["type"]
	nametext.text = card["name"]
	costtext.text = str(card["cost"])
	statstext.text = str(card["damage"])
	statstext.text += "|"
	statstext.text += str(card["health"])

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event.is_pressed() and event.button_index == BUTTON_LEFT:
		emit_signal("selected", index, cardindex)

func _on_Node_used(card, index2):
	if index2 == index:
		generate_text(card)
