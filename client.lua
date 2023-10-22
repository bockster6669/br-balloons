local QBCore = exports['qb-core']:GetCoreObject()
local AmountTaken = 0
local Timer = 0
local function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

local function balloonAnim()
    local balloonProp = 'xm3_prop_xm3_balloon_01a'
	balloonProp1 = CreateObject(balloonProp, 1.0, 1.0, 1.0, 1, 1, 0)
    local ped = PlayerPedId()
    local anims = { -- I though that it will be cool to be random animations, but now I see that the "mp_player_intdrink" is the best looking anim
       -- {'amb@world_human_aa_smoke@male@idle_a', 'idle_c', 0.0, 0.0, 0.0, 85.0, 60.0, 60.0, 28422},
       -- {'amb@world_human_aa_smoke@male@idle_a', 'idle_b', 0.0, 0.0, 0.0, 85.0, 60.0, 60.0, 28422},
        {'mp_player_intdrink', 'loop_bottle', 0.0, 0.0, 0.03, 355.0, 10.0, 60.0, 60309},
    }
    local anim = anims[math.random(1, #anims)]
    local bone = GetPedBoneIndex(ped, anim[9])
    
	RequestModel(balloonProp)
	while not HasModelLoaded(balloonProp) do
		Wait(1)
	end
    
    LoadAnimDict(anim[1])
    AttachEntityToEntity(balloonProp1, ped, bone, anim[3], anim[4], anim[5], anim[6], anim[7], anim[8], true, true, false, true, 1, true)
    TaskPlayAnim(PlayerPedId(), anim[1], anim[2], 8.0, -8, -1, 49, 0, false, false, false)
end

local function deleteballoonProp()
	if balloonProp1 ~= 0 then
		DeleteObject(balloonProp1)
	end
end

local function flaskAnim()
    local balloonProp = 'xm3_prop_xm3_balloon_01a'
    local flaskProp = 'prop_paint_spray01b'
	flaskProp1 = CreateObject(flaskProp, 1.0, 1.0, 1.0, 1, 1, 0)
    balloonProp1 = CreateObject(balloonProp, 1.0, 1.0, 1.0, 1, 1, 0)
    local ped = PlayerPedId()
    local bone = GetPedBoneIndex(ped, 28422)
    
	RequestModel(flaskProp)
	while not HasModelLoaded(flaskProp) do
		Wait(1)
	end
    
    LoadAnimDict('anim@mp_player_intupperspray_champagne')
    AttachEntityToEntity(flaskProp1, ped, bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
    AttachEntityToEntity(balloonProp1, flaskProp1, 0.0, 0.0, 0.0, 0.30, 0.0, 170.0, 0.0, true, true, false, true, 1, true)
    TaskPlayAnim(PlayerPedId(), 'anim@mp_player_intupperspray_champagne', 'idle_a', 8.0, -8, -1, 49, 0, false, false, false)
end

local function deleteFlaskProp()
	if flaskProp1 ~= 0 then
		DeleteObject(flaskProp1)
	end
end

local function BalloonEffect()
    AmountTaken = AmountTaken + 1
    Timer = 0
    AnimpostfxPlay("DrugsMichaelAliensFightIn", 3.0, 0)
    Wait(2000)
    local Ped = PlayerPedId()
    local animDict = "MOVE_M@DRUNK@VERYDRUNK"
    LoadAnimDict(animDict)
    SetPedCanRagdoll(Ped, true)
    ShakeGameplayCam('DRUNK_SHAKE', 2.80)
    SetTimecycleModifier("Drunk")
    SetPedMovementClipset(Ped, animDict, 1)
    SetPedMotionBlur(Ped, true)
    SetPedIsDrunk(Ped, true)
    Wait(1500)
    SetPedToRagdoll(Ped, 5000, 1000, 1, 0, 0, 0)
    Wait(1500)
    SetPedToRagdoll(Ped, 5000, 1000, 1, 0, 0, 0)
    Wait(Config.DrunkEffectTime)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(Ped, 0)
    SetPedIsDrunk(Ped, false)
    SetPedMotionBlur(Ped, false)
    AnimpostfxStopAll()
    ShakeGameplayCam('DRUNK_SHAKE', 0.0)
    AnimpostfxPlay("DrugsMichaelAliensFight", 3.0, 0)
    Wait(1000)
    AnimpostfxPlay("DrugsMichaelAliensFightOut", 3.0, 0)
    AnimpostfxStop("DrugsMichaelAliensFightIn")
    AnimpostfxStop("DrugsMichaelAliensFight")
    AnimpostfxStop("DrugsMichaelAliensFightOut")
end
--направи анимации
RegisterNetEvent('br-ballons:client:useBalloonsPacket', function()
    LoadAnimDict('missheistdockssetup1clipboard@base')
    TaskPlayAnim(PlayerPedId(), 'missheistdockssetup1clipboard@base', 'base', 8.0, -8, -1, 49, 0, false, false, false)
    QBCore.Functions.Progressbar("unpack_balloons", Lang:t('progbar.unPack'), Config.ProgBar_UnPackTime, false, true, {
		disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
	}, {}, {}, function() -- Done
        TriggerServerEvent('br-ballons:server:giveBalloons')
        ClearPedTasks(PlayerPedId())
	end, function() -- Cancel
		StopAnimTask(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 1.0)
        ClearPedTasks(PlayerPedId())
	end)
end)

CreateThread(function()
	while true do
			Wait(1000)
			Timer = Timer + 1
		end
		
	end)


CreateThread(function()
	while true do
			Wait(1)
			if Timer <= Config.OverdoseInterval then
				if AmountTaken >= Config.OverdoseAmount then
					    SetEntityHealth(PlayerPedId(), 0)
				end
			end
		end
		
	end)


RegisterNetEvent('br-ballons:client:useBalloon', function()
    balloonAnim()
    QBCore.Functions.Progressbar("take_the_balloon", Lang:t('progbar.breath'), Config.ProgBar_BreathTheBalloonTime, false, true, {
        disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
    }, {}, {}, function() -- Done
        QBCore.Functions.Notify(Lang:t('notify.fill'), 'primary', 1000)
        TriggerServerEvent('hud:server:RelieveStress', 10)
		TriggerEvent("evidence:client:SetStatus", "heavengas", 200)
        TriggerServerEvent('br-balloons:server:removeBalloon')
        CreateThread(function() BalloonEffect() end)
        deleteballoonProp()
        ClearPedTasks(PlayerPedId())
    end, function() -- Cancel
        deleteballoonProp()
        ClearPedTasks(PlayerPedId())
    end)
end)

RegisterNetEvent('br-ballons:client:useFlask', function(quality)
    local hasItem = QBCore.Functions.HasItem('empty_balloon')
    if hasItem then
        flaskAnim()
        QBCore.Functions.Progressbar("use_flask", Lang:t('progbar.fillballoon'), Config.ProgBar_FillTheBalloon, false, true, {
            disableMovement = false,
		    disableCarMovement = false,
		    disableMouse = false,
		    disableCombat = true,
        }, {
        }, {}, {}, function() -- Done
            deleteFlaskProp()
            deleteballoonProp()
            TriggerServerEvent('br-balloons:server:updateInfo', quality - 5)
            ClearPedTasks(PlayerPedId())
        end, function() -- Cancel
            deleteFlaskProp()
            deleteballoonProp()
            ClearPedTasks(PlayerPedId())
        end)
    else
        QBCore.Functions.Notify(Lang:t('notify.noballoons'), 'error', 1000)
    end
end)
