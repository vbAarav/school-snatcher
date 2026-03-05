extends Resource
class_name Role

@export var name: String
@export var starting_alignment: Alignment.StudentAlignment

func _init(_name: String, _starting_alignment:  Alignment.StudentAlignment):
	name = _name
	starting_alignment = _starting_alignment
