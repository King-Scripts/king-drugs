local Lang = Config.Languages[Config.Language];

---@param dealerPed number
local PlayDealAnimation = function(dealerPed)
    ReqAnimDict('mp_common');
    local ped = cache?.ped or PlayerPedId();
    TaskPlayAnim(ped, 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 0, false, false, false);
    TaskPlayAnim(dealerPed, 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 0, false, false, false);
    Wait(1300);
    ClearPedTasks(ped);
    ClearPedTasks(dealerPed);
end

---@param action string
---@param drug string
---@param price number
---@param dealerPed number
---@param maxAmount number
---@return number?
local DrugDealerAction = function(action, drug, price, dealerPed, maxAmount)
    local header = string.format(Lang.AmountOfDrugsHeader, Lang[drug]);
    local context = string.format(Lang.AmountOfDrugs, Lang[drug]);
    local input = lib.inputDialog(header, {context});

    if not input or not input[1] == '' or not input[1] then
        return;
    end

    local amount = tonumber(input[1]);
    if not amount or amount < 1 then
        Notify(Lang.Dealer, Lang.InvalidAmount, 'error', 5000);
        return;
    end

    if maxAmount ~= 'infinite' then
        if amount > maxAmount then
            local text = Lang.NotEnoughStock;
            if action == 'sell' and maxAmount ~= 'infinite' then
                if maxAmount <= 0 then
                    text = Lang.HasEnoughSock;
                elseif maxAmount > 0 then
                    text = string.format(Lang.YouCanSellOnly, maxAmount, Lang[drug]);
                end
            elseif action == 'buy' and maxAmount ~= 'infinite' then
                if maxAmount > 0 then
                    text = string.format(Lang.YouCanBuyOnly, maxAmount, Lang[drug]);
                end
            end
            Notify(Lang.Dealer, text, 'error', 5000);
            return;
        end
    end

    local finalPrice = price * amount;
    if action == 'buy' then
        local moneyAmount = lib.callback.await('king-drugs:server:getMoneyAmount');
        if moneyAmount < finalPrice then
            Notify(Lang.Dealer, Lang.NotEnoughMoney, 'error', 5000);
            return;
        end
        TriggerServerEvent('king-drugs:server:buyDrugs', drug, amount, finalPrice);
        PlayDealAnimation(dealerPed);
        return type(maxAmount) == 'number' and maxAmount - amount or nil;
    end
    local drugAmount = lib.callback.await('king-drugs:server:getItemAmount', false, drug);
    if drugAmount < amount then
        local NotEnoughDrug = string.format(Lang.NotEnough, Lang[drug]);
        Notify(Lang.Dealer, NotEnoughDrug, 'error', 5000);
        return;
    end
    TriggerServerEvent('king-drugs:server:sellDrugs', drug, amount, finalPrice);
    PlayDealAnimation(dealerPed);
    return type(maxAmount) == 'number' and maxAmount - amount or nil;
end

---@param data table
---@param ped number
---@return false | table buyContextData
---@return false | table sellContextData
local FormateDealerMenu = function(data, ped)
    local buyContextData = nil;
    if type(data.buy) ~= 'table' then
        buyContextData = false;
    elseif type(data.buy) == 'table' then
        buyContextData = {};
        for index, value in pairs(data.buy) do
            if Config.ContextType == 'ox' then
                buyContextData[index] = {
                    title = string.format(Lang.ContextMenuDrugAndPrice, Lang[value.item], value.price),
                    icon = 'fas fa-cannabis',
                    onSelect = function()
                        local newAmount = DrugDealerAction('buy', value.item, value.price, ped, value.amount);
                        if newAmount ~= nil and value.amount ~= 'infinite' then
                            value.amount = newAmount;
                        end
                    end
                };
            end
        end
    end
    -- Sell Menu --
    local sellContextData = nil;
    if type(data.sell) ~= 'table' then
        sellContextData = false;
    elseif type(data.sell) == 'table' then
        sellContextData = {};
        for index, value in pairs(data.sell) do
            if Config.ContextType == 'ox' then
                sellContextData[index] = {
                    title = string.format(Lang.ContextMenuDrugAndPrice, Lang[value.item], value.price),
                    icon = 'fas fa-cannabis',
                    onSelect = function()
                        local newAmount = DrugDealerAction('sell', value.item, value.price, ped, value.amount);
                        if newAmount ~= nil and value.amount ~= 'infinite' then
                            value.amount = newAmount;
                        end
                    end
                };
            end
        end
    end
    return buyContextData, sellContextData;
end

---@param dealerIndex number
---@param data table
OpenDealerMenu = function(dealerIndex, data)
    local buyContextData, sellContextData = FormateDealerMenu(data.prices, data.ped.id);
    if Config.ContextType == 'ox' then
        lib.registerContext({
            id = 'king_drugs_dealer_menu_'..dealerIndex,
            title = Lang.DealerContextHeader,
            options = {
                {
                    title = 'Buy Drugs',
                    icon = 'fas fa-shopping-cart',
                    disabled = type(buyContextData) == 'boolean' and not buyContextData,
                    onSelect = function()
                        lib.registerContext({
                            id = 'king_drugs_dealer_buy_menu_'..dealerIndex,
                            title = Lang.DealerBuyContextHeader,
                            options = buyContextData
                        });
                        lib.showContext('king_drugs_dealer_buy_menu_'..dealerIndex);
                    end
                },
                {
                    title = 'Sell Drugs',
                    icon = 'fas fa-shopping-cart',
                    disabled = type(sellContextData) == 'boolean' and not sellContextData,
                    onSelect = function()
                        lib.registerContext({
                            id = 'king_drugs_dealer_sell_menu_'..dealerIndex,
                            title = Lang.DealerSellContextHeader,
                            options = sellContextData
                        });
                        lib.showContext('king_drugs_dealer_sell_menu_'..dealerIndex);
                    end
                }
            }
        });
        lib.showContext('king_drugs_dealer_menu_'..dealerIndex);
    end
end
AddEventHandler('king-drugs:client:openDealerMenu', OpenDealerMenu);