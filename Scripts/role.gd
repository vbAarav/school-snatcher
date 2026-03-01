extends Resource
class_name Role

enum StudentAlignment {GOOD, EVIL, NEUTRAL}

@export var name: String
@export var starting_alignment: StudentAlignment

func _init(_name: String, _starting_alignment: StudentAlignment):
	name = _name
	starting_alignment = _starting_alignment
	
static func flip_alignment(alignment: StudentAlignment):
	if alignment == StudentAlignment.GOOD:
		return StudentAlignment.EVIL
	elif alignment == StudentAlignment.EVIL:
		return StudentAlignment.GOOD
	else:
		return StudentAlignment.NEUTRAL
