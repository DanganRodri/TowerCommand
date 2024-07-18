extends Node

var level : int
const LEVEL_PATH : String = "res://scenes/level"
var game_ended : bool = false


const MAX_GOLD = 99999
const INITIAL_GOLD_ENDLESS = 5000
const INITIAL_GOLD_CAMPAING = 300
const MAX_SCORE = 99999999
const FASTFORWARD_STAGES = [1.0, 1.5, 2.0]
var fastforward_actual_stage = 0
const SLOWMOTION = 0.15

const BASE_SLOW = 0.60
const BASE_SLOW_DURATION = 1.2

const BASE_FREEZE_DURATION = 1
const BASE_FREEZE_COOLDOWN = 16

const BASE_STUN_DURATION = 0.5

const BASE_BURN_DURATION = 2
const BASE_BURN_COOLDOWN = 16
const BASE_BURN_DAMAGE = 0.5
const BASE_BURN_DOT = 0.5

const BASE_POISON = 2
const BASE_POISON_DURATION = 3
const BASE_POISON_DOT = 1
const MAX_BOSS_POISON_STAKS = 3

const SKILL_OFFSET = Vector2(40,-6)

const SPAWN_INTERVAL_BASE = 1.0
const WAVE_INTERVAL = 11.5

const LORD_STAT_BONUS = 2.5

const GOLD_GAIN_PERCENTAGE_LEVELS = [1, 0.9, 0.75, 0.66]
const ENEMY_DAMAGE_TAKEN_LEVELS = [1, 0.9, 0.75, 0.66]
const TIME_BETWEEN_WAVES_LEVELS = [1, 0.75, 0.625, 0.5]

const COLOR_DATA = { 
	"RANGE": {
		"TURRET_RANGE_BORDER_COLOR": Color(0.00001665323907, 0.81538951396942, 0.20047631859779,0.3),
		"TURRET_RANGE_COLOR": Color(1, 1, 1, 0.10000000149012),
		"BARRIER_RANGE_BORDER_COLOR": Color(0, 0.5686274766922, 1, 0.3),
		"BARRIER_RANGE_COLOR": Color(0, 0, 0, 0.1)
	},
	"STATUS": {
		"INMUNE_COLOR": Color(0.91303491592407, 0.9362650513649, 0.00000462055232), # Amarillo
		"DAMAGED_COLOR": Color(1, 0, 0), # Rojo
		"POISONED_COLOR": Color(0.01300281099975, 0.62915825843811, 0), # Verde
		"FREEZED_COLOR": Color(0, 0.17647059261799, 0.60392159223557), # Azul oscuro
		"SLOWED_COLOR": Color(0.4, 0.83, 1), # Azul claro
		"BURNED_COLOR": Color(0.85827624797821, 0.42022228240967, 0.10299212485552), # Naranja
		"STUN_COLOR": Color(0.17647059261799, 1, 0.77647060155869) # Turquesa
	}
}

var gold : int = 5000
var initial_gold = gold
var score : int = 0
var score_increase = 0
var health : int = 30

var Challenges = { 
	"GoldGainPercentage": GOLD_GAIN_PERCENTAGE_LEVELS[0],
	"EnemyDamageTaken": ENEMY_DAMAGE_TAKEN_LEVELS[0],
	"TimeBetweenWaves": TIME_BETWEEN_WAVES_LEVELS[0],
	"Endless": false
}

var stat_bonus = {
	"atk": 1,
	"atk_speed": 1,
	"dmg": 1,
	"range": 1,
	"atk_dps": 1,
	"atk_speed_dps": 1,
	"poison_dot": 1,
	"poison_splash": 1,
	"weakened_value" : 1,
	"def_pen_dps": 1,
	"slow": 1,
	"slow_duration": 1,
	"freeze_cd": 1,
	"atk_ice": 1,
	"range_ice": 1,
	"atk_speed_ice": 1,
	"atk_aoe": 1,
	"atk_speed_aoe": 1,
	"range_aoe": 1,
	"burn_cd": 1,
	"burn_damage": 1,
	"atk_speed_sniper": 1,
	"range_sniper": 1,
	"atk_sniper": 1,
	"def_pen_sniper": 1,
	"bullet_size": 1,
	"gold_gain": 1
}

var advanced_turrets = {
	"dps": false,
	"aoe": false,
	"ice": false,
	"sniper": false,
	"double_dps": false,
	"dps_ice": false,
	"burning_aoe": false,
	"global_sniper": false
}

var pasive_skills =  {
	"freeze": false,
	"burn": false,
	"charged_sniper": false,
	"explosion_radius_upgrade": false,
	"stun_upgrade": false,
}

var active_skills = {
	"dps": false,
	"aoe": false,
	"ice": false,
	"sniper": false
}


func reset_bonuses():
	
	gold = initial_gold
	score = 0
	health = 30
	
	var stat_bonus = {
	"atk": 1,
	"atk_speed": 1,
	"dmg": 1,
	"range": 1,
	"atk_dps": 1,
	"atk_speed_dps": 1,
	"poison_dot": 1,
	"poison_splash": 1,
	"weakened_value" : 1,
	"def_pen_dps": 1,
	"slow": 1,
	"slow_duration": 1,
	"freeze_cd": 1,
	"atk_ice": 1,
	"range_ice": 1,
	"atk_speed_ice": 1,
	"atk_aoe": 1,
	"atk_speed_aoe": 1,
	"range_aoe": 1,
	"burn_cd": 1,
	"burn_damage": 1,
	"atk_speed_sniper": 1,
	"range_sniper": 1,
	"atk_sniper": 1,
	"def_pen_sniper": 1,
	"bullet_size": 1,
	"gold_gain": 1
}

	advanced_turrets = {
		"dps": false,
		"aoe": false,
		"ice": false,
		"sniper": false,
		"double_dps": false,
		"dps_ice": false,
		"burning_aoe": false,
		"global_sniper": false
	}

	pasive_skills =  {
		"freeze": false,
		"burn": false,
		"charged_sniper": false,
		"explosion_radius_upgrade": false,
		"stun_upgrade": false
	}

	active_skills = {
		"dps": false,
		"aoe": false,
		"ice": false,
		"sniper": false
	}
	
	WaveData.reset_probabilities()

func reset_challenges():
	Challenges = { 
		"GoldGainPercentage": GOLD_GAIN_PERCENTAGE_LEVELS[0],
		"EnemyDamageTaken": ENEMY_DAMAGE_TAKEN_LEVELS[0],
		"TimeBetweenWaves": TIME_BETWEEN_WAVES_LEVELS[0],
		"Endless": false
	}

func full_reset():
	reset_bonuses()
	reset_challenges()
	WaveData.reset_probabilities()
