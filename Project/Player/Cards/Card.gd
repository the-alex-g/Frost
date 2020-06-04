extends Node2D

onready var text:RichTextLabel = $RichTextLabel
var cardname:String
var damage:int
var health:int
var cost:int

func _ready():
	text.text = str(damage)
