extends Node2D

onready var nametext:Label = $Sprite/Name
onready var costtext:Label = $Sprite/Cost
onready var statstext:Label = $Sprite/Stats
var cardname:String = ""
var damage:int = 0
var health:int = 0
var cost:int = 0
signal selected

func _ready():
	$Sprite.hide()

func generate_text():
	$Sprite.show()
	nametext.text = cardname
	costtext.text = str(cost)
	statstext.text = str(damage)
	if health != 0:
		statstext.text += "|"+str(health)

func reset():
	cardname = ""
	damage = 0
	health = 0
	cost = 0
	$Sprite.hide()
