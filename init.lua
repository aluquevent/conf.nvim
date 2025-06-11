require("config.lazy")
-- Cargar la configuración de 42 School
require("42_config").setup()

-- Keymaps adicionales para 42 School
vim.keymap.set("n", "<leader>42", function()
    print("42 School Commands:")
    print("  <leader>nf - Format with norminette")
    print("  :Norminette - Format current file")
    print("  :ToggleNorminetteAuto - Toggle auto-format on save")
    print("  :ToggleHeaderUpdate - Toggle header update on save")
end, { desc = "Show 42 commands help" })
