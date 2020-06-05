extends Node2D

onready var area1:RichTextLabel = $RichTextLabel
onready var area2:RichTextLabel = $RichTextLabel2
onready var area3:RichTextLabel = $RichTextLabel3
var a1health:int = 0
var a1name:String = ""
var a1damage:int = 0
signal pressed

func _process(delta):
	if Input.is_mouse_button_pressed(1):
		emit_signal("pressed")

func _on_Main_selected_card(card):
	area1.text = card["name"]+"\n \n"+str(card["damage"])+"|"+str(card["health"])
