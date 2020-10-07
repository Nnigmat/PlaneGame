extends Spatial

onready var Enemy = preload('res://entities/Enemy.tscn')


const WIDTH = 3
const HEIGHT = 3

const spaces = [
	[0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0],
]

var counter = 0


func _ready():
	_create_enemies()


func _create_enemies():
	var start_pos_x = rand_range(0, spaces.size())
	var end_pos_x = start_pos_x + rand_range(1, 5)
	
	var start_pos_y = rand_range(0, spaces[0].size())
	var end_pos_y = start_pos_y + rand_range(1, 5)
	
	for i in range(start_pos_x, end_pos_x):
		for j in range(start_pos_y, end_pos_y):
			if randf() < 0.5:
				continue
				
			var enemy = Enemy.instance()
			enemy.set_name('Enemy' + String(counter))
			enemy.INITIAL_SHIFT = Vector3(10 - j * WIDTH, - 5 +  i * HEIGHT, 0)
			enemy.connect("enemy_collide", get_parent(), "_on_health_loss")
			add_child(enemy)
			
			counter += 1

func _on_enemy_collide():
	pass


func _on_Timer_timeout():	
	_create_enemies()

