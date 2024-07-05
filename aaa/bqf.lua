-- Define a function to check if a plugin is available or not
local function IsNotAvailable(plugin)
    -- If the plugin is not in the packer_plugins table or it is not loaded
    if not packer_plugins[plugin] or not packer_plugins[plugin].loaded then
        -- Call the LazyVim.is_loaded function with the plugin as argument
        LazyVim.is_loaded(plugin)
        -- Return true indicating the plugin is not available
        return true
    end
    -- If the plugin is in the packer_plugins table and it is loaded, return false
    return false
end

-- Return the result of the packer startup function
return require('packer').startup(function()
    -- Use the nvim-bqf plugin
    use {
        "kevinhwang91/nvim-bqf",
        -- Set the filetype to "qf"
        ft = "qf",
        -- Do not disable the plugin
        disable = false,
        -- Configure the plugin
        config = function()
            -- If the nvim-bqf plugin is not available, return
            if IsNotAvailable('nvim-bqf') then return end
            -- Setup the bqf plugin
            require('bqf').setup({
                -- Configure the preview
                preview = {
                    -- Set the height of the window to 25
                    win_height = 25,
                    -- Set the winblend to 0
                    winblend = 0
                }
            })
        end
    }
end)
