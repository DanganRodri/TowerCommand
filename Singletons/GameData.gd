extends Node

const MAX_GOLD = 99999
const FASTFORWARD_STAGES = [1.0, 1.5, 2.0]
var fastforward_actual_stage = 0
const SLOWMOTION = 0.15

const BASE_SLOW = 0.60
const BASE_SLOW_DURATION = 1.2

const BASE_FREEZE_DURATION = 0.7
const BASE_FREEZE_COOLDOWN = 16

const BASE_POISON = 2
const BASE_POISON_DURATION = 3
const BASE_POISON_DOT = 1

const SKILL_OFFSET = Vector2(40,-6)

const GOLD_GAIN_PERCENTAGE_LEVELS = [1, 0.9, 0.75, 0.66]
const ENEMY_DAMAGE_TAKEN_LEVELS = [1, 0.9, 0.75, 0.66]
const TIME_BETWEEN_WAVES_LEVELS = [1, 0.75, 0.625, 0.5]

const COLOR_DATA = { 
	"RANGE": {
		"TURRET_RANGE_BORDER_COLOR": Color(0.00001665323907, 0.81538951396942, 0.20047631859779, 0.76862746477127),
		"TURRET_RANGE_COLOR": Color(1, 1, 1, 0.10000000149012),
		"BARRIER_RANGE_BORDER_COLOR": Color(0, 0.5686274766922, 1, 0.76862746477127),
		"BARRIER_RANGE_COLOR": Color(0, 0, 0, 0.1)
	}
}

var Challenges = { 
	"GoldGainPercentage": GOLD_GAIN_PERCENTAGE_LEVELS[3],
	"EnemyDamageTaken": ENEMY_DAMAGE_TAKEN_LEVELS[0],
	"TimeBetweenWaves": TIME_BETWEEN_WAVES_LEVELS[0]
}

var stat_bonus = {
	"atk": 1,
	"atk_speed": 1,
	"dmg": 1,
	"range": 1,
	"slow": 1,
	"slow_duration": 1,
	"freeze_cd": 1
}

var advanced_turrets = {
	"dps": false,
	"aoe": false,
	"ice": false,
	"sniper": false,
	"dps_ice": false
}

var pasive_skills =  {
	"freeze": false
}

var active_skills = {
	"dps": false,
	"aoe": false,
	"ice": false,
	"sniper": false
}
