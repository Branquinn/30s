local Proxy = module('vrp','lib/Proxy')
local vRP = Proxy.getInterface('vRP')

function branquin(source)
    local user_id = vRP.getUserId(source)
    local perm = vRP.hasPermission(user_id, 'policia.permissao')
    local identidade = vRP.getUserIdentity(user_id)
    local firstname = identidade.firstname
    local name = identidade.name

    if perm then
        local prompt = vRP.prompt(source, 'ID do bandido', '')
        if prompt then
            local request = vRP.request(tonumber(prompt), 'Deseja iniciar a contagem com ' .. name .. ' ' .. firstname .. ' ?', 15)
            local sourceBandido = vRP.getUserSource(tonumber(prompt))
            if request then
                TriggerClientEvent('Notify', source, 'sucesso', 'Contagem iniciada!')
                TriggerClientEvent('Notify', sourceBandido, 'sucesso', 'Contagem iniciada!')
                repeat
                    Citizen.Wait(5 * 1000)
                    local trintou = 0
                    TriggerClientEvent('Notify', source, 'sucesso', 'Ação Valendo!')
                    TriggerClientEvent('Notify', sourceBandido, 'sucesso', 'Ação Valendo!')
                    trintou = 1
                until trintou > 0
            end
        end
    else
        TriggerClientEvent('Notify', source, 'negado', 'Você não tem permissão!')
    end
end

RegisterCommand('30s', branquin)