extends Node2D

onready var nametext:Label = $Sprite/Name
onready var costtext:Label = $Sprite/Cost
onready var statstext:Label = $Sprite/Stats
var cardname:String = ""
var damage:int = 0
var health:int = 0
var index:int = 0
var cost:int = 0
var hovered:bool = false
signal selected(index)

func _ready():
	nametext.text = cardname
	costtext.text = str(cost)
	statstext.text = str(damage)
	if health != 0:
		statstext.text += "|"+str(health)

func _process(_delta):
	if Input.is_mouse_button_pressed(1) and hovered:
		emit_signal("selected", index)

func _on_Area2D_input_event(viewport, event, shape_idx):
	emit_signal("selected", index)
