@icon("res://addons/moreguitypes/icons/toast.svg")
extends Label
class_name Toast

var _cps: float;
var _min_time: float;
var offset: Vector2 = Vector2.ZERO;
var tween_offset: Vector2 = Vector2.ZERO;

func _init(message: String, cps: float, min_time: float) -> void:
	text = message;
	_cps = cps;
	_min_time = min_time;
	
func _ready() -> void:
	anchors_preset = PRESET_FULL_RECT;
	tween_offset.x = -size.x;
	show();
	var tween: Tween = create_tween();
	tween\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_BACK)\
		.tween_property(self, "tween_offset:x", 0.0, 0.2);
	await tween.finished;
	
	await get_tree().create_timer(max(_min_time, text.length()/_cps)).timeout;
	tween = create_tween();
	tween\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_SINE)\
		.tween_property(self, "tween_offset:x", -size.x, 0.2);
	await tween.finished;
	queue_free();

func _process(_delta: float) -> void:
	position = offset+tween_offset;
