return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		delay = 50,
		win = {
			row = 1,
			col = math.huge,
			width = { max = 40 },
			height = { max = 15 },
			title = false,
			border = "single",
			padding = { 0, 1 },
		},
		layout = {
			width = { min = 15, max = 35 },
			spacing = 2,
		},
		plugins = {
			marks = true,
			registers = true,
			spelling = { enabled = true, suggestions = 10 },
			presets = {
				operators = true,
				motions = true,
				text_objects = true,
				windows = true,
				nav = true,
				z = true,
				g = true,
			},
		},
		expand = 0,
		spec = {
			{ "<leader>f", group = "Find" },
			{ "<leader>c", group = "Code" },
			{ "<leader>d", group = "Document" },
			{ "<leader>w", group = "Workspace" },
			{ "<leader>t", group = "Toggle" },
			{ "<leader>s", group = "Save/Split" },
		},
		icons = {
			group = "+ ",
			mappings = false,
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps",
		},
	},
}
