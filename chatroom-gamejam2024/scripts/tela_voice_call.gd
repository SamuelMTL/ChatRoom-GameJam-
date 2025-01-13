extends Control

@export_file("res://Dialogue/json/textoVoiceIntro.json") var json_file1: String = "" 
@export_file("res://Dialogue/json/textoVoice1Op1.json") var json_file2: String = ""
@export_file("res://Dialogue/json/textoVoice1Op2.json") var json_file3: String = ""
@export_file("res://Dialogue/json/textoVoice2Op1.json") var json_file4: String = ""
@export_file("res://Dialogue/json/textoVoice2Op2.json") var json_file5: String = ""


@onready var label_display: Label = $Main/Chat/Chat/MarginContainer2/Label
@onready var option1_button: Button = $Opcao1
@onready var option2_button: Button = $Opcao2
@onready var next_scene_button: Button = $NextSceneButton

var dialogue = []
var current_dialogue_id = -1
var d_active = true
var next_dialogue_files = []
var choice_state = 0

func _ready():
	start()
	option1_button.pressed.connect(self._on_option1_pressed)
	option2_button.pressed.connect(self._on_option2_pressed)
	next_scene_button.pressed.connect(self._on_next_scene_button_pressed)
	next_scene_button.visible = false
	

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
		
		
func display_choice_buttons():
	# Exibe os botoes de escolha com base no estado atual
	match choice_state:
		0:
			option1_button.text = "Entrar na brincadeira"
			option2_button.text = "Defender Ariel"
		1: 
			option1_button.text = "Aceitar jogar"
			option2_button.text = "Sugerir outro jogo"
		_:
			show_next_scene_button()
			
	#exibe os botoes de escolha
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
	label_display.visible = true
	#avanca o estado do jogo
	choice_state += 1
	next_script()
	
func next_script():
	current_dialogue_id += 1	
	
	if current_dialogue_id >= len(dialogue):
		#qnd acaba o dialogo, mostra a opcao de escolha
		if next_dialogue_files.size() > 0:
			display_choice_buttons()
			label_display.visible = false
		else:
			d_active = false
			show_next_scene_button()
		return
		
	var current_data = dialogue[current_dialogue_id]
	var sender = current_data["sender"]
	var text = current_data["text"]
	label_display.text = "%s: %s" % [sender, text]
	
	hide_choice_buttons()
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		next_script()
	
func _on_option1_pressed():
	switch_dialogue(0)
	print("botao 1 apertado")
	
func _on_option2_pressed():
	switch_dialogue(1)
	print("botao 2 apertado")
	
func show_next_scene_button():
	#oculta o resto
	label_display.visible = false
	hide_choice_buttons()
	next_scene_button.visible = true
	
func _on_next_scene_button_pressed(): 
	get_tree().change_scene_to_file("res://TelaRecap2.tscn")
	print("Avançando para a próxima tela")
	
