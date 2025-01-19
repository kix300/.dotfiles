-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<C-t>", function()
	vim.cmd("vsplit | terminal")
end, { desc = "Ouvrir un terminal dans un nouvel onglet" })

vim.keymap.set("n", "<A-t>", ":bdelete! | q!<CR>", { desc = "Fermer l'onglet actuel" })
