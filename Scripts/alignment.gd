class_name Alignment

enum StudentAlignment {GOOD, EVIL, NEUTRAL}

static func flip_alignment(alignment: StudentAlignment):
	if alignment == StudentAlignment.GOOD:
		return StudentAlignment.EVIL
	elif alignment == StudentAlignment.EVIL:
		return StudentAlignment.GOOD
	else:
		return StudentAlignment.NEUTRAL
