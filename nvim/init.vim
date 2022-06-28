set number
set relativenumber
set mouse=a
set autoindent
set noexpandtab
set ignorecase
set smartcase
set nohlsearch
set incsearch
set showmatch
set hidden
" set scrolloff=999
set noswapfile
set nobackup
set shortmess+=c
set undodir=~/.config/nvim/undodir
set undofile
set signcolumn=yes
set cursorline
set completeopt=menuone,noselect
set termguicolors
set nocompatible
set autochdir
filetype plugin on
syntax on


filetype plugin indent on
filetype indent on

let mapleader = " "
set rtp+=/usr/local/opt/fzf

" Keeping the cursor middle positioned
" From this lovely post https://vi.stackexchange.com/questions/26039/how-to-keep-cursor-vertically-aligned-to-center-even-at-the-end-of-buffer
augroup KeepCentered
  autocmd!
  autocmd CursorMoved * normal! zz
augroup END
inoremap <CR> <C-\><C-O><C-E><CR>
inoremap <BS> <BS><C-O>zz
nnoremap o <C-E>o

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Autoapply text width to markdown files
au BufRead,BufNewFile *.md setlocal textwidth=80

" removes any highlighting
nnoremap <silent> <Leader>l :nohl<CR>

call plug#begin('~/.vim/plugged')

" colorschemes 
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'savq/melange'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'navarasu/onedark.nvim'


Plug 'dylanaraps/wal.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
" Nice line under f and t for quick finding
Plug 'unblevable/quick-scope'
Plug 'vimwiki/vimwiki'
Plug 'airblade/vim-gitgutter'
Plug 'psliwka/vim-smoothie'
Plug 'Yggdroot/indentLine'
" To toggle hartime run :HardTimeOn/Off
Plug 'takac/vim-hardtime'
Plug 'christoomey/vim-tmux-navigator' 
" gc to comment out multiple lines at once in visual mode
Plug 'tpope/vim-commentary'
" plugin for saving vim sessions (mainly for tmux ressurect saving)
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'ap/vim-css-color'
Plug 'AndrewRadev/splitjoin.vim'
"Plug 'fatih/vim-go'
Plug 'vim-test/vim-test'
Plug 'karb94/neoscroll.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" native lsp plugins
 Plug 'neovim/nvim-lspconfig'
 Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
 " treesitter-context plugin makes the scroll bar appear when scrolling
 " through code if the function is too long
 Plug 'nvim-treesitter/nvim-treesitter-context'
 Plug 'kyazdani42/nvim-web-devicons'
 Plug 'kyazdani42/nvim-tree.lua'
 Plug 'glepnir/dashboard-nvim'
 Plug 'nvim-lua/popup.nvim'
 Plug 'nvim-lua/plenary.nvim'
 Plug 'nvim-telescope/telescope.nvim'
 Plug 'nvim-lualine/lualine.nvim'
 " Null lsp is used for ALE/linting experiences, attached mypy to it and eslint
 " so far
 Plug 'jose-elias-alvarez/null-ls.nvim'
 Plug 'simrat39/rust-tools.nvim'
 Plug 'williamboman/nvim-lsp-installer'
 Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'

 " nvim cmp plugins
 Plug 'hrsh7th/nvim-cmp'
 Plug 'hrsh7th/vim-vsnip'
 Plug 'hrsh7th/cmp-buffer'
 Plug 'hrsh7th/cmp-path'
 Plug 'hrsh7th/cmp-nvim-lsp'
 Plug 'onsails/lspkind-nvim'
" cmp section ends

 "etc plugins
 Plug 'glepnir/lspsaga.nvim', {'branch': 'main'}
 Plug 'norcalli/nvim-colorizer.lua'
 Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
 Plug 'phaazon/hop.nvim'
 Plug 'folke/trouble.nvim'
 Plug 'kevinhwang91/nvim-bqf'
 Plug 'ThePrimeagen/harpoon'

call plug#end()

lua << EOF
require('neoscroll').setup({
easing_function = "cubic" -- Default easing function
-- Set any other options as needed
})
-- Syntax: t[keys] = {function, {function arguments}}
-- Use the "sine" easing function
local t = {}
t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '170', [['sine']]}}
t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '170', [['sine']]}}

require('neoscroll.config').set_mappings(t)

local nvim_lsp = require('lspconfig')

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys

-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- Use trouble for references instead
  -- Remove buf from nvim_buf_set_keymap when upgrading to nvim 0.7
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

 -- Use a loop to conveniently call 'setup' on multiple servers and
 -- map buffer local keybindings when the language server attaches

-- To use LSPInstall run :LSPInstall {name of server}
-- local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
-- lsp_installer.on_server_ready(function(server)
--     local opts = {
-- 	flags = {
-- 		debounce_text_changes = 500,
-- 	}
--     }
-- 
--     -- (optional) Customize the options passed to the server
--     -- if server.name == "tsserver" then
--     --     opts.root_dir = function() ... end
--     -- end
-- 
--     -- This setup() function is exactly the same as lspconfig's setup function.
--     -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--     server:setup(opts)
-- end)


-- Makes null ls default formatter for typescript filetypes
nvim_lsp.tsserver.setup({
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})
  end,
})

local servers = { 'pyright' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end
-- null ls setup
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md#using-local-executables
local null_ls = require("null-ls")

local sources = {
	--null_ls.builtins.formatting.black,
	null_ls.builtins.formatting.prettier.with({
		prefer_local = "node_modules/.bin",
		extra_args = { "--config", vim.fn.expand("~/wave/src/next-wave/.prettierrc") },
	}),
        null_ls.builtins.diagnostics.eslint_d.with({
		prefer_local = "node_modules/.bin",
	}),
	null_ls.builtins.diagnostics.mypy.with({
		only_local = ".venv/bin",
	}),
	null_ls.builtins.diagnostics.flake8.with({
		only_local = ".venv/bin",
	}),
	-- eslint_d for linting on save file in case?
        -- require("null-ls").builtins.diagnostics.eslint_d,

}

null_ls.setup({ 
	sources = sources,
	flags = { debounce_text_changes = 150 },
	debug = true,
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
		    vim.cmd([[
		    augroup LspFormatting
			autocmd! * <buffer>
			autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
		    augroup END
		    ]])
		end
	end,
})

-- Treesitter support
require'nvim-treesitter.configs'.setup {
  highlight = {
    ensure_installed = { "js", "python", "typescript", "tsx" },
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

" Hop nvim setup

lua << EOF
require'hop'.setup()
vim.api.nvim_set_keymap('n', 'f', "<cmd>HopWord<cr>", {})
EOF



" Telescope keys
lua << EOF
require('telescope').setup{
 defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}

local actions = require("telescope.actions")

require("telescope").setup({
    defaults = {
	wrap_results = true,
	-- taken from here https://github.com/razak17/nvim/blob/107bfbdb4abaca728838511169932bf86b9b803b/lua/user/modules/tools/config/telescope/init.lua
        mappings = {
            i = {
		["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            },
    	    n = {
		["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist, 
	    }
        },
    },
})

require('telescope').load_extension('fzf')

require('bqf').setup()
EOF


" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>rr <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope oldfiles<cr>


" LSP Kind, emojis for autocompletion
lua <<EOF
require('lspkind').init({
    -- DEPRECATED (use mode instead): enables text annotations
    --
    -- default: true
    -- with_text = true,

    -- defines how annotations are shown
    -- default: symbol
    -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
    mode = 'symbol_text',

    -- default symbol map
    -- can be either 'default' (requires nerd-fonts font) or
    -- 'codicons' for codicon preset (requires vscode-codicons font)
    --
    -- default: 'default'
    preset = 'codicons',

    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
      Text = "",
      Method = "",
      Function = "",
      Constructor = "",
      Field = "ﰠ",
      Variable = "",
      Class = "ﴯ",
      Interface = "",
      Module = "",
      Property = "ﰠ",
      Unit = "塞",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "פּ",
      Event = "",
      Operator = "",
      TypeParameter = ""
    },
})
EOF


let g:tokyonight_style = "night"
set background=dark
let g:onedark_config = {
    \ 'style': 'darker',
\}
colorscheme onedark
" require('rust-tools').setup(opts)
"colorscheme wal
"set bg=dark
highlight Normal ctermbg=NONE guibg=none

"nnoremap <silent> <Leader>r :Rg<CR>
"nnoremap <silent> <Leader>ff :GFiles<CR>


"zt zb zz is cursor at top bottom and center respectively


" quickscope highlight only when pressing f and t 
let g:qs_highlight_on_keys = ['f','F','t','T']
" quickscope change colors
highlight QuickScopePrimary guifg='#17ebd6' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#ec80ff' gui=underline ctermfg=81 cterm=underline


"lightline changes colors
let g:lightline = {'colorscheme': 'onedark'}

"vimwiki markdown change 
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

"vim rooter set rooter

let g:smoothie_enabled = 0
let g:smoothie_update_interval = 10
let g:smoothie_speed_constant_factor = 20
let g:smoothie_speed_linear_factor = 20

" nvim-cmp settings
lua <<EOF
local cmp = require'cmp'
local lspkind = require('lspkind')
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  formatting = {
    format = function(entry, vim_item)
    -- fancy icons and a name of kind
    vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind

    -- set a name for each source
    vim_item.menu = ({
      buffer = "[Buffer]",
      nvim_lsp = "[LSP]",
      luasnip = "[LuaSnip]",
      nvim_lua = "[Lua]",
      latex_symbols = "[Latex]",
    })[entry.source.name]
    return vim_item
    end
  },
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<Down>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    -- ['<S-Tab>'] = cmp.mapping.select_prev_item(),
	--['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})

EOF

" VSCode highlight colors for nvim-cmp
" gray
highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
" blue
highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
" light blue
highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
" pink
highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
" front
highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4

" Code navigation shortcuts lsp shortcuts
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>q <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
" Show diagnostic popup on cursor hold
"autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
nnoremap <silent> <leader>e <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <leader>n <cmd>lua vim.lsp.diagnostic.goto_next()<CR>





"cmp source stuff
" lua << EOF
" local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

" require'lspconfig'.rust_analyzer.setup {
"   capabilities = capabilities,
" }
" EOF


lua << EOF
require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'tokyonight',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = { 'dashboard' },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
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
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
EOF

lua << EOF
require'nvim-tree'.setup { -- BEGIN_DEFAULT_OPTS
  auto_reload_on_write = true,
  disable_netrw = false,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  ignore_buffer_on_setup = false,
  open_on_setup = false,
  open_on_setup_file = false,
  open_on_tab = false,
  sort_by = "name",
  update_cwd = false,
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
      custom_only = false,
      list = {
        -- user mappings go here
      },
    },
  },
  renderer = {
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
    }
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  ignore_ft_on_setup = {},
  system_open = {
    cmd = "",
    args = {},
  },
  diagnostics = {
    enable = false,
    show_on_dirs = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 400,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    open_file = {
      quit_on_open = false,
      resize_window = false,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      diagnostics = false,
      git = false,
      profile = false,
    },
  },
} -- END_DEFAULT_OPTS
EOF


let NERDTreeShowHidden=1
nnoremap <leader>nt :NvimTreeToggle<CR>


" setting update time to see if coc autocompletion is faster
set updatetime=100


" Setting tabs to lines for easier reading
set listchars=tab:\|\ 
set list 
" indentLine config, dont know if i need to delete above
let g:indentLine_char = '|'
" indentLine turned off for dashboard nvim
let g:indentLine_fileTypeExclude = ['dashboard']


" Remapping local and global marks
nnoremap mn mN
nnoremap 'n 'N
nnoremap me mE
nnoremap 'e 'E
nnoremap mi mI
nnoremap 'i 'I
nnoremap mo mO
nnoremap 'o 'O
nnoremap ml mL
nnoremap 'l 'L
nnoremap mu mU
nnoremap 'u 'U
nnoremap my mY
nnoremap 'y 'Y

" Paste for last yank that wasn't delete
nnoremap <leader>p "0p

nnoremap <silent> <leader><leader> :source ~/dotfiles/nvim/init.vim<CR>
nnoremap <silent> <leader>nv :e ~/dotfiles/nvim/init.vim<CR>

nnoremap n nzzzv
nnoremap N Nzzzv

vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==


" Markdown toggle stuff
nnoremap <leader>mp :MarkdownPreview
nnoremap <leader>ms :MarkdownPreviewStop
nnoremap <leader>mt :MarkdownPreviewToggle

" Split Vertical buffer
nnoremap <leader>sv :vs<CR>
" Create new tab
nnoremap <leader>tn :tabn<CR>
" close buffer
nnoremap <leader>bd :bd<CR>
" Cycle buffers


" Command to set the current directory to the dir where the current file is
command! SetCDToFileDir cd %:p:h
nn <leader>W :SetCDToFileDir<cr>

let g:dashboard_default_executive='telescope'

let g:dashboard_custom_header_height =200 
let g:dashboard_custom_header = [
	\'      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⣀⡤⠤⠶⠶⠒⠒⠒⠒⠢⠤⢄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
	\'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠴⠊⢡⣠⣆⡵⠦⠤⠄⠐⠾⠴⣦⣰⣈⡑⠢⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
	\'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠴⠓⠂⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠓⠺⢶⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
	\'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠴⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣤⡶⠋⠀⠀⠀⠀⠀⠀⠉⠳⢤⡀⠀⠀⠀⠀⠀⠀⠀⠀ ',
	\'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠎⡀⠀⠂⠀⠀⠀⠀⠀⢀⣤⣶⣿⣿⣿⣿⣿⣭⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠢⣄⠀⠀⠀⠀⠀⠀ ',
	\'⠀⠀⠀⠀⠀⠀⠀⠀⠔⢉⠅⡢⡨⡀⢠⡠⠀⢀⣴⣾⣿⠟⣿⠁⠸⣿⣿⣯⢻⣿⣿⣷⣦⣀⢐⠂⠀⢀⠀⠀⠀⠠⠘⢦⡀⠀⠀⠀⠀ ',
	\'⠀⠀⠀⠀⠀⠀⢠⠊⠀⠃⠪⡠⡪⣜⠆⣨⣾⣿⣿⡿⠁⠀⢻⠀⠀⠹⣿⣿⡄⠙⣿⣿⣿⣿⣷⣴⣈⢆⢄⢔⡹⡢⠑⠀⠳⡄⠀⠀⠀ ',
	\'⠀⠀⠀⠀⠀⢠⠃⠀⠀⠀⠀⡄⡐⠁⣼⣿⣿⢿⡟⠁⠀⠀⠘⠀⠀⠀⠈⢻⣇⠀⠈⢿⡟⣿⣿⣿⡿⡗⠋⠊⠀⠀⠀⠀⠀⠹⡄⠀⠀ ',
	\'⠀⠀⠀⠀⢀⠊⠄⠀⠀⠀⠀⠀⠈⣸⣿⣿⠏⡞⠒⠒⠂⠤⠀⠀⠀⠀⠀⠀⠙⠂⠉⠈⢻⠸⣿⣿⣧⡚⠌⠴⡠⣠⢀⠀⠀⠀⢹⡀⠀ ',
	\'⠀⠀⠀⠀⡎⢸⡘⡌⣦⡐⣦⠲⡰⣿⣿⡟⠀⠁⠀⣀⡀⠀⠀⠀⢀⠀⠀⠀⠀⢀⣠⣤⣀⠁⢻⣿⣿⣿⡷⡞⣱⢃⠞⠄⠠⠀⠈⡇⠀ ',
	\'⠀⠀⠀⢰⢣⢰⠘⡌⣦⢀⡦⠜⠀⠀⣿⠃⠀⣰⠟⠉⠛⠦⠀⠀⢸⡆⠀⠀⠀⠟⠉⠉⠙⠆⠈⣿⡷⠅⠀⠙⡇⣾⣶⠀⡆⢠⠀⡇⠀ ',
	\'⠀⠀⠀⢸⠸⡘⢠⡃⢋⢹⠀⠀⠀⠀⢻⠀⡀⡋⡀⠀⠀⠀⠀⠀⠘⠐⠀⠀⠀⠐⠒⠆⠰⠆⡦⢠⠇⠀⠀⠀⢸⡝⡋⠀⠷⡈⢀⠇⠀ ',
	\'⠀⠀⠀⠘⡆⡇⡜⣃⠜⢹⠀⠀⠀⠀⠚⡾⠛⢉⣄⡤⠀⠒⠒⠈⠉⠉⠉⠉⠉⠉⠁⠐⢖⢤⡀⢸⠄⠀⠀⠀⡰⠠⡙⣌⢧⡘⡜⠀⠀ ',
	\'⠀⠀⠀⠀⢣⠞⡄⡵⡀⠚⠀⠀⠀⠀⠀⢥⠀⣿⠀⠁⢀⣠⣴⣶⣾⣿⣿⣿⣷⣶⣶⣄⡀⢸⠁⡾⡑⠡⠄⠀⠥⡐⠞⡔⠕⡰⠁⠀⠀ ',
	\'⠀⠀⠀⠀⠸⣌⠈⡊⠄⠀⡀⠀⠀⠀⠄⢙⠆⠘⢶⣾⣿⠿⠛⠉⠉⠉⠉⠉⠉⠙⠿⣿⡿⠁⠰⠖⠚⠊⠀⠙⣆⠈⡞⢁⠔⠀⠀⠀⠀ ',
	\'⠀⠀⠀⠀⠀⠈⢦⡈⠀⠀⡱⡆⢀⠥⠠⠨⣚⡄⠀⠻⢤⡔⠒⠀⠀⠉⠉⠉⠉⠐⡢⠍⡔⠂⢭⡠⠀⠀⠀⢠⡙⡠⢭⢅⠀⠀⠀⠀⠀ ',
	\'⠀⠀⠀⠀⠀⠀⠀⠈⠓⢵⡊⡩⠮⡌⣄⢭⡛⣸⡦⣄⡀⠈⠓⠒⠒⠐⠒⠒⠂⠁⠠⢐⡀⠀⠀⠀⠀⠀⠀⢜⢪⡇⠚⡄⠧⡀⠀⠀⠀ ',
	\'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢉⠡⠶⠬⠭⢽⠿⢿⠝⣉⡟⠿⣶⢦⣤⣤⣤⣤⣶⣾⣿⣇⠣⠄⠤⠔⠉⠉⠑⠂⡁⠨⣀⠷⠀⢰⠀⠀⠀ ',
	\'⠀⠀⠀⠀⠀⠀⠀⢀⣔⡪⣥⠀⠀⠀⠀⠀⠀⠀⠉⠙⢇⠀⠈⠺⣿⣿⢿⣿⣿⠟⡸⠚⠉⠁⠁⠀⠀⠀⢀⠠⢑⠢⢥⠅⢒⡁⠀⠀⠀ ',
	\'⠀⠀⠀⠀⠀⠀⠜⠁⠀⠈⠀⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠉⠲⢄⠈⠉⢹⠻⠯⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠘⡆⠀⠀ ',
	\ ]
highlight dashboardHeader guifg='#732e3e' ctermfg=200

lua <<EOF
vim.g.dashboard_custom_section = {
    a = {description = {'  New file                  '}, command = 'DashboardNewFile'},
    b = {description = {'  Browse files              '}, command = 'Telescope find_files'},
    c = {description = {'  Recents                   '}, command = 'Telescope oldfiles'},
    d = {description = {'  Settings                  '}, command = 'edit ~/dotfiles/nvim/init.vim'},
    e = {description = {'  Exit                      '}, command = 'exit'},
}
EOF

" Hover diagnostics for lsp in this
lua << EOF
--vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
EOF

" copy and paste clipboard stuff
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+y$

"toggle quickfix list fast
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction
nnoremap <leader>qc :call ToggleQuickFix()<CR>


"For the splitjoin plugin press gS to open stuff in {} and gJ to join stuff in {}
"

" ts/js files spacing
augroup SyntaxSettings
	autocmd!
	autocmd BufNewFile, BufRead *.tsx set filetype=typescriptreact
augroup END

autocmd Filetype javascript setlocal ts=2 sw=2 sts=0 noexpandtab
autocmd Filetype typescript setlocal ts=2 sw=2 sts=0 noexpandtab
autocmd Filetype typescriptreact setlocal ts=2 sw=2 sts=0 noexpandtab

" pretty references
nnoremap gR <cmd>TroubleToggle lsp_references<cr>

nnoremap <leader>tf :TestFile<cr>
nnoremap <leader>tn :TestNearest<cr>
nnoremap <leader>tv :TestVisit<cr>


" harpoon remaps / config
lua << EOF
require("harpoon").setup({
	global_settings = {
		mark_branch = true,
	}
})
EOF
nnoremap ma :lua require("harpoon.mark").add_file()<cr>
nnoremap <leader>fh :lua require("harpoon.ui").toggle_quick_menu()<cr>
nnoremap 'n :lua require("harpoon.ui").nav_file(1)<cr>
nnoremap 'e :lua require("harpoon.ui").nav_file(2)<cr>
nnoremap 'i :lua require("harpoon.ui").nav_file(3)<cr>
nnoremap 'o :lua require("harpoon.ui").nav_file(4)<cr>
nnoremap 'l :lua require("harpoon.ui").nav_file(5)<cr>
nnoremap 'u :lua require("harpoon.ui").nav_file(6)<cr>
nnoremap 'y :lua require("harpoon.ui").nav_file(7)<cr>

"Remaps hl movements to beginning/end of the line
nnoremap L $
nnoremap H ^

" " folding with treesitter
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

" " automatically open all folds in new file
" " zM to close all folds, za to toggle, zc to close, zo to open
" autocmd BufReadPost,FileReadPost * normal zR
