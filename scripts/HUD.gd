extends CanvasLayer


func update_score(score: int):
	$Control/ScoreValue.text = str(score)

func update_height(height: int):
	$Control/HeightValue.text = str(height)
