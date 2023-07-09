Config = {}

-- Change the coords here down for your zones
Config.zones = {
	{ ['x'] = 228.57,  ['y'] = -786.07,  ['z'] = 30.7  },  -- legion parking 
	{ ['x'] = 318.84,  ['y'] = -593.83,  ['z'] = 43.28 },  -- pillbox 
	{ ['x'] = -619.61, ['y'] = 35.38,    ['z'] = 43.55 },  -- tinsel 
	{ ['x'] = -46.53,  ['y'] = -1108.79, ['z'] = 26.44 },  -- pdm
	{ ['x'] = 252.81,  ['y'] = -682.06,  ['z'] = 45.87 },  -- apartment
	{ ['x'] = -545.32, ['y'] = -203.91,  ['z'] = 38.22 },  -- town hall
}

Config.emergencyJobs = { -- Put here the job that you want to drive in the emergencyVehicles below
    'police',
    'ambulance',
}

Config.ZoneRange = 75.0