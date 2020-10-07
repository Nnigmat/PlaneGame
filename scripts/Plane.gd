extends Spatial

export var timer: float = 0
export var change_direction_timer: float = 1
export var shift: Vector3 = Vector3(0, 0, 0)
export var bullet_amount: int = 3


onready var Bullet = preload('res://entities/Bullet.tscn')

var delay = 0.2
var position = 0
var is_up = true
var cur_bullet = bullet_amount

onready var bar = get_node('Healthbar3D')

func _ready():
	get_parent().get_node("CanvasLayer/Label5").text = str(bullet_amount)
	

func _process(delta):
	delay += delta	
	
	if is_up:
		timer += delta
	else:
		timer -= delta

	if abs(timer) > change_direction_timer:
		is_up = !is_up
		
	if Input.is_mouse_button_pressed(1) and delay >= 0.5 and cur_bullet > 0:
		var bullet = Bullet.instance()
		bullet.INITIAL_POS = get_global_transform().origin
		get_tree().get_root().add_child(bullet)
		delay = 0
		cur_bullet -= 1
		get_parent().get_node("CanvasLayer/Label5").text = str(cur_bullet)
		
	
	var width = get_viewport().size.x
	var mouse_x = remap_range(get_viewport().get_mouse_position().x, 0, width, -12, 12)
	var mouse_y = remap_range(get_viewport().get_mouse_position().y, 0, width, -12, 12)
	
	var player_loc = get_global_transform()
	player_loc.origin = player_loc.origin.linear_interpolate(Vector3(-mouse_x, -mouse_y + timer,-0.5) + shift, delta*10)
	set_global_transform(player_loc)
	
func remap_range(input, minInput, maxInput, minOutput, maxOutput):
	return(input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput
