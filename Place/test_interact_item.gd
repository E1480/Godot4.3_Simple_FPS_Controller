extends Interactable

var time = Time.get_time_dict_from_system()


func _on_interacted(body:Variant) -> void:
	print( "[%02d:%02d:%02d]::" % [time.hour, time.minute, time.second] ,"<",body.name,">", " Interacted With ","<", self.name,">")
