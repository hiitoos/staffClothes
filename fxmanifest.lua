-- fxmanifest.lua
fx_version 'cerulean'
games { 'gta5' }

author 'Driieen'
description 'Script de cambio de ropa para administradores'
version '1.0.0'

dependency 'qb-clothing'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
}
