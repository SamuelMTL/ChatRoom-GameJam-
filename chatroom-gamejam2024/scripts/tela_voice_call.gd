extends Control

@export_file("res://Dialogue/json/textoVoiceIntro.json") var json_file1: String = "" 
@export_file("res://Dialogue/json/textoVoice1Op1.json") var json_file2: String = ""
@export_file("res://Dialogue/json/textoVoice1Op2.json") var json_file3: String = ""
@export_file("res://Dialogue/json/textoVoice2Op1.json") var json_file4: String = ""
@export_file("res://Dialogue/json/textoVoice2Op2.json") var json_file5: String = ""

@onready var label_display: Label = $Main/Chat/Chat/MarginContainer2/Label

var dialogue = []
var current_dialogue_id = -1
var d_active = true

func _ready():
	start()

func start():
	dialogue = load_dialogue(json_file1)
	
func load_dialogue(json_file: String):
	var json_as_text = FileAccess.get_file_as_string(json_file)
	var json_as_dict = JSON.parse_string(json_as_text)
	
	return json_as_dict
		
		
func switch_dialogue(choice: int):
	if choice == 1:
		dialogue = load_dialogue(json_file2)
	elif choice == 2:
		dialogue = load_dialogue(json_file3)
	elif choice == 3:
		dialogue = load_dialogue(json_file4)
	elif choice == 4:
		dialogue = load_dialogue(json_file5)
		
	current_dialogue_id = -1
	next_script()
		
func _input(event):
	if event.is_action_pressed("ui_accept"):
		next_script()
		
func next_script():
	current_dialogue_id += 1
	
	if current_dialogue_id >= len(dialogue):
		d_active = false
		return
	
	
	#dados do dialogo atual
	var current_data = dialogue[current_dialogue_id]
	var sender = current_data['sender']
	var text = current_data['text']
	
	label_display.text = text
	

	
