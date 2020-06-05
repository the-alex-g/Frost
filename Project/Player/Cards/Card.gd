extends Node2D

onready var text:RichTextLabel = $RichTextLabel
var cardname:String
var damage:int
var health:int
var cost:int
var hovered:bool = false

func _ready():
	text.text += cardname+" "+str(cost)+"\n \n"
	text.text += str(damage)
	if health != 0:
		text.text += "|"+str(health)

func _on_RichTextLabel_mouse_entered():
	modulate = Color(1,1,0,1)
	hovered = true

func _on_RichTextLabel_mouse_exited():
	modulate = Color(1,1,1,1)
	hovered = false
