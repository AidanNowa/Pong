extends Node2D

var score := [0,0] # player 0:0 cpu
const PADDLE_SPEED : int = 500


func _on_ball_timer_timeout():
	$Ball.new_ball()


func _on_score_left_body_entered(body):
	#inc score of cpu
	$AudioStreamPlayer2D.play()
	score[1] += 1
	$HUD/CPUScore.text = str(score[1])
	$BallTimer.start()

func _on_score_right_body_entered(body):
	#inc score of player
	$AudioStreamPlayer2D.play()
	score[0] += 1
	$HUD/PlayerScore.text = str(score[0])
	$BallTimer.start()
