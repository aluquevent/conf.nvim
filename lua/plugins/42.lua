return {
	"vinicius507/ft_nvim",
	cmd = { "FtHeader", "Norme" }, -- Lazy load the commands.
	ft = { "c", "cpp" }, -- Lazy load for .c and .h files.
	opts = {
		-- Configures the 42 Header integration
		header = {
			enable = true,
			username = "aluque-v",
			email = "aluque-v@42barcelona.student.com",
		},
		norminette = {
			enable = true,
			cmd = "norminette",
			condition = function()
				return true
			end,
		},
	},
}
