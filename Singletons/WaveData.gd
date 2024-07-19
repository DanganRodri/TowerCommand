extends Node


const LEVEL1 = {
	"WAVE1": {
		"EnemyList": ["basic","basic","basic","basic","basic","basic","basic"],
		"SpawnPoint": 0
	},
	"WAVE2": {
		"EnemyList": ["basic","basic","basic","basic","basic","basicL","speedy"],
		"SpawnPoint": 0
	},
	"WAVE3": {
		"EnemyList": ["basic","speedy","jammer","speedy","basic","basic","stealth"],
		"SpawnPoint": 0
	},
	"WAVE4": {
		"EnemyList": ["basic","basic","basicL","stealth","stealth","speedyL","basic"],
		"SpawnPoint": 0
	},
	"WAVE5": {
		"EnemyList": ["basic","basic","tank","stealth","stealth","speedy","boss"],
		"SpawnPoint": 0
	},
}

const LEVEL2 = {
	"WAVE1": {
		"EnemyList": ["basic","basic","basic","basic","basic","basic","basic","basicL"],
		"SpawnPoint": 0
	},
	"WAVE2": {
		"EnemyList": ["basic","basic","basic","basic","basic","basicL","speedy","basic","speedy"],
		"SpawnPoint": 0
	},
	"WAVE3": {
		"EnemyList": ["basic","speedy","jammer","speedy","basic","basic","stealth","basicL"],
		"SpawnPoint": 1
	},
	"WAVE4": {
		"EnemyList": ["basic","basic","basicL","stealth","stealth","speedyL","basic","speedyL"],
		"SpawnPoint": 1
	},
	"WAVE5": {
		"EnemyList": ["basic","basic","basicL","stealth","stealth","speedyL","basic","stealthL"],
		"SpawnPoint": 1
	},
	"WAVE6": {
		"EnemyList": ["basic","basic","tank","stealth","stealth","speedy","boss"],
		"SpawnPoint": 0
	},
}

const LEVEL3 = {
	"WAVE1": {
		"EnemyList": ["basic","basic","basic","basic","basic","basic","basic"],
		"SpawnPoint": 0
	},
	"WAVE2": {
		"EnemyList": ["basic","speedy","basic","basic","basic","speedy","basic","stealth","speedy"],
		"SpawnPoint": 2
	},
	"WAVE3": {
		"EnemyList": ["basic","speedy","jammer","speedy","basic","basicL","stealthL"],
		"SpawnPoint": 1
	},
	"WAVE4": {
		"EnemyList": ["basic","basic","tank","stealth","stealth","speedy","speedy","speedyL","jammer"],
		"SpawnPoint": 1
	},
	
	"WAVE5": {
		"EnemyList": ["basic","speedy","basic","basic","basic","basic","stealthL","speedy","basic"],
		"SpawnPoint": 2
	},
	"WAVE6": {
		"EnemyList": ["basicL","speedyL","jammer","speedy","basic","basic","stealthL"],
		"SpawnPoint": 1
	},
	"WAVE7": {
		"EnemyList": ["basic","basic","tank","basic","stealth","speedyL","boss"],
		"SpawnPoint": 0
	},
}

const LEVEL4 = {
	"WAVE1": {
		"EnemyList": ["basic","basic","basic","basic","basic","basic","basic","basic","basic","basic","basic","basic","basic","basic"],
		"SpawnPoint": 0
	},
	"WAVE2": {
		"EnemyList": ["basic","speedy","stealth","basic","basic","speedy","stealth","basic","speedy","stealth","basic","basicL","speedy","stealthL"],
		"SpawnPoint": 1
	},
	"WAVE3": {
		"EnemyList": ["basic","speedy","jammer","speedy","basic","basic","stealth","tank","speedy","jammer","speedyL","basic","basicL","stealthL"],
		"SpawnPoint": 0
	},
	"WAVE4": {
		"EnemyList": ["basic","basic","tank","stealth","stealth","speedy","speedy","basic","jammer","tank","stealth","stealth","jammer","speedy"],
		"SpawnPoint": 1
	},
	"WAVE5": {
		"EnemyList": ["basicL","speedyL","jammer","speedy","basic","basic","stealthL","basic","speedy","basic","basic","basic","speedy","basic"],
		"SpawnPoint": 2
	},
	"WAVE6": {
		"EnemyList": ["basicL","speedyL","jammer","speedy","basic","basic","stealthL"],
		"SpawnPoint": 3
	},
	"WAVE7": {
		"EnemyList": ["basic","basic","tank","stealth","stealth","speedy","speedy","basic","speedy","basicL","basic","basic","speedyL","stealthL"],
		"SpawnPoint": 3
	},
	
	"WAVE8": {
		"EnemyList": ["basic","speedy","tank","basic","basic","speedy","stealth","basicL","speedyL","tank","basic","basicL","speedyL","stealthL"],
		"SpawnPoint": 2
	},
	"WAVE9": {
		"EnemyList": ["basicL","speedyL","jammer","speedy","basic","basic","stealthL","basicL","speedyL","jammer","speedy","basic","basic","stealthL"],
		"SpawnPoint": 1
	},
	"WAVE10": {
		"EnemyList": ["basic","basic","tank","basic","stealth","speedyL","basic","basic","tank","basicL","stealthL","speedyL","boss"],
		"SpawnPoint": 0
	},
}

var enemy_probabilities = {
	"basic": 100,
	"tank": 0,
	"jammer": 0,
	"speedy": 0,
	"stealth": 0,
	"basicL": 0,
	"speedyL": 0,
	"stealthL": 0,
}

var increase_enemy_probabilities = {
	"basic": 0,
	"tank": 0,
	"jammer": 2,
	"speedy": 40,
	"stealth": 20,
	"basicL": 15,
	"speedyL": 10,
	"stealthL": 4,
}

var increase_enemy_probabilities_advanced = {
	"basic": 0,
	"tank": 10,
	"jammer": 5,
	"speedy": 0,
	"stealth": 0,
	"basicL": 40,
	"speedyL": 25,
	"stealthL": 20,
}

func reset_probabilities():
	var enemy_probabilities = {
		"basic": 100,
		"tank": 0,
		"jammer": 0,
		"speedy": 0,
		"stealth": 0,
		"basicL": 0,
		"speedyL": 0,
		"stealthL": 0,
	}

	var increase_enemy_probabilities = {
		"basic": 0,
		"tank": 0,
		"jammer": 2,
		"speedy": 40,
		"stealth": 20,
		"basicL": 15,
		"speedyL": 10,
		"stealthL": 4,
	}

	var increase_enemy_probabilities_advanced = {
		"basic": 0,
		"tank": 10,
		"jammer": 5,
		"speedy": 0,
		"stealth": 0,
		"basicL": 40,
		"speedyL": 25,
		"stealthL": 20,
	}
