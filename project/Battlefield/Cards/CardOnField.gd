extends Node2D

onready var nametext:Label = $Sprite/Name
onready var costtext:Label = $Sprite/Cost
onready var typetext:Label = $Sprite/Type
onready var image:AnimationPlayer = $AnimationPlayer
onready var statstext:Label = $Sprite/Stats
onready var pressedsound:AudioStreamPlayer = $AudioStreamPlayer
var cardname:String = ""
var damage:int = 0
var type:String = ""
var health:int = 0
var cost:int = 0
signal selected

func _ready():
	$Sprite.hide()

func generate_text(show):
	if show:
		$Sprite.show()
	if cardname != "":
		image.play(cardname)
	typetext.text = type
	nametext.text = cardname
	costtext.text = str(cost)
	statstext.text = str(damage)
	statstext.text += "|"
	statstext.text += str(health)

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event.is_pressed() and event.button_index == BUTTON_LEFT:
		pressedsound.play()
		emit_signal("selected")

func reset():
	cardname = ""
	damage = 0
	health = 0
	cost = 0
	$Sprite.hide()

func _on_Area2D_mouse_entered():
	scale *= 1.2
	z_index = 1

func _on_Area2D_mouse_exited():
	scale = Vector2.ONE
	z_index = 0
