import json
import pyperclip
import random

NUM_LEVELS = 10

SPEED_SCALE = 30
HEALTH_SCALE = 1
ARMOR_SCALE = 2

base_enemy = {
    "health": 1,
    "armor": 0,
    "speed": 50,
    "reward": 1,
    "type": "Normal",
    "copies": 1,
    "delay": 0.4,
    "size": 1
}

levels = []

for level_num in range(1, NUM_LEVELS+1):
    level = []
    for num_enemies in range(level_num):
        new_enemy = base_enemy.copy()
        new_enemy["health"]+=(level_num-1)*HEALTH_SCALE + random.randint(-level_num, level_num)
        new_enemy["armor"]+=(level_num-1)*ARMOR_SCALE + random.randint(-level_num, level_num)
        new_enemy["speed"]+=(level_num-1)*SPEED_SCALE + random.randint(-level_num, level_num)
        
        # basic value function
        value = new_enemy["health"]/10 + new_enemy["armor"] + new_enemy["speed"]/10
        
        new_enemy["reward"] = int(value)
        new_enemy["size"] = int(value/10)
        
        level.append(new_enemy)
    levels.append(level)

file_contents = json.dumps({"levels":levels},  indent=1)

print(file_contents)

pyperclip.copy(file_contents)

print("copied to clipboard")