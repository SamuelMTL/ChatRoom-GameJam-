extends Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.connect("pressed", self._button_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _button_pressed():
	SceneManager.change_to_scene_file("res://TelaCreditos.tscn")
