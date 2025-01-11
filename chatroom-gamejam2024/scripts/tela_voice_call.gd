extends Control

@export_file("res://Dialogue/json/textoVoiceIntro.json") var json_file: String = "" 

@onready var label_display: Label = $Main/Chat/Chat/MarginContainer2/Label
@onready var option1_button: Button = $Main/Chat/Chat/MarginContainer2/HBoxContainer/Opcao1
@onready var option2_button: Button = $Main/Chat/Chat/MarginContainer2/HBoxContainer/Opcao2

var dialogue = []
var current_dialogue_id = -1
var d_active = true
var current_choices = []

func _ready():
	start()

func start():
	var json_data = load_dialogue(json_file)
	if "intro" in json_data:
		dialogue = json_data["intro"]
	else:
		print("Chave 'intro' não encontrada no JSON!")
		dialogue = []

	print("Diálogo carregado:", dialogue)
	show_next_dialogue()
	
func load_dialogue(json_file: String) -> Dictionary:
	if !FileAccess.file_exists(json_file):
		push_error("Arquivo JSON não encontrado: " + json_file)
		return {}

	var json_as_text = FileAccess.get_file_as_string(json_file)
	if json_as_text == "":
		push_error("Falha ao carregar o arquivo JSON: " + json_file)
		return {}

	var json_result = JSON.parse_string(json_as_text)
	if json_result.get("error", OK) != OK:
		push_error("Erro ao parsear o JSON: " + json_result.get("error_string", ""))
		return {}

	return json_result.get("result", {}) # Retorna o conteúdo do JSON ou uma lista vazia se falhar
		
		
func show_next_dialogue():
	current_dialogue_id += 1
	
	if current_dialogue_id >= len(dialogue):
		print("Fim do diálogo.")
		d_active = false
		return
	
	print("Exibindo diálogo de ID:", current_dialogue_id)
	var current_data = dialogue[current_dialogue_id]
	var sender = current_data.get("sender", "")  # Usa valor padrão vazio caso não exista
	var text = current_data.get("text", "")
	
	print("Sender:", sender)
	print("Text:", text)
	
	label_display.text = text
	
	if current_data.has("choices"):
		current_choices = current_data["choices"]
		show_options()
	else:
		current_choices = []  # Garante que current_choices seja uma lista vazia
		label_display.visible = true
		option1_button.visible = false
		option2_button.visible = false
		
func show_options():
	if len(current_choices) >= 1:
		option1_button.text = current_choices[0]["text"]
		option1_button.visible = true
		option1_button.disconnect("pressed", Callable(self, "_on_option1_pressed"))  # Remove conexão anterior
		option1_button.connect("pressed", Callable(self, "_on_option1_pressed"))
		
	if len(current_choices) >= 2:
		option2_button.text = current_choices[1]["text"]
		option2_button.visible = true
		option2_button.disconnect("pressed", Callable(self, "_on_option2_pressed"))  # Remove conexão anterior
		option2_button.connect("pressed", Callable(self, "_on_option2_pressed"))
	label_display.visible = false
	
func _on_option1_pressed():
	if len(current_choices) > 0:
		var next_key = current_choices[0].get("next_key", "")
		if next_key != "":
			dialogue = load_dialogue("res://Dialogue/json/" + next_key + ".json")
			current_dialogue_id = -1
			show_next_dialogue()

func _on_option2_pressed():
	if len(current_choices) > 1:
		var next_key = current_choices[1].get("next_key", "")
		if next_key != "":
			dialogue = load_dialogue("res://Dialogue/json/" + next_key + ".json")
			current_dialogue_id = -1
			show_next_dialogue()
	

func _input(event):
	if event.is_action_pressed("ui_accept"):
		show_next_dialogue()
		
