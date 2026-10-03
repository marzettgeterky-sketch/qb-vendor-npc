Config = Config or {}

Config.ResourceName = 'zone5-vendor'
Config.ServerName = 'Zone 5'
Config.NPC = {
    model = 'a_m_m_business_1',
    coords = vector3(787.9655, -144.6036, 74.8158),
    heading = 285.2164,
    distance = 2.5,
    markerColor = { r = 255, g = 196, b = 0, a = 180 },
}

Config.ShopItems = {
    bodybag = {
        label = 'Body Bag',
        price = 120,
        amount = 1,
        description = 'Body bag for medical or recovery work.'
    },
    scale = {
        label = 'Scale',
        price = 180,
        amount = 1,
        description = 'Used for weighing and measuring stock.'
    },
    moneycounter = {
        label = 'Money Counter',
        price = 230,
        amount = 1,
        description = 'Counter for cash handling.'
    },
    armorvest = {
        label = 'Armor Vest',
        price = 350,
        amount = 1,
        description = 'Protective vest for personnel.'
    },
    radio = {
        label = 'Radio',
        price = 95,
        amount = 1,
        description = 'Communication device for field work.'
    },
}

Config.PropNames = {
    bodybag = 'prop_ld_body_bag',
    scale = 'prop_meth_scale_01',
    moneycounter = 'bkr_prop_money_counter',
    armorvest = 'prop_bodyarmour_02',
    radio = 'prop_cs_hand_radio',
}

Config.PropOffsets = {
    bodybag = { bone = 0, x = 0.40, y = 0.35, z = 0.0, rx = 0.0, ry = 0.0, rz = 90.0 },
    scale = { bone = 0, x = 0.75, y = 0.10, z = 0.0, rx = 0.0, ry = 0.0, rz = 180.0 },
    moneycounter = { bone = 0, x = 0.75, y = -0.90, z = -0.30, rx = 0.0, ry = 0.0, rz = 90.0 },
    armorvest = { bone = 11816, x = 0.0, y = 0.0, z = 0.12, rx = 0.0, ry = 0.0, rz = 0.0 },
    radio = { bone = 24818, x = 0.12, y = 0.06, z = 0.0, rx = 0.0, ry = 80.0, rz = 0.0 },
}

Config.ShopMenu = {
    title = 'Zone 5 Supply Shop',
    subtitle = 'Weapons, tools, and gear for your operations.'
}
