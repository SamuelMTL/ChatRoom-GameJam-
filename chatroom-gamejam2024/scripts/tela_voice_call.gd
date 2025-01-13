extends Control

@export_file("res://Dialogue/json/textoVoiceIntro.json") var json_file1: String = "" 
@export_file("res://Dialogue/json/textoVoice1Op1.json") var json_file2: String = ""
@export_file("res://Dialogue/json/textoVoice1Op2.json") var json_file3: String = ""
@export_file("res://Dialogue/json/textoVoice2Op1.json") var json_file4: String = ""
@export_file("res://Dialogue/json/textoVoice2Op2.json") var json_file5: String = ""


@onready var label_display: Label = $Main/Chat/Chat/MarginContainer2/Label
@onready var option1_button: Button = $Main/Chat/Chat/MarginContainer2/HBoxContainer/Opcao1
@onready var option2_button: Button = $Main/Chat/Chat/MarginContainer2/HBoxContainer/Opcao2

var dialogue = []
var current_dialogue_id = -1
var d_active = true
var next_dialogue_files = []

func _ready():
	start()

func start():
	#inicia com o primeiro json
	dialogue = load_dialogue(json_file1)
	next_dialogue_files = [json_file2, json_file3]
	current_dialogue_id = -1
	next_script()
	
func load_dialogue(json_file: String):
	var json_as_text = FileAccess.get_file_as_string(json_file)
	var json_as_dict = JSON.parse_string(json_as_text)
	return json_as_dict # Retorna o conteúdo do JSON ou uma lista vazia se falhar
		
		
func display_choice_buttons(choices):
	#exibe os botoes de escolha
	option1_button.text = choices[0]
	option2_button.text = choices[1]
	option1_button.visible = true
	option2_button.visible = true
	
func hide_choice_buttons():
	#oculta os botoes de escolha
	option1_button.visible = false
	option2_button.visible = false
	
func switch_dialogue(choice: int):
	if choice < len(next_dialogue_files):
		dialogue = load_dialogue(next_dialogue_files[choice])
		next_dialogue_files = [json_file4, json_file5] if choice == 0 else [json_file4, json_file5]
	current_dialogue_id = -1
	next_script()
	
func next_script():
	current_dialogue_id += 1	
	
	if current_dialogue_id >= len(dialogue):
		#qnd acaba o dialogo, mostra a opcao de escolha
		if next_dialogue_files.size() > 0:
			display_choice_buttons(["Opcao 1", "Opcao 2"])
		else:
			d_active = false
		return
		
	var current_data = dialogue[current_dialogue_id]
	var sender = current_data["sender"]
	var text = current_data["text"]
	label_display.text = "[%s]: %s" % [sender, text]
	
	hide_choice_buttons()
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		next_script()
	


func _on_pressed() -> void:
	pass # Replace with function body.
