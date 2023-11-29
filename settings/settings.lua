local settings = {};

-- Money Laundry --

settings.LaundryLocations = {
    [1] = {
        getIn = {
            item = false, -- Item name or false
            interaction = {
                type = 'control', -- target or control
                coords = vec3(-396.7776, 6076.9458, 31.5001),
                heading = 320.0,
                debug = false, -- Only for target or ox zones
                size = vec3(1.5, 1.5, 2), -- Only for target or ox zones
                controlIdx = 38, -- Only for control
                controlLabel = 'E', -- Only for control
                goToCoords = {
                    coords = vec3(1137.99, -3198.72, -39.67),
                    heading = 0.0,
                }
            }
        },
        moneyWash = {
            [1] = {
                coords = vec3(1122.3, -3193.35, -40.4),
                heading = 0.0,
                debug = false,
                size = vec3(1.6, 1.4, 1)
            },
            [2] = {
                coords = vec3(1123.76, -3193.25, -40.4),
                heading = 0.0,
                debug = false,
                size = vec3(1.6, 1.4, 1)
            },
            [3] = {
                coords = vec3(1125.43, -3193.25, -40.4),
                heading = 0.0,
                debug = false,
                size = vec3(1.6, 1.4, 1)
            },
            [4] = {
                coords = vec3(1126.93, -3193.25, -40.4),
                heading = 0.0,
                debug = false,
                size = vec3(1.6, 1.4, 1)
            }
        },
        blip = { -- Table or false
            sprite = 365,
            color = 5,
            scale = 0.9,
            label = 'Laundry',
            coords = vec3(-396.7776, 6076.9458, 31.5001)
        }
    }
};

-- Dealer Configuration --

settings.DealerLocations = {
    [1] = {
        -- The Coords and Heading can be global for the table or for each option different
        interaction = {
            type = 'control', -- target or control
            coords = vec3(-384.27, 6080.07, 31.44),
            heading = 305.0,
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
            coords = vec3(-384.27, 6080.07, 31.44),
            heading = 305.7063
        },
        blip = { -- Table or false
            sprite = 51,
            color = 2,
            scale = 0.8,
            label = 'Dealer',
            coords = vec3(-384.27, 6080.07, 31.44)
        }
    }
};

-- Plants Configuration --

settings.Plants = {
    ['heroin'] = {
        plantItem = 'iron',
        plantProp = 'prop_cs_plant_01',
        animation = {
            dict = '',
            anim = ''
        },
        blipSettings = {
            sprite = 496,
            color = 56,
            scale = 0.8,
            label = 'Heroin Plant'
        },
        locations = {
            {
                plantsAmount = 10,
                coords = vec3(10.7041, 6859.7734, 12.8821),
                heading = 99.8704,
                debug = true,
                radius = 30.0,
                blip = true,
                interactionType = 'target', -- target or control
                controlIdx = 38, -- Only for control
                controlLabel = 'E' -- Only for control
            }
        }
    }
};

-- Custom TextUI/Notifications --

---@param title string
---@param msg string
---@param type string
---@param time number
Notification = function(title, msg, type, time)
    lib.notify({ title = title, description = msg, type = type, duration = time });
end

---@param action string
---@param message string?
TextUI = function(action, message)
    if action == 'show' then
        lib.showTextUI(message);
    elseif action == 'hide' then
        lib.hideTextUI();
    end
end

-- Lang --

settings.lang = require '@king-drugs/settings/lang';

return settings;