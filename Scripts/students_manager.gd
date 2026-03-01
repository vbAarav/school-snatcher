extends Node
class_name StudentsManager

# References
@onready var Message = $"../UILayer/Label"

# Variables
@export var student_scene: PackedScene
@export var student_names: Array[String]

var students: Array[Student]

func _ready():
	setup_students()

func setup_students():
	# Create Student Nodes
	for student_name in student_names:
		var student_instance = student_scene.instantiate() as Student
		if student_instance:
			student_instance.display_name = student_name
			add_child(student_instance)
			students.append(student_instance)
	
	# Set Student Positions
	var x_offset = 0
	for student in students:
		student.position = Vector2(150 + x_offset, 300)
		x_offset += 250
		
	# Assign Student Roles
	for student in students:
		student.role = Role.new("Student", Role.StudentAlignment.GOOD)
	var impostor = students[randi() % students.size()]
	impostor.role = Role.new("Thief", Role.StudentAlignment.EVIL)
	impostor.alignment = Role.StudentAlignment.EVIL
	
	# Set Information
	for student: Student in students:
		var others = students.filter(func(x): return x != student)
		var target: Student = others[randi() % others.size()]
		var target_alignment = target.alignment
		if student.alignment == Role.StudentAlignment.EVIL:
			target_alignment = Role.flip_alignment(target_alignment)
		student.set_current_information(target.display_name + " is " + str(Role.StudentAlignment.find_key(target_alignment)))
	

# On Signals
func _on_button_pressed() -> void:
	var selected_students: Array[Student] = []
	for student in students:
		if student.is_selected:
			selected_students.append(student)
			
	Message.text = str(selected_students)
	
