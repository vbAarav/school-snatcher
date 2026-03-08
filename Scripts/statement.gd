extends Resource
class_name Statement

enum StatementType {
	ONE_ALIGNMENT,
	BETWEEN_TWO_ALIGNMENT
}

var statement_type: StatementType

func _init(_statement_type: StatementType = StatementType.ONE_ALIGNMENT):
	statement_type = _statement_type

func show_statement(student: Student, game: StudentsManager):
	match statement_type:
		StatementType.ONE_ALIGNMENT:
			one_alignment(student, game)
		StatementType.BETWEEN_TWO_ALIGNMENT:
			between_two_alignment(student, game)


func one_alignment(student: Student, game: StudentsManager):
	var others = game.students.filter(func(x): return x != student)	
	var target: Student = others.pick_random()
	
	var target_alignment = target.alignment
	
	if student.alignment == Alignment.StudentAlignment.EVIL:
		target_alignment = Alignment.flip_alignment(target_alignment)
	
	var statement = "%s is %s" % [
		target.display_name,
		Alignment.StudentAlignment.find_key(target_alignment)
	]
	
	student.set_current_information(statement)


func between_two_alignment(student: Student, game: StudentsManager):
	var students = game.students.filter(func(x): return x != student)
	
	var target_one: Student = students.pick_random()
	var remaining = students.filter(func(x): return x != target_one)
	var target_two: Student = remaining.pick_random()
	
	var target_alignment
	
	if student.alignment == Alignment.StudentAlignment.EVIL:
		var alignments = Alignment.StudentAlignment.values()
		var excluded = [target_one.alignment, target_two.alignment]
		var possible = alignments.filter(func(x): return not excluded.has(x))
		
		if possible.is_empty():
			target_alignment = alignments.pick_random()
		else:
			target_alignment = possible.pick_random()
	else:
		target_alignment = [target_one.alignment, target_two.alignment].pick_random()
	
	var statement = "One of %s and %s is %s" % [
		target_one.display_name,
		target_two.display_name,
		Alignment.StudentAlignment.find_key(target_alignment)
	]
	
	student.set_current_information(statement)
	
func one_lying(_student, _game):
	pass
	
func between_two_lying(_student, _game):
	pass
