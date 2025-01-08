extends ScrollContainer
@onready var dialogue_scene = preload("res://Dialogue/canvas_layer.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		#intancia
	var dialogue = dialogue_scene.instantiate() 
	if not dialogue:
		print("Falha ao instanciar dialogue")
		return
		
	$Control/ScrollContainer.add_child(dialogue)
