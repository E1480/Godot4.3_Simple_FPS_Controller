extends RayCast3D

@export var Prompt : RichTextLabel
var curr_dialogue : String

func _physics_process(delta: float) -> void:

	if is_colliding():
		var collider = get_collider()
		
		if collider is Interactable:
			if collider.prompt_action == "interact":
				# Prompt Logic
				if Prompt.text == collider.get_prompt()+ " ["+collider.get_key()+"]":
					pass
				else:
					Prompt.text = collider.get_prompt()+ " ["+collider.get_key()+"]"
				# Key Pressed Logic
				if collider._hasDialogue:
					curr_dialogue = collider.dialouge
					if Input.is_action_just_pressed(collider.prompt_action):
						collider.run_dialogue()

				elif Input.is_action_just_pressed(collider.prompt_action):
					collider.interact(owner)
				


			else:
				Prompt.text = collider.get_prompt()
	else:
		Prompt.text = ""
