extends Spatial

onready var Diamond = preload('res://entities/Diamond.tscn')

export var SPEED: float = 10
export var MULTIPLIER_NOISE = 15
export var TIMER_DELAY: float = 0.2
export var SHIFT_AFTER_HIDE: float = 50

var is_send: float = false
var shift: float = randi() % 20
var SPEED_NOISE: float = 2
var noise = OpenSimplexNoise.new()
var counter = 0
var score = 0

func _ready():
	$Timer.set_wait_time(TIMER_DELAY)


func _on_Timer_timeout():
	if not is_send:
		return
	
	var x = clamp(MULTIPLIER_NOISE * noise.get_noise_1d(shift), -10, 10)
	var y = clamp(MULTIPLIER_NOISE * noise.get_noise_1d(shift), 1, 10)
	
	var diamond = Diamond.instance()
	diamond.set_name('Diamond' + String(counter))
	diamond.INITIAL_SHIFT = Vector3(x, y, 0)
	diamond.SPEED = SPEED
	diamond.connect("count_coin", self, "_on_count_coin")
	add_child(diamond)
	
	shift += SPEED_NOISE
	counter += 1
	
func _on_count_coin():
	score += 1
	get_parent().get_node("CanvasLayer/Label3").text = str(score)
	get_parent().get_node("CanvasLayer/GameOver/Label2").text = str(score)

func _on_Timer2_timeout():
	is_send = !is_send
	$Timer2.wait_time = rand_range(1, 3)
	shift += SHIFT_AFTER_HIDE
