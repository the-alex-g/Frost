extends Node2D

onready var nametext:Label = $Sprite/Name
onready var costtext:Label = $Sprite/Cost
onready var typetext:Label = $Sprite/Type
onready var image:AnimationPlayer = $AnimationPlayer
onready var statstext:Label = $Sprite/Stats
var cardname:String = ""
var damage:int = 0
var health:int = 0
var type:String = ""
var cost:int = 0
signal selected

func _ready():
	$Sprite.hide()

func generate_text(show):
	if show:
		$Sprite.show()
	if cardname != "":
		image.play(cardname)
	nametext.text = cardname
	costtext.text = str(cost)
	typetext.text = type
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
	type = ""
	cost = 0
	$Sprite.hide()
