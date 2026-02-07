return {
	"m4xshen/hardtime.nvim",
	dependencies = { "MunifTanjim/nui.nvim" },
	event = "VeryLazy",
	opts = {
		max_count = 3,
		disable_mouse = false,
		hint = true,
		notification = true,
	},
	keys = {
		{ "<leader>th", "<cmd>Hardtime toggle<CR>", desc = "[T]oggle [H]ardtime" },
	},
}
