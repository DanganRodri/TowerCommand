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


const LEVEL3 = {
	"WAVE1": {
		"EnemyList": ["basic","basic","basic","basic","basic","basic","basic"],
		"SpawnPoint": 0
	},
	"WAVE2": {
		"EnemyList": ["basic","speedy","basic","basic","basic","speedy","basic"],
		"SpawnPoint": 2
	},
	"WAVE3": {
		"EnemyList": ["basic","speedy","jammer","speedy","basic","basic","stealth"],
		"SpawnPoint": 1
	},
	"WAVE4": {
		"EnemyList": ["basic","basic","tank","stealth","stealth","speedy","speedy"],
		"SpawnPoint": 1
	},
	
	"WAVE5": {
		"EnemyList": ["basic","speedy","basic","basic","basic","speedy","basic"],
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
