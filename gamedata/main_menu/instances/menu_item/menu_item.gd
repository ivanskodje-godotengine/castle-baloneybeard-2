extends HBoxContainer

export(int, "Color Darkest", "Color Dark", "Color Bright", "Color Brightest") var color = 0 setget set_color
export (String) var text = "Item" setget set_text

func _enter_tree():
	pass

func set_text(new_text):
	if(get_node("menu_item") != null):
		get_node("menu_item").set_text(new_text)
		text = new_text

func get_text():
	return text

func set_color(id):
	if(id != null && get_node("menu_item") != null):
		color = id
#		get_node("menu_item").add_color_override("font_color", Color(global.color[id]))