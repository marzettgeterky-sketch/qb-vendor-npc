fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Zone 5'
description 'Zone 5 vendor NPC for QB-Core + ox_inventory'
version '1.0.0'

shared_scripts {
    'config.lua'
}

client_scripts {
    '@qb-core/client/functions.lua',
    'client/main.lua'
}

server_scripts {
    '@qb-core/server/functions.lua',
    'server/main.lua'
}
