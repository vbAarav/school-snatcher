extends Node
class_name Student

# References
@onready var Sprite = $Sprite2D
@onready var InformationLabel = $Information
@onready var NameLabel = $Name

# Variables
@export var display_name: String = ""		
var role: Role
var alignment:  Alignment.StudentAlignment
var is_selected = false

func _ready():
	set_display_name(display_name)
	
func _to_string() -> String:
	return display_name + ": (" + str(role.name) + ")"

func set_display_name(_display_name: String):
	display_name = _display_name
	NameLabel.text = display_name
	
func set_current_information(_information: String):
	InformationLabel.text = _information
	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		is_selected = not is_selected
		if is_selected:
			Sprite.modulate = Color(1.5, 1.5, 1.5)
		else:
			Sprite.modulate = Color(1, 1, 1)
