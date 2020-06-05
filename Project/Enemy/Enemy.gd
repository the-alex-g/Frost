extends Node2D

onready var healthtext:Label = $Health
var health:int = 10

func _process(delta):
	healthtext.text = str(health)

func _on_Main_damage_done_to_enemy(damage:int):
	health -= damage
