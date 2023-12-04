@tool
extends EditorPlugin

func _enter_tree() -> void:
	add_custom_type("ToastContainer", "Control", preload("res://addons/moreguitypes/nodes/toast_container.gd"), load("res://addons/moreguitypes/icons/toast.svg"))

func _exit_tree() -> void:
	remove_custom_type("ToastContainer");
