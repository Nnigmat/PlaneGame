extends Spatial

signal count_coin
export var SPEED = 5
var is_removable = true
export var INITIAL_SHIFT = Vector3(0, 0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	var location = get_global_transform()
	location.origin = INITIAL_SHIFT + location.origin
	set_global_transform(location)


func _process(delta):
	var location = get_global_transform()
	location.origin = location.origin + Vector3(0, 0, -SPEED * delta)
	set_global_transform(location)


func _on_Area_area_entered(area):
	if area.get_name() == "PlaneArea" and is_removable:
		get_parent().remove_child(self)
		emit_signal("count_coin")


func _on_Timer_timeout():
	get_parent().remove_child(self)
	

func _on_Timer2_timeout():
	is_removable = false
