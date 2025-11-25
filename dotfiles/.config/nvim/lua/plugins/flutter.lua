-- ~/.config/nvim/lua/plugins/flutter.lua
return {
  -- 1. Flutter Tools (ana paket)
  {
    "akinsho/flutter-tools.nvim",
    lazy = false, -- Flutter projesi açtığında hemen yüklensin
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- güzel select/input pencereleri
    },
    config = function()
      require("flutter-tools").setup({
        ui = {
          border = "rounded",
          notification_style = "native", -- Arch'ta libnotify çok güzel duruyor
        },
        decorations = {
          statusline = {
            app_version = true,
            device = true,
            project_config = true,
          },
        },
        widget_guides = { enabled = true }, -- widget hizalamada çizgiler
        closing_tags = { enabled = true }, -- </Widget> otomatik kapatır
        dev_log = { enabled = false, open_cmd = "tabnew" },
        lsp = {
          color = { enabled = false }, -- Color(0xff...) yanına renk kutusu
          settings = {
            showTodos = true,
            completeFunctionCalls = true,
            renameFilesWithClasses = "prompt", -- dosya adını da refactor eder
            lineLength = 100,
          },
        },
        fvm = false,
        flutter_lookup_cmd = "mise where flutter", -- mise kullanıyorsan kesin çalışır
      })
    end,
  },

  -- 2. Telescope entegrasyonu (fzf ile Flutter komutları)
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local ok, _ = pcall(require, "flutter-tools")
      if ok then
        require("telescope").load_extension("flutter")
      end
    end,
  },
}
