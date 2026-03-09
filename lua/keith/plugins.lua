return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme tokyonight-night]])
        end,
    },

    --{
    --    "nvim-telescope/telescope.nvim",
    --    version = '*',
    --    dependencies = {
    --        'nvim-lua/plenary.nvim',
    --        {
    --            'nvim-telescope/telescope-fzf-native.nvim',
    --            build = 'make',
    --        },
    --    },
    --},

    {
        "nvim-mini/mini.pairs",
        version = '*'
    },

    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ':TSUpdate'
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", opt = true }
    },

    {
        "ThePrimeagen/harpoon",
        dependencies = {
            'nvim-lua/plenary.nvim'
        }
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },

    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        -- or if using mini.icons/mini.nvim
        -- dependencies = { "nvim-mini/mini.icons" },
        ---@module "fzf-lua"
        ---@type fzf-lua.Config|{}
        ---@diagnostic disable: missing-fields
        opts = {}
        ---@diagnostic enable: missing-fields
    },

    {
        "mbbill/undotree"
    },

    {
        "tpope/vim-fugitive"
    },

	{
		"neovim/nvim-lspconfig"
	},

	{
		"hrsh7th/cmp-nvim-lsp"
	},

	{
		"hrsh7th/cmp-buffer"
	},

	{
		"hrsh7th/cmp-path"
	},

	{
		"hrsh7th/cmp-cmdline"
	},

	{
		"hrsh7th/nvim-cmp"
	},
}
