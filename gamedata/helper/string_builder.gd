extends Node
# Simulates a string builder with the bare nessecities.
# This allows us to pass a "string builder" through
# functions without needing to return it back out.

var text = ""

func append(text):
	self.text += text

func clear():
	self.text = ""

func set(text):
	self.text = text

func get():
	return self.text
