extends Label

enum ChallengeType{
	GoldReduction,
	EnemyDamageReduction,
	WaveCDReduction
}

@onready var h_slider = $"../../HSlider"
@export var type : ChallengeType = ChallengeType.GoldReduction


func _process(delta):
	
	match type:
		ChallengeType.GoldReduction:
			self.text = str( 100.0 - GameData.GOLD_GAIN_PERCENTAGE_LEVELS[h_slider.value] * 100.0 ) + "%"
		ChallengeType.EnemyDamageReduction:
			self.text = str( 100.0 - GameData.ENEMY_DAMAGE_TAKEN_LEVELS[h_slider.value] * 100.0 ) + "%"
		ChallengeType.WaveCDReduction:
			self.text = "-" + str( 100.0 - GameData.TIME_BETWEEN_WAVES_LEVELS[h_slider.value] * 100.0 ) + "%"
