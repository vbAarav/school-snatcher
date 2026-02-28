extends Node
class_name StudentsManager

@export var student_scene: PackedScene
@export var student_names: Array[String]

var students: Array[Student]
var selected_students: Array[Student] = []

func _ready():
	create_students()
	set_students_location()

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

# Selection Functions
func select_student(index: int) -> void:
	if index >= 0 and index < students.size():
		var student = students[index]
		if not selected_students.has(student):
			selected_students.append(student)

func deselect_student(index: int) -> void:
	if index >= 0 and index < students.size():
		var student = students[index]
		selected_students.erase(student)

func select_students(indices: Array[int]) -> void:
	for index in indices:
		select_student(index)

func deselect_all() -> void:
	selected_students.clear()

func toggle_student(index: int) -> void:
	if index >= 0 and index < students.size():
		var student = students[index]
		if selected_students.has(student):
			selected_students.erase(student)
		else:
			selected_students.append(student)
