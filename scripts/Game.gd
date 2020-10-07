extends Spatial

export var LIFES = 5
var current_lifes: float = LIFES

func _ready():
	$CanvasLayer/HealthBar2D/HealthBar.max_value = LIFES
	$CanvasLayer/GameOver.hide()


func _on_health_loss():
	if current_lifes - 1 == 0:
		$CanvasLayer/GameOver.show()
		get_node('Plane').hide()
	
	current_lifes -= 1
	$CanvasLayer/HealthBar2D.update_healthbar(current_lifes)
	

func _on_Button_pressed():
	current_lifes = LIFES
	$CanvasLayer/GameOver.hide()
	$Plane.show()
	$Coins.score = 0
	$CanvasLayer/Label3.text = str(0)
	$CanvasLayer/GameOver/Label2.text = str(0)
	$CanvasLayer/HealthBar2D.update_healthbar(LIFES)
	$CanvasLayer/Label5.text = str($Plane.bullet_amount)
		
