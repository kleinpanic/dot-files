function map(mode, shortcut, command)
	vim.api.nvim_set_keymap(mode, shortcut, command, {noremap=true})
end

function nn(shortcut, command)
	map('n', shortcut, command)
end

function ino(shortcut, command)
	map('i', shortcut, command)
end

function arduino()
    baudrate = 9600
    -- compile and upload sketch
	nn('<c-n>', ":w | !$HOME/.config/nvim/scripts/arduino -u '%'<cr>")
    -- show information about connected board
	nn('+', ":w | !$HOME/.config/nvim/scripts/arduino -i<cr>")
    -- monitor serial data
	nn('-', ":w | tabe | ter $HOME/.config/nvim/scripts/arduino -m " .. baudrate .. " <cr>i")
end
