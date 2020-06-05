extends Node2D

onready var text:RichTextLabel = $RichTextLabel
var cardname:String = ""
var damage:int = 0
var health:int = 0
var index:int = 0
var cost:int = 0
var hovered:bool = false
signal selected(index)

func _ready():
	text.text += cardname+" "+str(cost)+"\n \n"
	text.text += str(damage)
	if health != 0:
		text.text += "|"+str(health)

func _process(_delta):
	if Input.is_mouse_button_pressed(1) and hovered:
		emit_signal("selected", index)

func _on_RichTextLabel_mouse_entered():
	modulate = Color(1,1,0,1)
	hovered = true

func _on_RichTextLabel_mouse_exited():
	modulate = Color(1,1,1,1)
	hovered = false
