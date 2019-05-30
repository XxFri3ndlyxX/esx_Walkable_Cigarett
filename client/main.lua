ESX          = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_basicneeds:OnSmokeCigarett')
AddEventHandler('esx_basicneeds:OnSmokeCigarett', function()
	prop_name = prop_name or 'ng_proc_cigarette01a' ---used cigarett prop for now. Tired of trying to place object.
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped, true))
	local x,y,z = table.unpack(GetEntityCoords(ped))
	local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
	local boneIndex = GetPedBoneIndex(ped, 64017)
			
    if not IsEntityPlayingAnim(ped, "amb@world_human_smoking@male@male_b@idle_a", "idle_a", 3) then
        RequestAnimDict("amb@world_human_smoking@male@male_b@idle_a")
        while not HasAnimDictLoaded("amb@world_human_smoking@male@male_b@idle_a") do
            Citizen.Wait(100)
        end

		Wait(100)
		AttachEntityToEntity(prop, ped, boneIndex, 0.015, 0.0100, 0.0250, 0.024, -100.0, 40.0, true, true, false, true, 1, true)
        TaskPlayAnim(ped, 'amb@world_human_smoking@male@male_b@idle_a', 'idle_a', 8.0, 8.0, -1, 49, 0, 0, 0, 0)
        Wait(2000)
        while IsEntityPlayingAnim(ped, "amb@world_human_smoking@male@male_b@idle_a", "idle_a", 3) do
            Wait(1)
			if IsControlPressed(0, 153) then
				Citizen.Wait(5000)--5 secondes
				ClearPedSecondaryTask(ped)
				DeleteObject(prop)
                break
            end
        end
    end
end)
