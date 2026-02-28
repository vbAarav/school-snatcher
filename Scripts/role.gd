extends Resource
class_name Role

enum StudentAlignment {GOOD, EVIL, NEUTRAL}

@export var name: String
@export var starting_alignment: StudentAlignment

func _init(_name: String, _starting_alignment: StudentAlignment):
	name = _name
	starting_alignment = _starting_alignment
	
	
