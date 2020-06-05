extends Node2D

onready var nametext:Label = $Sprite/Name
onready var costtext:Label = $Sprite/Cost
onready var statstext:Label = $Sprite/Stats
var cardname:String = ""
var damage:int = 5
var health:int = 5
var cost:int = 0
signal selected

func _ready():
	$Sprite.hide()

func generate_text():
	$Sprite.show()
	nametext.text = cardname
	costtext.text = str(cost)
	if damage != 0:
		statstext.text = str(damage)
	else:
		statstext.text = ""
	if health != 0 and damage != 0:
		statstext.text += "|"
	if health != 0:
		statstext.text += str(health)

func reset():
	cardname = ""
	damage = 0
	health = 0
	cost = 0
	$Sprite.hide()
