Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local ped = PlayerPedId()
        if GetEntityHealth(ped) <= 101 and deathtimer <= 0 then
            if IsControlJustPressed(0,38) then
                TriggerEvent("resetBleeding")
                TriggerEvent("resetDiagnostic")
                TriggerServerEvent("clearInventory")
                TriggerServerEvent("vrp_corona:Curar") -- Adicionar essa linha. 
                deathtimer = 500
                nocauteado = false
                ClearPedBloodDamage(ped)
                SetEntityInvincible(ped,false)
                DoScreenFadeOut(1000)
				SetEntityHealth(ped,400)
				tvRP.setHandcuffed(false)
				SetPedArmour(ped,0)
				RemoveAllPedWeapons(ped,false)
                Citizen.Wait(1000)
                SetEntityCoords(PlayerPedId(),281.51123046875+0.0001,-578.32598876953+0.0001,43.19259262085+0.0001,1,0,0,1)
                FreezeEntityPosition(ped,true)
                SetTimeout(5000,function()
                    FreezeEntityPosition(ped,false)
                    Citizen.Wait(1000)
                    DoScreenFadeIn(1000)
                end)
            end
        end
    end
end)



