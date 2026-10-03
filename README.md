# Zone 5 Vendor NPC

This resource adds a Zone 5 vendor NPC that works with QBCore and ox_inventory.

Features:
- Server-side coordinated NPC spawn
- Client-side NPC creation and prop attachment
- Marker + interaction prompt at the vendor location
- QB-Core menu-based shop system
- ox_inventory support for item delivery
- Custom curated items for body bags, scales, money counters, armor vest, and radio

Location:
- X: 787.9655
- Y: -144.6036
- Z: 74.8158
- Heading: 285.2164

Resource name:
- `zone5-vendor`

Server name:
- `Zone 5`

Shop items:
- Body Bag
- Scale
- Money Counter
- Armor Vest
- Radio

Install:
1. Put this folder in your `resources` directory.
2. Ensure you have `qb-core` and `ox_inventory` running.
3. Add `ensure zone5-vendor` to your server.cfg.
4. Add item entries matching your ox inventory item names if needed.

Important:
The config uses item keys like `bodybag`, `scale`, `moneycounter`, `armorvest`, and `radio`. If your server has different item names, update `Config.ShopItems` before starting the resource.
