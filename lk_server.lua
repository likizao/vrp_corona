
--[[=======================================================================]]--
--[[  Discord: Likizão#4542                                                ]]--
--[[  Youtube: https://www.youtube.com/channel/UCLNWFQ-j0KQidRXUqXAvYXg    ]]--
--[[=======================================================================]]--


local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
Lserver = {}
Lclient = Tunnel.getInterface("vrp_corona")

Tunnel.bindInterface("vrp_corona",Lserver)

RegisterServerEvent("vrp_corona:transmissao")
AddEventHandler("vrp_corona:transmissao", function()
local user_id = vRP.getUserId(source)
local nplayer = vRPclient.getNearestPlayer(source,6)
SetTimeout(300000, function()
    if nplayer then 
        if not Lclient.haveMask(nplayer) and not Lclient.isDoente(nplayer) then
            local nuser_id = vRP.getUserId(nplayer)
            local value = vRP.getUData(user_id,"vRP:doenca")
            local contaminado = json.decode(value) or ""
            vRP.setUData(nuser_id,"vRP:doenca",json.encode("Corona"))
            Lclient.setDoente(nplayer, true)
            TriggerClientEvent("Notify", nplayer, "aviso", "Cuidado! Você foi contaminado com <b>Corona Vírus.</b>")
        end
    end
end)
end)


AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
    if first_spawn then 
        local value = vRP.getUData(user_id,"vRP:doenca")
        local contaminado = json.decode(value) or ""
            if contaminado == "Corona" then
                Lclient.setDoente(source, true)
                TriggerClientEvent("Notify", source, "aviso", "Cuidado! Você está contaminado com <b>Corona Vírus.</b> Evite se aproximar de outras pessoas e visite o hospital.")
            end
    end
end)

-----------------------------------------=------------------------------------
----[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]
----[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]
-----------------------------------------=------------------------------------
RegisterServerEvent("vrp_corona:Curar")
AddEventHandler('vrp_corona:Curar', function()
local user_id = vRP.getUserId(source)
local value = vRP.getUData(user_id,"vRP:doenca")
local contaminado = json.decode(value) or ""
    if contaminado == "Corona" then 
        vRP.setUData(user_id,"vRP:doenca",json.encode(""))
        Lclient.setDoente(source, false)
    end
end)

AddEventHandler('resetDiagnostic', function()
local user_id = vRP.getUserId(source)
local value = vRP.getUData(user_id,"vRP:doenca")
local contaminado = json.decode(value) or ""
    if contaminado == "Corona" then 
        vRP.setUData(user_id,"vRP:doenca",json.encode(""))
        Lclient.setDoente(source, false)
    end
end)

RegisterCommand("curar", function(source)
local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"polpar.permissao") then  
        local nplayer = vRPclient.getNearestPlayer(source,6)
        if nplayer then 
            local n_id = vRP.getUserId(nplayer)
            vRP.setUData(n_id,"vRP:doenca",json.encode(""))
            Lclient.setDoente(nplayer, false)
            TriggerClientEvent("Notify", source, "sucesso", "Você curou o cidadão mais próximo!")
            TriggerClientEvent("Notify", nplayer, "sucesso", "Você foi curado do <b>Corona Vírus</b>.")
        else 
            TriggerClientEvent("Notify", source, "aviso", "Nenhum cidadão próximo!")
        end
    else 
        TriggerClientEvent("Notify", source, "aviso", "Você não é um paramédico!")
    end
end)


RegisterCommand("setcorona", function(source, args)
local nuser_id = parseInt(args[1])
local user_id = vRP.getUserId(source)
if vRP.hasPermission(user_id,"admin.permissao") then
  if nuser_id then
    local nplayer = vRP.getUserSource(nuser_id)
    Lclient.setDoente(nplayer, true)
    vRP.setUData(nuser_id,"vRP:doenca",json.encode("Corona"))
  end
end
end)
