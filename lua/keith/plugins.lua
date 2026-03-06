return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme tokyonight-night]])
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        version = '*',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
            },
        },
    },

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
