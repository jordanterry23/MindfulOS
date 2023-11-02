class_name Thought

enum GROUPS {
	THOUGHTS,
	HOME,
	WORK,
	SCHOOL,
	RELATIONSHIPS,
	DARK
}

var group
var text: String

func _init(thought_group = GROUPS.THOUGHTS, thought_text:String = "New Thought"):
	group = thought_group
	text = thought_text
