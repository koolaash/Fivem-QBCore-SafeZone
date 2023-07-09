local QBCore = exports['qb-core']:GetCoreObject()

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
		for i = 1, #Config.zones, 1 do
			dist = Vdist(Config.zones[i].x, Config.zones[i].y, Config.zones[i].z, x, y, z)
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
		local dist = Vdist(Config.zones[closestZone].x, Config.zones[closestZone].y, Config.zones[closestZone].z, x, y, z)
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
	local dist = Vdist(Config.zones[closestZone].x, Config.zones[closestZone].y, Config.zones[closestZone].z, x, y, z)
	local ped = PlayerPedId()

	if dist <= Config.ZoneRange then -- how much to be the radius
		local isEmergencyJob = getEmergencyJob()

		if not isEmergencyJob then
			SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
		end
	end
end)