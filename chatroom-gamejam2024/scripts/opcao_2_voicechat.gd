extends Button

@onready var main_script = get_tree().root.get_node("res://Control2")

func _on_pressed():
	main_script.switch_dialogue(1)
	print("botao 2 apertado")
