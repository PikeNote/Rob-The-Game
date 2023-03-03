extends Node

export var offsetSpeed:int = 200;
export var timeInMinutes:int = 5;
export var timeInSeconds:int = 0;
var timeTotal = (timeInMinutes*60)+timeInSeconds;

var vowelDecrease = true;

var letterRates = [0,0,0,0,1,1,1,2,2,3];
var letterSpawns = ["AEIOU","LNSTRDGBCMPFHVWY","KJX","QZ"];


var letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
var rng = RandomNumberGenerator.new()

func _ready():
	for n in UserManager.settings.modifiers:
		if(UserManager.settings.modifiers[n]):
			match(n):
				"VowelDecrease":
					vowelDecrease = true;
					var i = 0;
					for r in GameParameters.modifiers[n].modifier_amount:
						for chance in r.chance:
							letterRates.append(i);
						letterSpawns.append(r.letters);
						i+=1;
					pass
					print("Vowel spawnrate decreased")
				"LetterSpeedup":
					offsetSpeed = 200 * GameParameters.modifiers[n].modifier_amount;
					pass
				"TimeDecrease":
					timeTotal = ceil(timeTotal * GameParameters.modifiers[n].modifier_amount);
					pass


