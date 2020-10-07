extends Spatial

export var SPEED = 10
export var INITIAL_POS = Vector3(0, 0, 0)
export var FALL = false

func _ready():
	var location = get_global_transform()
	location.origin = INITIAL_POS + location.origin
	set_global_transform(location)
	
func _process(delta):
	var location = get_global_transform()
	location.origin = location.origin + Vector3(0, -5 * delta if FALL else 0, SPEED * delta)
	set_global_transform(location)


func _on_Timer_timeout():
	get_parent().remove_child(self)

#
#func _on_BulletArea_area_entered(area):
#	if area.get_name() == 'EnemyArea' and get_parent():
#		get_parent().remove_child(self)
