Config = Config or {};

-- Main Configuration --

Config.Language = 'en'; -- en or bg
Config.ZoneType = 'ox'; -- ox (ox_lib zones), poly (bt-polyzone) or distance (fivem)
Config.ControlInteraction = 'ox'; -- ox, okokTextUI, customTextUI, 3DText
Config.TargetType = 'ox_target'; -- ox_target, qtarget, bt-target or qb-target
Config.ContextType = 'ox'; -- ox (ox_lib context), nh-context, zf-context or qb-menu
Config.Notifications = 'ox'; -- okok, ox, mythic or custom

-- Dealer Configuration --

Config.DealerLocations = {
    [1] = {
        -- The Coords and Heading can be global for the table or for each option different
        interaction = {
            type = 'control', -- target or control
            coords = vec3(-117.7423, 6348.8779, 31.4904),
            heading = 50.7063,
            debug = false, -- Only for target or ox zones
            size = vec3(1.5, 1.5, 2), -- Only for target or ox zones
            controlIdx = 38, -- Only for control
            controlLabel = 'E' -- Only for control
        },
        prices = {
            buy = { -- amount = 'infinite' --> infinite amount
                [1] = { item ='heroin', price = 8, amount = 7 }, -- Add amount if you want to have a limit for buying
                [2] = { item = 'marijuana', price = 15, amount = 12 },
                [3] = { item = 'meth', price = 35, amount = 5 },
                [4] = { item = 'cocaine', price = 60, amount = 2 }
            },
            sell = { -- amount = 'infinite' --> infinite amount
                [1] = { item = 'heroin', price = 5, amount = 'infinite' }, -- Add amount if you want to have a maximum amount to sell
                [2] = { item = 'marijuana', price = 10, amount = 4 },
                [3] = { item = 'meth', price = 25, amount = 10 },
                [4] = { item = 'cocaine', price = 50, amount = 15 }
            }
        },
        ped = { -- Table or false
            model = 'g_m_y_ballaeast_01',
            coords = vec3(-117.7423, 6348.8779, 31.4904),
            heading = 50.7063
        },
        blip = { -- Table or false
            sprite = 51,
            color = 2,
            scale = 0.8,
            label = 'Dealer',
            coords = vec3(-117.7423, 6348.8779, 31.4904)
        }
    }
};

-- Custom TextUI/Notifications --

---@param title string
---@param msg string
---@param type string
---@param time number
CustomNotifications = function(title, msg, type, time)
    --* Example:
    --* exports['king-library']:Notification(msg, type, time);
end

---@param action string
---@param message string?
CustomTextUI = function(action, message)
    if action == 'show' then
        --* Example:
        --* exports['king-library']:ShowTextUI(message, 'information');
    elseif action == 'hide' then
        --* Example:
        --* exports['king-library']:HideTextUI();
    end
end