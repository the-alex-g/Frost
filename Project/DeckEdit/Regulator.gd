extends Node

signal selected(index)
signal used(card, index)

func _on_DeckEdit1_selected(index):
	emit_signal("selected", index)

func _on_DeckEdit2_selected(index):
	emit_signal("selected", index)

func _on_DeckEdit3_selected(index):
	emit_signal("selected", index)

func _on_DeckEdit4_selected(index):
	emit_signal("selected", index)

func _on_DeckEdit5_selected(index):
	emit_signal("selected", index)

func _on_DeckEdit6_selected(index):
	emit_signal("selected", index)

func _on_DeckEdit7_selected(index):
	emit_signal("selected", index)

func _on_DeckEdit8_selected(index):
	emit_signal("selected", index)

func _on_DeckEdit9_selected(index):
	emit_signal("selected", index)

func _on_DeckEdit10_selected(index):
	emit_signal("selected", index)

func _on_DeckEdit11_selected(index):
	emit_signal("selected", index)

func _on_DeckEdit12_selected(index):
	emit_signal("selected", index)

func _on_DeckEdit13_selected(index):
	emit_signal("selected", index)

func _on_DeckEdit14_selected(index):
	emit_signal("selected", index)

func _on_CardEdit_used(card, index):
	emit_signal("used",card,index)
