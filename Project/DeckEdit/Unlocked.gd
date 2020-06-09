extends Node2D

onready var nametext:Label = $Name
onready var costtext:Label = $Cost
onready var statstext:Label = $Stats
onready var typetext:Label = $Type
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
