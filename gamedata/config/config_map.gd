# A reusable config map that allow us to easily create new config 
# value per new field.
extends Node

var SECTION
var KEY
var VALUE
var DEFAULT_VALUE

func _init(section, key, value):
	self.SECTION = section
	self.KEY = key
	self.VALUE = value
	self.DEFAULT_VALUE = value

func reset_to_default():
	self.VALUE = DEFAULT_VALUE