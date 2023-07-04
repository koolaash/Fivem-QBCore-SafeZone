**SAFE ZONE**
-----

- This script is to avoid people from taking out weapons in safe ZONE
- It shows on screen overlay when the player is in safe ZONE
- Police is immune to this script 
- Below is givem the installation guide for this script


 **Installation**
-----

- First drag and drop the file in you server files
- ensure the script in `server.cfg` or just drop it in `[qb]` folder
- Then go to `qb-inventory>serevr>main.lua` search for `if itemData.type == "weapon" then` and paste the below line there

```lua
 TriggerClientEvent('safezone:client:zone', src)
```
- Which then must look something like this code given below
- Make sure not to replace the code

```lua
 RegisterNetEvent('inventory:server:UseItemSlot', function(slot)
    local src = source
    local itemData = GetItemBySlot(src, slot)
    if not itemData then return end
    local itemInfo = QBCore.Shared.Items[itemData.name]
    if itemData.type == "weapon" then
        TriggerClientEvent("inventory:client:UseWeapon", src, itemData, itemData.info.quality and itemData.info.quality > 0)
        TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "use")
        TriggerClientEvent('safezone:client:zone', src) 
    elseif itemData.useable then
        UseItem(itemData.name, src, itemData)
        TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "use")
    end
end)

RegisterNetEvent('inventory:server:UseItem', function(inventory, item)
    local src = source
    if inventory ~= "player" and inventory ~= "hotbar" then return end
    local itemData = GetItemBySlot(src, item.slot)
    if not itemData then return end
    local itemInfo = QBCore.Shared.Items[itemData.name]
    if itemData.type == "weapon" then
        TriggerClientEvent("inventory:client:UseWeapon", src, itemData, itemData.info.quality and itemData.info.quality > 0)
        TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "use")
        TriggerClientEvent('safezone:client:zone', src)
    else
        UseItem(itemData.name, src, itemData)
        TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "use")
    end
end)
```
- You need to add that line in both events else people will be able to exploit it
- For support join my [Discord](https://discord.gg/S7SXz7E8St)

**DEPENDENCIES**
-----

- QBCore - https://github.com/qbcore-framework
- QB-Inventory - https://github.com/qbcore-framework/qb-inventory
## Authors

- [@koolaash](https://github.com/koolaash)