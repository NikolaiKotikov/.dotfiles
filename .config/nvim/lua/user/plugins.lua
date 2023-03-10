local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "kyazdani42/nvim-web-devicons" -- Fancy icons set used my several packages

  -- Terminal
  use {
    "akinsho/toggleterm.nvim", tag = '*',
    config = function() require("user.plugins.toggleterm") end
  }
  -- Lsp
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    },
    config = function() require("user.plugins.lsp") end
  }

  -- Autopairs, integrates with both cmp and treesitter
  use ({
    "windwp/nvim-autopairs",
    config = function() require("user.plugins.autopairs") end
  })

  -- Comments including jsx
  use {
    "numToStr/Comment.nvim",
    requires = {"JoosepAlviste/nvim-ts-context-commentstring"},
    config = function()
        require("user.plugins.comment")
    end
}

  -- Surround
  use({
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  })

  -- File explorer
  use ({
    "kyazdani42/nvim-tree.lua",
    config = function() require("user.plugins.nvim-tree") end
  })

  -- Colorschemes
  -- use ({
    --   "folke/tokyonight.nvim",
    --   config = function() require("user.plugins.colorschemes.tokyonight") end
    -- })

    use({
      "navarasu/onedark.nvim",
      config = function() require("user.plugins.colorschemes.onedark") end
    })

    -- Telescope
    use {
      "nvim-telescope/telescope.nvim", tag = '0.1.0',
      -- or                            , branch = '0.1.x',
      requires = { {"nvim-lua/plenary.nvim"} },
      config = function() require("user.plugins.telescope") end
    }

    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = function()
        pcall(require("nvim-treesitter.install").update { with_sync = true })
      end,
      config = function() require("user.plugins.treesitter") end
    }
    use "nvim-treesitter/nvim-treesitter-textobjects"

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
      require("packer").sync()
    end
  end)
