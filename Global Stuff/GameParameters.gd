extends Node

# Settings for game modifiers
var modifiers = {
	"VowelDecrease": {
		# Chances for letter spawns
		# Random letter selection is done first based off a nubmer generated from 1-10
		# Chance list represents numbers from 1-10 that when hit, returns those set of letters
		# Letters are selected with the same chance amongst each otehr
		"modifier_amount":[
			{
				"chance":[1,2],
				"letters":"AEIOU"
			},
			{
				"chance":[3,4,5,6,7],
				"letters":"LNSTRDGBCMPFHVWY"
			},
			{
				"chance":[8,9],
				"letters":"KJX"
			},
			{
				"chance":[10],
				"letters":"QZ"
			}
		],
		# Multiplier for the word when spelled
		"points_multiplier": 1.5,
		# Description of the modifiers on the level select screen
		"description":"Decrease the number of vowels that spawn by 50%. Rob may need some help!"
	},
	"LetterSpeedup": {
		# Speedup multiplier amount; speed of the level by default is multiplied
		"modifier_amount":1.5,
		# Word points multiplied by this amount when modifier is active
		"points_multiplier":1.1,
		# Description for level select
		"description":"Speeds up the letters by 1.5x! Watch out, you might miss it if you blink!"
	},
	"TimeDecrease": {
		# Time decrease multipier amount; default time is multipliedb y this
		"modifier_amount":0.70,
		# Points modifier for the amount multiplied by when a word is spelled
		"points_multiplier":1.3,
		"description":"Decreases the time time avalible by 30%. Hurry! Rob's about to be late!!!"
	}
}


var levelDescription = [
	{
		"Name":"Farm", # Name of the level
		"Difficulty":1, # of stars out of 3
		# Level descrition
		"Description":"Rob’s soon-to-be-former home. A beautiful ranch with a wonderful assortment of flowers.",
		# Requiremetns to pass the level to progress
		"Requirements": {
			"spelled": 10, # Required # of words spelled
			"points": 75 # Required points
		}
	},
	# Refer to above for standard format
	{
		"Name":"Crossroads",
		"Difficulty":2,
		"Description":"The path to broadway. The crossroads among travelers that Rob must venture through to reach his destination.",
		"Requirements": {
			"spelled": 10,
			"points": 75
		}
	},
	{
		"Name":"Broadway",
		"Difficulty":3,
		"Description":"The destination you’ve been waiting for. Illustrious and divine, it's the colosseum of broadway.",
		"Requirements": {
			"spelled": 10,
			"points": 75
		}
	},
]
