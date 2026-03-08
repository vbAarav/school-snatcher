extends Resource
class_name Role

@export var name: String
@export var starting_alignment: Alignment.StudentAlignment
var statement: Statement

func _init(_name: String, _starting_alignment:  Alignment.StudentAlignment, _statement: Statement = null):
	name = _name
	starting_alignment = _starting_alignment
	statement = _statement
