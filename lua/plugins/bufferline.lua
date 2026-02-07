return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "echasnovski/mini.icons" },
	event = "VeryLazy",
	opts = {
		options = {
			diagnostics = "nvim_lsp",
			offsets = {
				{
					filetype = "oil",
					text = "File Explorer",
					highlight = "Directory",
					separator = true,
				},
			},
			separator_style = "thin",
			show_close_icon = false,
			show_buffer_close_icons = true,
		},
	},
}
