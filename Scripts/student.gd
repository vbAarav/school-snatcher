extends Resource
class_name Student

@export var name: String
var role: Role
var alignment: Role.StudentAlignment

func _init(_name: String):
	name = _name
