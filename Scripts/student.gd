extends Node
class_name Student

# References
@onready var Sprite = $Sprite2D
@onready var InformationLabel = $Information
@onready var NameLabel = $Name

# Variables
@export var display_name: String
var role: Role
var alignment: Role.StudentAlignment

func _ready():
	NameLabel.text = display_name
	InformationLabel.text = "1 is Good"	
