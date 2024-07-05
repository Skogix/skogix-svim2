# sVim 0.7

## flow
/init.lua -> ???
skogix.lazy.init -> 
/

## todo

- test


## done
"what does this file do, what are its inputs and outputs and whats important?"
### skogix/config/lazy.lua
This Lua script is responsible for setting up the LazyVim environment, a configuration for the Neovim editor. Here's a breakdown of its functionality, inputs, outputs, and important aspects:

**Functionality:**

- Clones necessary repositories if they are not already installed. This includes the `lazy.nvim` and `LazyVim` repositories.
- Loads user options from a specific setup file (`lua/config/setup.lua`).
- Checks if certain plugin files exist (`lua/plugins/` or `lua/plugins.lua`).
- Sets up the LazyVim environment with a specific configuration.

**Inputs:**

- The script doesn't take any direct inputs, but it does use the `vim.fn.stdpath` function to get standard file paths, and it checks for the existence of certain files and directories.
- It also attempts to load user options from `lua/config/setup.lua`.

**Outputs:**

- The script doesn't produce any direct outputs, but it does print messages to the console when it's installing repositories.
- Its main effect is to modify the Neovim environment by cloning repositories, loading user options, and setting up the LazyVim environment.

**Important Aspects:**

- The `clone` function is crucial as it's responsible for cloning the necessary repositories.
- The script checks if the `lua/config/setup.lua` file exists and contains a 'lazy_opts' field. If it does, its value is used; otherwise, an empty table is used. This allows for user customization.
- The script checks if `lua/plugins/` or `lua/plugins.lua` exist. If either file exists, a variable `has_user_plugins` is set to true. This allows the script to adapt based on the user's plugin configuration.
- The LazyVim environment setup at the end of the script is also important, as it defines the plugins to be loaded and other configuration options.






  R
    "nvim-neorg/neorg",
    -- lazy-load on filetype
    ft = "norg",
    -- options for neorg. This will automatically call `require("neorg").setup(opts)`
    opts = {
      load = {
        ["core.defaults"] = {},
      },
    },
  },
