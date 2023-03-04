extends Node

export var offsetSpeed:int = 200;
export var timeInMinutes:int = 5;
export var timeInSeconds:int = 0;
var timeTotal;

var vowelDecrease = true;

var letterRates = [0,0,0,0,1,1,1,2,2,3];
var letterSpawns = ["AEIOU","LNSTRDGBCMPFHVWY","KJX","QZ"];


var letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
var rng = RandomNumberGenerator.new()

var multipliers = [];
func _ready():
	timeTotal = (timeInMinutes*60)+timeInSeconds;
	for n in UserManager.settings.modifiers:
		if(UserManager.settings.modifiers[n]):
			multipliers.append(GameParameters.modifiers[n].points_multiplier);
			match(n):
				"VowelDecrease":
					vowelDecrease = true;
					var i = 0;
					for r in GameParameters.modifiers[n].modifier_amount:
						for chance in r.chance:
							letterRates.append(i);
						letterSpawns.append(r.letters);
						i+=1;
				"LetterSpeedup":
					offsetSpeed = 200 * GameParameters.modifiers[n].modifier_amount;
					pass
				"TimeDecrease":
					timeTotal = ceil(timeTotal * GameParameters.modifiers[n].modifier_amount);
					pass
	var multiplier = 1;
	for n in multipliers:
		multiplier *= n;
		

