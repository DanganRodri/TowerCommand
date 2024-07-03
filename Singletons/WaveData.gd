extends Node

const LEVEL1 = {
	"WAVE1": {
		"EnemyList": ["basic","basic","basic","basic","basic","basic","basic"],
		"SpawnPoint": 0
	},
	"WAVE2": {
		"EnemyList": ["basic","tank","basic","basic","basic","tank","basic"],
		"SpawnPoint": 2
	},
	"WAVE3": {
		"EnemyList": ["basic","speedy","jammer","speedy","basic","basic","stealth"],
		"SpawnPoint": 1
	},
	"WAVE4": {
		"EnemyList": ["basic","basic","tank","stealth","stealth","speedy","boss"],
		"SpawnPoint": 1
	},
}


var enemy_probabilities = {
	"basic": 100,
	"tank": 0,
	"jammer": 0,
	"speedy": 0,
	"stealth": 0,
}
