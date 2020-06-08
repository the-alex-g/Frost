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
	statstext.text = str(damage)
	statstext.text += "|"
	statstext.text += str(health)

func reset():
	cardname = ""
	damage = 0
	health = 0
	type = ""
	cost = 0
	$Sprite.hide()

func _on_Area2D_mouse_entered():
	scale *= 1.2
	z_index = 1

func _on_Area2D_mouse_exited():
	scale = Vector2.ONE
	z_index = 0
