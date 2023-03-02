extends Node

# Settings for game modifiers
var modifiers = {
	"VowelDecrease": {
		# Chances for letter spawns
		# Chances are out of 10
		"modifier_amount":[
			{
				"chance":2,
				"letters":"AEIOU"
			},
			{
				"chance":5,
				"letters":"LNSTRDGBCMPFHVWY"
			},
			{
				"chance":2,
				"letters":"KJX"
			},
			{
				"chance":1,
				"letters":"QZ"
			}
		],
		"points_multiplier": 1.5,
		"description":"Decrease the number of vowels that spawn by 50%. Rob may need some help!"
	},
	"LetterSpeedup": {
		"modifier_amount":1.5,
		"points_multiplier":1.1,
		"description":"Speeds up the letters by 1.5x! Watch out, you might miss it if you blink!"
	},
	"TimeDecrease": {
		"modifier_amount":0.70,
		"points_multiplier":1.3,
		"description":"Decreases the time time avalible by 30%. Hurry! Rob's about to be late!!!"
	}
}
