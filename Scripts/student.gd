extends Node
class_name Student

# References
@onready var Sprite = $Sprite2D
@onready var InformationLabel = $Information
@onready var NameLabel = $Name

# Variables
@export var display_name: String = ""
var role: Role
var alignment: Role.StudentAlignment

var is_selected = false

func _ready():
	NameLabel.text = display_name
	InformationLabel.text = "1 is Good"
	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		is_selected = not is_selected
		if is_selected:
			Sprite.modulate = Color(1.5, 1.5, 1.5)
		else:
			Sprite.modulate = Color(1, 1, 1)
