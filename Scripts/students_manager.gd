extends Node
class_name StudentsManager

# References
@onready var Message = $"../UILayer/Label"

# Variables
@export var student_scene: PackedScene
@export var student_names: Array[String]

var students: Array[Student]

func _ready():
	create_students()
	set_students_location()
	setup_roles()

# Initalisation Functions
func create_students():
	for student_name in student_names:
		var student_instance = student_scene.instantiate() as Student
		if student_instance:
			student_instance.display_name = student_name
			add_child(student_instance)
			students.append(student_instance)
			
func set_students_location():
	var x_offset = 0
	for student in students:
		student.position = Vector2(150 + x_offset, 300)
		x_offset += 250
		
func setup_roles():
	for student in students:
		student.role = Role.new("Student", Role.StudentAlignment.GOOD)
	students[randi() % students.size()].role = Role.new("Thief", Role.StudentAlignment.EVIL)
	print(students)

# On Signals
func _on_button_pressed() -> void:
	var selected_students: Array[Student] = []
	for student in students:
		if student.is_selected:
			selected_students.append(student)
			
	Message.text = str(selected_students)
	
