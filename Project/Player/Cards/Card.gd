extends Node2D

onready var nametext:Label = $Sprite/Name
onready var costtext:Label = $Sprite/Cost
onready var statstext:Label = $Sprite/Stats
var cardname:String = ""
var damage:int = 0
var health:int = 0
var index:int = 0
var cost:int = 0
var last_selected:bool = false
signal selected(index)

func _ready():
	nametext.text = cardname
	costtext.text = str(cost)
	statstext.text = str(damage)
	if health != 0:
		statstext.text += "|"+str(health)

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event.is_pressed() and event.button_index == BUTTON_LEFT:
		emit_signal("selected", index)
		last_selected = true

func used(index2):
	if index == index2:
		queue_free()
	if index2 < index:
		index -= 1
