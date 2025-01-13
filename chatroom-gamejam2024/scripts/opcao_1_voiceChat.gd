extends Button

@onready var main_script = get_node("/root/Control")

func _on_pressed():
	main_script.switch_dialogue(0)
	print("botao 1 apertado")
