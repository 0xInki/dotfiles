-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

---@module 'lazy'
---@type LazySpec
return {

  -- ============================================================
  -- SIDEKICK
  -- Integração com Claude Code (e outros AI CLIs) num pane lateral
  -- <leader>aa  → abre/fecha o terminal AI
  -- <leader>ac  → abre/fecha especificamente o Claude
  -- <leader>as  → troca de CLI (Claude, Gemini, etc.)
  -- <c-.>       → foca o pane do sidekick
  -- <Tab>       → aceita Next Edit Suggestion do Copilot
  -- Após instalar, rode :checkhealth sidekick para verificar
  -- https://github.com/folke/sidekick.nvim
  -- ============================================================
  {
    'folke/sidekick.nvim',
    opts = {
      cli = {
        mux = {
          backend = 'tmux',
          enabled = true,
        },
      },
    },
    keys = {
      {
        '<tab>',
        function()
          if not require('sidekick').nes_jump_or_apply() then
            return '<Tab>'
          end
        end,
        expr = true,
        desc = 'Goto/Apply Next Edit Suggestion',
      },
      {
        '<c-.>',
        function() require('sidekick.cli').focus() end,
        desc = 'Sidekick Focus',
        mode = { 'n', 't', 'i', 'x' },
      },
      {
        '<leader>aa',
        function() require('sidekick.cli').toggle() end,
        desc = 'Sidekick Toggle CLI',
      },
      {
        '<leader>as',
        function() require('sidekick.cli').select() end,
        desc = 'Select CLI',
      },
      {
        '<leader>ac',
        function() require('sidekick.cli').toggle({ name = 'claude', focus = true }) end,
        desc = 'Sidekick Toggle Claude',
      },
    },
  },

  -- ============================================================
  -- CODE BRIDGE
  -- Integração entre o editor e ferramentas externas de código
  -- https://github.com/samir-roy/code-bridge.nvim
  -- ============================================================
  {
    'samir-roy/code-bridge.nvim',
    config = function()
      require('code-bridge').setup()
    end,
  },

  -- ============================================================
  -- COPILOT
  -- Sugestões de código com IA do GitHub Copilot
  -- Após instalar, rode :Copilot setup para autenticar
  -- https://github.com/github/copilot.vim
  -- ============================================================
  {
    'github/copilot.vim',
  },

  -- ============================================================
  -- ARROW
  -- Bookmarks rápidos de arquivos e posições no buffer
  -- ';' abre o menu global | 'm' abre o menu por buffer
  -- https://github.com/otavioschwanck/arrow.nvim
  -- ============================================================
  {
    'otavioschwanck/arrow.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
    },
    opts = {
      show_icons = true,
      leader_key = ';',
      buffer_leader_key = 'm',
    },
  },
}
