local M = {}

M.setup_42_header = function()
    local function get_username()
        return "aluque-v"
    end

    local function get_email()
        local username = get_username()
        return username .. "@student.42barcelona.co"
    end

    local function generate_42_header(filename)
        local username = get_username()
        local email = get_email()
        local date = os.date("%Y/%m/%d %H:%M:%S")

        local header = {
            "/* ************************************************************************** */",
            "/*                                                                            */",
            "/*                                                        :::      ::::::::   */",
            string.format("/*   %-50s :+:      :+:    :+:   */", filename),
            "/*                                                    +:+ +:+         +:+     */",
            "/*   By: aluque-v <aluque-v@student.42barcelona.co  +#+  +:+       +#+        */",
            "/*                                                +#+#+#+#+#+   +#+           */",
            string.format("/*   Created: %-41s #+#    #+#            */", date .. " by " .. username),
            string.format("/*   Updated: %-41s ###   ########.fr     */", date .. " by " .. username),
            "/*                                                                            */",
            "/* ************************************************************************** */",
        }

        return header
    end

    vim.api.nvim_create_autocmd("BufNewFile", {
        pattern = "*.c",
        callback = function()
            local filename = vim.fn.expand("%:t")
            local header = generate_42_header(filename)

            vim.api.nvim_buf_set_lines(0, 0, 0, false, header)
            vim.api.nvim_buf_set_lines(0, #header, #header, false, { "", "" })

            vim.api.nvim_win_set_cursor(0, { #header + 1, 0 })
        end,
    })

    vim.api.nvim_create_autocmd("BufNewFile", {
        pattern = "Makefile",
        callback = function()
            local filename = "Makefile"
            local header = generate_42_header(filename)

            for i, line in ipairs(header) do
                header[i] = "#" .. line:sub(2)
            end

            vim.api.nvim_buf_set_lines(0, 0, 0, false, header)
            vim.api.nvim_buf_set_lines(0, #header, #header, false, { "", "" })
            vim.api.nvim_win_set_cursor(0, { #header + 3, 0 })
        end,
    })
end

M.setup_norminette = function()
    local function format_with_norminette()
        local file = vim.fn.expand("%:p")

        if vim.fn.executable("c_formatter_42") == 0 then
            vim.notify(
                "c_formatter_42 no está instalado. Instálalo con: pip install c-formatter-42",
                vim.log.levels.ERROR
            )
            return
        end

        local cursor_pos = vim.api.nvim_win_get_cursor(0)

        local cmd = "c_formatter_42 " .. vim.fn.shellescape(file)
        local result = vim.fn.system(cmd)

        if vim.v.shell_error == 0 then
            vim.cmd("edit!")
            vim.api.nvim_win_set_cursor(0, cursor_pos)
            vim.notify("Archivo formateado según norminette", vim.log.levels.INFO)
        else
            vim.notify("Error al formatear: " .. result, vim.log.levels.ERROR)
        end
    end

    vim.api.nvim_create_user_command("Norminette", format_with_norminette, {})

    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.c",
        callback = function()
            if vim.g.norminette_auto_format then
                format_with_norminette()
            end
        end,
    })

    vim.keymap.set("n", "<leader>nf", format_with_norminette, {
        desc = "Format with norminette",
        silent = true,
    })
end

M.update_header = function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, 15, false)
    local username = "aluque-v"
    local date = os.date("%Y/%m/%d %H:%M:%S")

    for i, line in ipairs(lines) do
        if line:match("Updated:") then
            local updated_line =
                string.format("/*   Updated: %-41s ###   ########.fr     */", date .. " by " .. username)
            vim.api.nvim_buf_set_lines(0, i - 1, i, false, { updated_line })
            break
        end
    end
end

M.setup_header_update = function()
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.c", "Makefile" },
        callback = function()
            if vim.g.update_42_header then
                M.update_header()
            end
        end,
    })
end

M.setup_config = function()
    vim.g.norminette_auto_format = false

    vim.g.update_42_header = true

    vim.api.nvim_create_user_command("ToggleNorminetteAuto", function()
        vim.g.norminette_auto_format = not vim.g.norminette_auto_format
        local status = vim.g.norminette_auto_format and "habilitado" or "deshabilitado"
        vim.notify("Formateo automático con norminette " .. status)
    end, {})

    vim.api.nvim_create_user_command("ToggleHeaderUpdate", function()
        vim.g.update_42_header = not vim.g.update_42_header
        local status = vim.g.update_42_header and "habilitado" or "deshabilitado"
        vim.notify("Actualización automática del header " .. status)
    end, {})
end

M.setup = function()
    M.setup_42_header()
    M.setup_norminette()
    M.setup_header_update()
    M.setup_config()

    vim.notify("Configuración de 42 School cargada correctamente", vim.log.levels.INFO)
end

return M
