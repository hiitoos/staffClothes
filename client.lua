-- client.lua
local QBCore = exports['qb-core']:GetCoreObject()
local isAdminClothes = false

RegisterNetEvent('qb-staff:toggleStaffClothes')
AddEventHandler('qb-staff:toggleStaffClothes', function()
    local playerPed = PlayerPedId()
    local gender = QBCore.Functions.GetPlayerData().charinfo.gender
    local clothes = {}

    if gender == 0 then
        clothes = Config.AdminClothes.male
    else
        clothes = Config.AdminClothes.female
    end

    if not isAdminClothes then
        -- Guardar la ropa actual y cambiar a la ropa de admin
        local currentClothes = {
            ['tshirt_1'] = {GetPedDrawableVariation(playerPed, 8), GetPedTextureVariation(playerPed, 8)},
            ['torso_1'] = {GetPedDrawableVariation(playerPed, 11), GetPedTextureVariation(playerPed, 11)},
            ['decals_1'] = {GetPedDrawableVariation(playerPed, 10), GetPedTextureVariation(playerPed, 10)},
            ['arms'] = {GetPedDrawableVariation(playerPed, 3), 0},
            ['pants_1'] = {GetPedDrawableVariation(playerPed, 4), GetPedTextureVariation(playerPed, 4)},
            ['shoes_1'] = {GetPedDrawableVariation(playerPed, 6), GetPedTextureVariation(playerPed, 6)},
            ['chain_1'] = {GetPedDrawableVariation(playerPed, 7), GetPedTextureVariation(playerPed, 7)},
            ['helmet_1'] = {GetPedPropIndex(playerPed, 0), GetPedPropTextureIndex(playerPed, 0)}
        }
        TriggerServerEvent('qb-staff:saveCurrentClothes', currentClothes)

        -- Cambiar a la ropa de admin
        for k, v in pairs(clothes) do
            SetPedComponentVariation(playerPed, tonumber(k), v[1], v[2], 2)
        end
        isAdminClothes = true
    end
end)

RegisterNetEvent('qb-staff:setClothes')
AddEventHandler('qb-staff:setClothes', function(civilianClothes)
    local playerPed = PlayerPedId()

    for k, v in pairs(civilianClothes) do
        SetPedComponentVariation(playerPed, tonumber(k), v[1], v[2], 2)
    end

    isAdminClothes = false
end)

RegisterNetEvent('qb-staff:fixpj')
AddEventHandler('qb-staff:fixpj', function(civilianClothes)
    isAdminClothes = false
    TriggerEvent('qb-clothing:fixpj')
end)

