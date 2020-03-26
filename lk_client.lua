vRPc = {}
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
Tunnel.bindInterface("vrp_corona", vRPc)
Proxy.addInterface("vrp_corona", vRPc)

Lserver = Tunnel.getInterface("vrp_corona", "vrp_corona")

--------------------------------------------------------
contaminado = false
tossiu = 0
vomitou = 0
--------------------------------------------------------

function vRPc.setDoente(boolean) contaminado = boolean end

function vRPc.isDoente() return contaminado end

function vRPc.haveMask()
    return (GetPedDrawableVariation(PlayerPedId(), 1) == 101)
end

function vRPc.setMask()
    	SetPedComponentVariation(PlayerPedId(),1,101,1,2)    
end

Citizen.CreateThread(function()
    while true do
        Wait(1)
        local ped = PlayerPedId()
        if contaminado then
            if GetEntityHealth(ped) > 101 then
                SetRunSprintMultiplierForPlayer(ped, 0.0)
                local x, y, z = table.unpack(GetEntityCoords(ped))
                local bowz, cdz = GetGroundZFor_3dCoord(344.24, -582.21, 43.31)
                local distance = GetDistanceBetweenCoords(344.24, -582.21, cdz,
                                                          x, y, z, true)
                if tossiu < 2 and distance > 20 then
                    Wait(2500)
                    vRP.playAnim(true, {
                        {
                            "anim@amb@business@cfm@cfm_machine_oversee@",
                            "cough_spit_operator"
                        }
                    }, false)
                    Wait(4500)
                    ClearPedTasks(ped)
                    tossiu = 70
                end
                if vomitou < 2 and distance > 20 then
                    Wait(10500)
                    vomitar()
                    vomitou = 180
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if tossiu > 0 then
            Wait(1000)
            tossiu = tossiu - 1
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if vomitou > 0 then
            Wait(1000)
            vomitou = vomitou - 1
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(5)
        if contaminado then
            Citizen.Wait(800)
            TriggerServerEvent("vrp_corona:transmissao")
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(100)
        if contaminado then
            local ped = PlayerPedId()
            local health = GetEntityHealth(ped)
            if health > 120 then 
            SetEntityHealth(ped, (health - 1))
            Citizen.Wait(15000)
            end
        end
    end
end)

function vomitar()
    local ped = PlayerPedId()
    RequestNamedPtfxAsset("scr_family5")
    vRP.playAnim(true,
                 {{"MISSHEISTPALETOSCORE1LEADINOUT", "TRV_PUKING_LEADOUT"}},
                 true)
    while not HasNamedPtfxAssetLoaded("scr_family5") do Citizen.Wait(0) end
    UseParticleFxAssetNextCall("scr_family5")
    Citizen.Wait(1000)
    particle = StartParticleFxLoopedOnPedBone("SCR_TREV_PUKE", ped, 0.0, 0.0,
                                              0.0, 0.0, 0.0, 0.0, 31086, 1.0, 0,
                                              0, 0)
    Citizen.Wait(4500)
    StopParticleFxLooped(particle, 0)
    Citizen.Wait(1200)
    ClearPedTasks(ped)
    RemoveNamedPtfxAsset("scr_family5")
end


RegisterNetEvent('setMask')
AddEventHandler('setMask',function()
	SetPedComponentVariation(PlayerPedId(),1,101,1,2)    
end)
