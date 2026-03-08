extends Node
class_name StudentsManager

# References
@onready var Message = $"../UILayer/Label"

# Variables
@export var student_scene: PackedScene
@export var student_names: Array[String]
@export var num_impostors: int = 1

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
	# Create roles with their statements
	var statement_types = [
		Statement.StatementType.ONE_ALIGNMENT,
		Statement.StatementType.BETWEEN_TWO_ALIGNMENT
	]
	
	# Assign roles to students
	for student in students:
		var statement_type = statement_types.pick_random()
		var student_statement = Statement.new(statement_type)
		student.role = Role.new("Student", Alignment.StudentAlignment.GOOD, student_statement)
		student.alignment = Alignment.StudentAlignment.GOOD
	
	# Pick a random student to be the thief
	var impostor = students[randi() % students.size()]
	
	# Collect all in-play role statements (excluding the thief's current role)
	var inplay_statement_types = []
	for student in students:
		if student != impostor and student.role.statement:
			inplay_statement_types.append(student.role.statement.statement_type)
	
	# Thief bluffs as one of the in-play roles
	var bluff_statement_type = inplay_statement_types.pick_random() if not inplay_statement_types.is_empty() else statement_types.pick_random()
	var thief_statement = Statement.new(bluff_statement_type)
	impostor.role = Role.new("Thief", Alignment.StudentAlignment.EVIL, thief_statement)
	impostor.alignment = Alignment.StudentAlignment.EVIL
	
	# Show statements for all students
	for student: Student in students:
		if student.role.statement:
			student.role.statement.show_statement(student, self)
	

# On Signals
func _on_button_pressed() -> void:
	var selected_students: Array[Student] = []
	for student in students:
		if student.is_selected:
			selected_students.append(student)
			
	Message.text = str(selected_students)
	
