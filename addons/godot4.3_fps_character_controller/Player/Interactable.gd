class_name Interactable extends Node

signal interacted(body)


@export_subgroup("Dialogue")
@export_file("*.json") var dialouge : String


@export_category("Prompt Settings")
@export_enum(
	"interact",
	"text",
	) var prompt_action : String = "interact"
@export_multiline var prompt_message : String = "Interact"
@export var prompt_key_override : bool = false
@export_multiline var override_text : String = ""

@export var _hasDialogue : bool = false

var _dialogue_parsed : Dictionary
var _dialogue_index : int = 1

func _ready() -> void:
	if dialouge != "":
		_parse_dialogue()


func get_key() -> String:
	var key_name = ""
	if prompt_key_override:
		return override_text
	else:
		for action in InputMap.action_get_events(prompt_action):
			if action is InputEventKey:
				key_name = action.as_text_physical_keycode()
				break
	return key_name

func get_prompt() -> String:
	return prompt_message

func interact(body) -> void:
	interacted.emit(body)

func run_dialogue() -> void:
	_dialogue_index += 1
	if _dialogue_index > _dialogue_parsed["Dialogue"].size():
		reset_current_dialogue()
	prompt_message = _dialogue_parsed["Dialogue"]["%s"%[_dialogue_index]]["Text"]

func reset_current_dialogue() -> void:
	_dialogue_index = 1

func _parse_dialogue() -> void:
	_hasDialogue = true
	var file = FileAccess.open(dialouge, FileAccess.READ)
	if file.get_open_error() != OK:
		printerr("Error opening file")
		return
	var data = file.get_as_text()	
	var json = JSON.new()
	var err = json.parse(data)
	if err == OK:
		_dialogue_parsed = json.get_data()
		print(_dialogue_parsed["Dialogue"])

	file.close()
