local QBCore = exports['qb-core']:GetCoreObject()

local function notify(src, message, type)
    TriggerClientEvent('QBCore:Notify', src, message, type or 'primary')
end

local function playerHasCash(src, amount)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return false end
    return Player.Functions.GetMoney('cash') >= amount
end

local function removeCash(src, amount)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return false end
    if Player.Functions.RemoveMoney('cash', amount) then
        return true
    end
    return false
end

local function addInventoryItem(src, item, amount)
    if exports.ox_inventory then
        local success = exports.ox_inventory:AddItem(src, item, amount)
        return success
    end

    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return false end
    return Player.Functions.AddItem(item, amount)
end

RegisterNetEvent('zone5_vendor:openShop', function()
    local src = source
    TriggerClientEvent('zone5_vendor:openShopMenu', src, Config.ShopItems)
end)

RegisterNetEvent('zone5_vendor:buyItem', function(itemName)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local item = Config.ShopItems[itemName]
    if not item then
        notify(src, 'That item is not available in the shop.', 'error')
        return
    end

    local total = item.price
    if not playerHasCash(src, total) then
        notify(src, ('You need $%s to buy %s.'):format(total, item.label), 'error')
        return
    end

    if not removeCash(src, total) then
        notify(src, 'Unable to process your payment.', 'error')
        return
    end

    if not addInventoryItem(src, itemName, item.amount or 1) then
        Player.Functions.AddMoney('cash', total)
        notify(src, 'Inventory full or item could not be added.', 'error')
        return
    end

    notify(src, ('You bought %s for $%s.'):format(item.label, total), 'success')
end)

RegisterNetEvent('zone5_vendor:requestServerInfo', function()
    local src = source
    TriggerClientEvent('zone5_vendor:serverInfo', src, {
        serverName = Config.ServerName,
        resourceName = Config.ResourceName,
        npcCoords = Config.NPC.coords,
        heading = Config.NPC.heading,
    })
end)

AddEventHandler('onResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    print(('[%s] Zone 5 vendor loaded successfully.'):format(Config.ResourceName))
end)
