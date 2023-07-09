local QBCore = exports['qb-core']:GetCoreObject()

-- Change the coords here down for your zones
local zones = {
	{ ['x'] = 228.57,  ['y'] = -786.07,  ['z'] = 30.7  },  -- legion parking 
	{ ['x'] = 318.84,  ['y'] = -593.83,  ['z'] = 43.28 },  -- pillbox 
	{ ['x'] = -619.61, ['y'] = 35.38,    ['z'] = 43.55 },  -- tinsel 
	{ ['x'] = -46.53,  ['y'] = -1108.79, ['z'] = 26.44 },  -- pdm
	{ ['x'] = 252.81,  ['y'] = -682.06,  ['z'] = 45.87 },  -- apartment
	{ ['x'] = -545.32, ['y'] = -203.91,  ['z'] = 38.22 },  -- town hall
}

local notifIn = false
local notifOut = false
local closestZone = 1


Citizen.CreateThread(function()
	while not QBCore.Functions.GetPlayerData().job do
		Citizen.Wait(10)
	end
	QBCore.Functions.GetPlayerData = QBCore.Functions.GetPlayerData()
end)

function getEmergencyJob()
	for k,v in ipairs(Config.emergencyJobs) do
		if QBCore.Functions.GetPlayerData.job.name == v then
			return true
		end
	end 
	return false
end

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		local playerPed = GetPlayerPed(-1)
		local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
		local minDistance = 100000
		for i = 1, #zones, 1 do
			dist = Vdist(zones[i].x, zones[i].y, zones[i].z, x, y, z)
			if dist < minDistance then
				minDistance = dist
				closestZone = i
			end
		end
		Citizen.Wait(15000)
	end
end)

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		Citizen.Wait(0)
		local player = GetPlayerPed(-1)
		local x,y,z = table.unpack(GetEntityCoords(player, true))
		local dist = Vdist(zones[closestZone].x, zones[closestZone].y, zones[closestZone].z, x, y, z)
		local ped = PlayerPedId()
		local playerPed = PlayerPedId()
	
		if dist <= Config.ZoneRange then 
			if not notifIn then
				exports['okokTextUI']:Open('You Are in safe zone', 'darkred', 'right') -- change your text ui 
				local isEmergencyJob = getEmergencyJob()

				if not isEmergencyJob then
					SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
				end

				notifIn = true
				notifOut = false
			end
		else
			if not notifOut then
			exports['okokTextUI']:Close() -- change your text ui 
				notifOut = true
				notifIn = false
		end
		if notifIn then
			end
		end
	end
end)

RegisterNetEvent('safezone:client:zone', function()
	local player = GetPlayerPed(-1)
	local x,y,z = table.unpack(GetEntityCoords(player, true))
	local dist = Vdist(zones[closestZone].x, zones[closestZone].y, zones[closestZone].z, x, y, z)
	local ped = PlayerPedId()

	if dist <= Config.ZoneRange then -- how much to be the radius
		local isEmergencyJob = getEmergencyJob()

		if not isEmergencyJob then
			SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
		end
	end
end)