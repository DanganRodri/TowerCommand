extends Node

const GOLD_GAIN_PERCENTAGE_LEVELS = [1, 0.9, 0.75, 0.66]
const ENEMY_DAMAGE_TAKEN_LEVELS = [1, 0.9, 0.75, 0.66]
const TIME_BETWEEN_WAVES_LEVELS = [1, 0.75, 0.5, 0.25]


const COLOR_DATA = { "RANGE": {
		"BARRIER_RANGE_BORDER_COLOR": Color(0.2, 0.5, 1, 0.77),
		"BARRIER_RANGE_COLOR": Color(0, 0, 0, 0.1)
	}
}

var Challenges = { 
	"GoldGainPercentage": GOLD_GAIN_PERCENTAGE_LEVELS[0],
	"EnemyDamageTaken": ENEMY_DAMAGE_TAKEN_LEVELS[0],
	"TimeBetweenWaves": TIME_BETWEEN_WAVES_LEVELS[0]
}
