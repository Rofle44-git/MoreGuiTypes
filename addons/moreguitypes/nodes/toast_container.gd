@icon("res://addons/moreguitypes/icons/toast.svg")
extends Control
class_name ToastContainer

## The amount of pixels to shift each stacked toast notification (ingores size
## of toast).
@export var toast_offset: Vector2 = Vector2(0, 20);
## The speed with which to determine a toast's lifetime (characters/cps).
@export_range(0.0, 32.0, 0.1) var cps: float = 6.0;
## The minimum lifetime of a toast.
@export_range(0.0, 15.0, 0.2) var min_time: float = 3.0;
var anchor: Vector2 = Vector2.ZERO;

func _ready() -> void:
	resized.connect(func(): anchor = Vector2i(0, size.y));

func _process(delta: float) -> void:
	for i: int in get_child_count():
		var child: Toast = get_child(i);
		child.offset = child.offset.lerp(Vector2(0, -1) * toast_offset * i - toast_offset + anchor, 10*delta);

## Sends a new toast notification.
func push(message: String) -> void:
	var toast: Toast = Toast.new(message, cps, min_time);
	add_child(toast);
	move_child(toast, 0);
	toast.offset = anchor-toast_offset;
