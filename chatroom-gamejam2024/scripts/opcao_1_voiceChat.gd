extends Button

@onready var main_script = $"/root/Control"

func _on_pressed():
	main_script.switch_dialogue(0)
