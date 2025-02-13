class_name Interactable extends Node

signal interacted(body)

@export var prompt_message : String = "Interact"
@export var prompt_action : String = "interact"

func get_key() -> String:
	var key_name = ""
	for action in InputMap.action_get_events(prompt_action):
		if action is InputEventKey:
			key_name = action.as_text_physical_keycode()
			break
	return key_name

func get_prompt() -> String:
	return prompt_message

func interact(body) -> void:
	interacted.emit(body)


