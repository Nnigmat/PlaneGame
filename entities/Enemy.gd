extends Spatial

signal enemy_collide

onready var Bullet = preload('res://entities/Bullet.tscn')

export var SPEED: float = 5
export var INITIAL_SHIFT = Vector3(0, 0, 0)


func _ready():
	var location = get_global_transform()
	location.origin = INITIAL_SHIFT + location.origin
	set_global_transform(location)

	
func _process(delta):
	var location = get_global_transform()
	location.origin = location.origin + Vector3(0, 0, -SPEED * delta)
	set_global_transform(location)
	

func _on_EnemyArea_area_entered(area):
	if area.get_name() == 'PlaneArea':
		_destroy()
		emit_signal('enemy_collide')
	
	if area.get_name() == 'BulletArea':
		_destroy()
		area.get_parent().get_parent().remove_child(area.get_parent())


func _on_Timer_timeout():
	_destroy()

	
func _destroy():
	var parent = get_parent()
	if parent:
		parent.remove_child(self)


func _on_Timer2_timeout():
	if randf() > 0.8:
		var bullet = Bullet.instance()
		bullet.INITIAL_POS = get_global_transform().origin
		bullet.SPEED = -20
		bullet.FALL = true
		bullet.get_node("Group023/BulletArea").name = 'EnemyBulletArea'
		bullet.transform = bullet.transform.rotated(Vector3(1, 0, 0), PI)
		get_tree().get_root().add_child(bullet)
