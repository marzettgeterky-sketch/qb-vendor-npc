local QBCore = exports['qb-core']:GetCoreObject()
local npcCreated = false
local spawnedNpc = nil

local function loadModel(model)
    if not IsModelValid(model) then return false end
    RequestModel(model)
    local timeout = GetGameTimer() + 5000
    while not HasModelLoaded(model) and GetGameTimer() < timeout do
        Wait(10)
    end
    return HasModelLoaded(model)
end

local function attachPropToPed(ped, itemName)
    local modelName = Config.PropNames[itemName]
    local offset = Config.PropOffsets[itemName]
    if not modelName or not offset then return end

    local modelHash = joaat(modelName)
    if not loadModel(modelHash) then return end

    local prop = CreateObject(modelHash, 0.0, 0.0, 0.0, true, true, false)
    local bone = GetPedBoneIndex(ped, offset.bone)
    AttachEntityToEntity(prop, ped, bone, offset.x, offset.y, offset.z, offset.rx, offset.ry, offset.rz, false, false, false, false, 2, true)
    SetModelAsNoLongerNeeded(modelHash)
end

local function spawnNpc()
    local model = joaat(Config.NPC.model)
    if not loadModel(model) then
        print(('[%s] Failed to load NPC model: %s'):format(Config.ResourceName, Config.NPC.model))
        return
    end

    local ped = CreatePed(4, model, Config.NPC.coords.x, Config.NPC.coords.y, Config.NPC.coords.z, Config.NPC.heading, false, false)
    if not DoesEntityExist(ped) then
        print(('[%s] Failed to create NPC ped.'):format(Config.ResourceName))
        return
    end

    SetEntityAsMissionEntity(ped, true, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    SetPedCanBeDraggedOut(ped, false)
    SetPedDiesWhenInjured(ped, false)
    SetPedDefaultComponentVariation(ped)

    for item, _ in pairs(Config.PropNames) do
        attachPropToPed(ped, item)
    end

    spawnedNpc = ped
    npcCreated = true
end

local function ensureNpc()
    if npcCreated and spawnedNpc and DoesEntityExist(spawnedNpc) then return end
    spawnNpc()
end

CreateThread(function()
    while true do
        ensureNpc()
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local distance = #(coords - Config.NPC.coords)

        if distance < Config.NPC.distance + 1.5 then
            DrawMarker(1, Config.NPC.coords.x, Config.NPC.coords.y, Config.NPC.coords.z - 0.95, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.NPC.markerColor.r, Config.NPC.markerColor.g, Config.NPC.markerColor.b, Config.NPC.markerColor.a, false, false, 2, false, nil, nil, false)
            if distance < Config.NPC.distance then
                if IsControlJustReleased(0, 38) then
                    TriggerServerEvent('zone5_vendor:openShop')
                end
                SetTextComponentFormat('STRING')
                AddTextComponentString('Press ~INPUT_PICKUP~ to open Zone 5 Supply')
                EndTextCommandDisplayHelp(0, 0, true, 500)
            end
        end

        Wait(0)
    end
end)

RegisterNetEvent('zone5_vendor:openShopMenu', function(items)
    local menu = {
        {
            header = Config.ShopMenu.title,
            txt = Config.ShopMenu.subtitle,
            isMenuHeader = true,
        }
    }

    for itemName, itemData in pairs(items) do
        menu[#menu + 1] = {
            header = itemData.label,
            txt = ('%s | $%s'):format(itemData.description, itemData.price),
            params = {
                event = 'zone5_vendor:buyItem',
                args = { itemName }
            }
        }
    end

    menu[#menu + 1] = {
        header = 'Close',
        txt = 'Close the shop.',
        params = {
            event = 'qb-menu:closeMenu'
        }
    }

    exports['qb-menu']:openMenu(menu)
end)

RegisterNetEvent('zone5_vendor:serverInfo', function(info)
    print(('[%s] Server info received: %s'):format(Config.ResourceName, info.serverName))
end)

AddEventHandler('onResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    TriggerServerEvent('zone5_vendor:requestServerInfo')
end)
