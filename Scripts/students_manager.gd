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
	setup_game()

func setup_students():
	# Create Student Nodes
	for student_name in student_names:
		var student_instance = student_scene.instantiate() as Student
		if student_instance:
			student_instance.display_name = student_name
			add_child(student_instance)
			students.append(student_instance)
	
	# Set Student Positions and Scale
	var num_students = students.size()
	if num_students > 0:
		var viewport_width = get_viewport().get_visible_rect().size.x
		var viewport_height = get_viewport().get_visible_rect().size.y
		
		var student_width = 128.0
		var screen_edge_margin = 50.0 
		var available_width = viewport_width - (2 * screen_edge_margin)
		
		# Calculate spacing between students
		var total_student_width = num_students * student_width
		var spacing = student_width * 0.5  # Default spacing between students
		
		# Calculate scale factor if students don't fit
		var scale_factor = 1.0
		var required_width = total_student_width + (num_students - 1) * spacing
		if required_width > available_width:
			scale_factor = available_width / required_width
			spacing *= scale_factor
			student_width *= scale_factor
		
		# Calculate starting X position to center all students
		var total_width = (num_students * student_width) + ((num_students - 1) * spacing)
		var start_x = (viewport_width - total_width) / 2.0 + (student_width / 2.0)
		
		# Position and scale each student
		for i in range(num_students):
			var student = students[i]
			student.scale = Vector2(scale_factor, scale_factor)
			student.position = Vector2(start_x + i * (student_width + spacing), viewport_height / 2.0)
		
		
		
func setup_game():
	for student in students:
		student.role = Role.new("Student",  Alignment.StudentAlignment.GOOD)
	var impostor = students[randi() % students.size()]
	impostor.role = Role.new("Thief",  Alignment.StudentAlignment.EVIL)
	impostor.alignment =  Alignment.StudentAlignment.EVIL
	
	# Set Information
	for student: Student in students:
		var others = students.filter(func(x): return x != student)
		var target: Student = others[randi() % others.size()]
		var target_alignment = target.alignment
		if student.alignment ==  Alignment.StudentAlignment.EVIL:
			target_alignment =  Alignment.flip_alignment(target_alignment)
		student.set_current_information(target.display_name + " is " + str( Alignment.StudentAlignment.find_key(target_alignment)))
	

# On Signals
func _on_button_pressed() -> void:
	var selected_students: Array[Student] = []
	for student in students:
		if student.is_selected:
			selected_students.append(student)
			
	Message.text = str(selected_students)
	
