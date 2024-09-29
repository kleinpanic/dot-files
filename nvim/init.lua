-- Enable line numbers
vim.o.number = true

-- Enable true color support
if vim.fn.has("termguicolors") then
  vim.o.termguicolors = true
end

-- Set the indentation rules
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Enable syntax highlighting
vim.cmd [[packadd packer.nvim]]

-- Use a protected call to avoid errors on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  print("Packer not found!")
  return
end

-- Initialize the plugins
packer.init({
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end,
  },
})

-- Specify the plugins
packer.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- File icons
  use 'kyazdani42/nvim-web-devicons'

  -- Gruvbox theme
  use {
    'morhetz/gruvbox',
    config = function()
      vim.cmd 'colorscheme gruvbox'
    end
  }

  -- Commenting
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- Status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'gruvbox',
          component_separators = '|',
          section_separators = '',
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', {'diagnostics', sources={'nvim_lsp', 'coc'}}},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
        },
        tabline = {},
        extensions = {}
      }
    end
  }

  -- Markdown preview
  use {'iamcco/markdown-preview.nvim'}

  -- Vimwiki
  use {
    'vimwiki/vimwiki',
    config = function()
      vim.g.vimwiki_list = {{
        path = '~/vimwiki/',
        syntax = 'markdown',
        ext = '.md',
        diary_rel_path = 'diary/'
      }}
    end
  }

  -- Gitsigns
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup()
    end
  }

  -- Which-key
  use {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup()
    end
  }

  -- nvim-cmp for autocompletion
  use 'hrsh7th/nvim-cmp' -- Completion framework
  use 'hrsh7th/cmp-nvim-lsp' -- LSP completion source
  use 'hrsh7th/cmp-buffer' -- Buffer completion source
  use 'hrsh7th/cmp-path' -- Path completion source
  use 'hrsh7th/cmp-cmdline' -- Command line completion source
  use 'saadparwaiz1/cmp_luasnip' -- Snippet completion source
  use 'L3MON4D3/LuaSnip' -- Snippet engine

  -- LSP support
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client

  -- File explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require'nvim-tree'.setup {}
    end
  }

  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function()
      require'telescope'.setup {}
    end
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        highlight = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
        },
        textobjects = {
          select = {
            enable = true,
          },
        },
      }
    end
  }

  -- Auto-pairs
  use {
    'windwp/nvim-autopairs',
    config = function()
      require'nvim-autopairs'.setup {}
    end
  }

end)

-- LSP settings
local lspconfig = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Enable the following language servers
local servers = { 'pyright', 'tsserver', 'gopls', 'rust_analyzer' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
  }
end

-- nvim-cmp setup
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  }
})

-- Keybindings for custom functions
function SearchWikipedia()
  local query = vim.fn.input('Wikipedia Search: ')
  query = vim.fn.shellescape(query)
  local search_url = "https://en.wikipedia.org/wiki/Special:Search?search=" .. query
  vim.cmd('silent !xdg-open ' .. search_url)
end

vim.api.nvim_set_keymap('n', '<leader>w', ':lua SearchWikipedia()<CR>', {noremap = true, silent = true})

require('arduino')

local group = vim.api.nvim_create_augroup('FileTypeSpecific', {clear = true})
local associations = {
--  extension   functions to call
    { '*.ino' , { arduino } },
}

for _, assoc in ipairs(associations) do
    local pattern = assoc[1]
    local callbacks = assoc[2]

    vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead', 'BufEnter'}, {
        pattern = pattern,
        group = group,
        callback = 
            function() 
                for _, callback in ipairs(callbacks) do 
                    callback() 
                end 
            end
    })
end
