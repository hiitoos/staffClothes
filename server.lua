-- server.lua
QBCore = exports['qb-core']:GetCoreObject()

local previousClothes = {}


-- Configuración del webhook
local webhookURL = "https://discord.com/api/webhooks/1254150241783910500/z67yZHzCvU52M5THnc2Bd6xXNDDDQEcnSV6FJ_BE7A7fJ8w7PPxVvxByakghEHUTO2HM"

function sendToDiscord(name, message, color)
    local embed = {
        {
            ["color"] = color,
            ["title"] = "**" .. name .. "**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = os.date("%Y-%m-%d %H:%M:%S")
            }
        }
    }
    PerformHttpRequest(webhookURL, function(err, text, headers) end, 'POST', json.encode({username = "Staff Logger", embeds = embed}), { ['Content-Type'] = 'application/json' })
end

RegisterCommand('staff', function(source, args, rawCommand)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer and xPlayer.PlayerData then
        TriggerClientEvent('qb-staff:toggleStaffClothes', source)
        sendToDiscord("Staff Mode", GetPlayerName(source) .. " ha entrado en modo Staff.", 65280)
    else
        TriggerClientEvent('QBCore:Notify', source, 'No tienes permiso para usar este comando', 'error')
    end
end, true)

RegisterCommand('staffoff', function(source, args, rawCommand)
	TriggerClientEvent('qb-staff:fixpj', source)
end, true)

RegisterServerEvent('qb-staff:saveCurrentClothes')
AddEventHandler('qb-staff:saveCurrentClothes', function(civilianClothes)
    local src = source
    previousClothes[src] = civilianClothes
end)

RegisterNetEvent('qb-staff:resetToCivilianClothes')
AddEventHandler('qb-staff:resetToCivilianClothes', function()
    local src = source
    if previousClothes[src] then
        TriggerClientEvent('qb-staff:setClothes', src, previousClothes[src])
    end
end)
