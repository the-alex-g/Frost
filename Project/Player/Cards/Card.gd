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
var cost:int = 0
var type:String = ""
var last_selected:bool = false
signal selected(index)

func _ready():
	image.play(cardname)
	typetext.text = type
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

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event.is_pressed() and event.button_index == BUTTON_LEFT:
		emit_signal("selected", index)
		last_selected = true

func used(index2):
	if index == index2:
		queue_free()
	if index2 < index:
		index -= 1
		position.x -= 100

func _on_Area2D_mouse_entered():
	scale *= 1.2
	z_index = 1

func _on_Area2D_mouse_exited():
	scale = Vector2.ONE
	z_index = 0
