-- local response_format = 'Respond EXACTLY in this format:\n```$ftype\n<your code>\n```'
return {
  'nomnivore/ollama.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },

  -- All the user commands added by the plugin
  cmd = { 'Ollama', 'OllamaModel', 'OllamaServe', 'OllamaServeStop' },

  keys = {
    -- Sample keybind for prompt menu. Note that the <c-u> is important for selections to work properly.
    {
      '<leader>oo',
      ":<c-u>lua require('ollama').prompt()<cr>",
      desc = 'ollama prompt',
      mode = { 'n', 'v' },
    },

    -- Sample keybind for direct prompting. Note that the <c-u> is important for selections to work properly.
    {
      '<leader>oG',
      ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
      desc = 'ollama Generate Code',
      mode = { 'n', 'v' },
    },
  },

  ---@type Ollama.Config
  opts = {
    model = 'deepseek-coder',
    -- model = 'codestral',
    url = 'http://127.0.0.1:11434',
    serve = {
      on_start = false,
      command = 'ollama',
      args = { 'serve' },
      stop_command = 'pkill',
      stop_args = { '-SIGTERM', 'ollama' },
    },
    -- View the actual default prompts in ./lua/ollama/prompts.lua
    prompts = {
      --
      -- Ask_About_Code = {
      --   prompt = 'I have a question about this: $input\n\n Here is the code:\n```$ftype\n$sel```',
      --   input_label = 'Q',
      -- },
      --
      -- Explain_Code = {
      --   prompt = 'Explain this code:\n```$ftype\n$sel\n```',
      -- },
      --
      -- -- basically "no prompt"
      -- Raw = {
      --   prompt = '$input',
      --   input_label = '>',
      --   action = 'display',
      -- },
      --
      -- Simplify_Code = {
      --   prompt = 'Simplify the following $ftype code so that it is both easier to read and understand. ' .. response_format .. '\n\n```$ftype\n$sel```',
      --   action = 'replace',
      -- },
      --
      -- Modify_Code = {
      --   prompt = 'Modify this $ftype code in the following way: $input\n\n' .. response_format .. '\n\n```$ftype\n$sel```',
      --   action = 'replace',
      -- },
      --
      -- Generate_Code = {
      --   prompt = 'Generate $ftype code that does the following: $input\n\n' .. response_format,
      --   action = 'insert',
      -- },
      Sample_Prompt = {
        prompt = 'This is a sample prompt that receives $input and $sel(ection), among others.',
        input_label = '> ',
        model = 'mistral',
        action = 'display',
      },
    },
  },
}
