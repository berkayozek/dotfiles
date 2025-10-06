local function is_leetcode_buffer(bufnr)
  local buf_name = vim.api.nvim_buf_get_name(bufnr or 0)
  return buf_name and string.find(buf_name, "/leetcode/", 1, true)
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("DisableLspForLeetCode", { clear = true }),
  callback = function(args)
    -- We need the buffer number from the arguments
    local bufnr = args.buf

    -- Check if the path contains the leetcode directory
    if is_leetcode_buffer(bufnr) then
      -- CRITICAL: Defer the detach operation.
      -- This waits until the initial LSP setup is complete, avoiding errors.
      vim.schedule(function()
        vim.lsp.buf_detach_client(bufnr, args.data.client_id)
      end)
      vim.diagnostic.enable(false)
      vim.b.completion = false
    end
  end,
})

return {
	{
		"kawre/leetcode.nvim",
		cmd = "Leet",
		event = { "BufRead leetcode.nvim", "BufNewFile leetcode.nvim" },
		build = ":TSUpdate html",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			lang = "java",
			injector = {
				["java"] = {
					before = "import java.util.*;",
				},
			},
		},
		keys = {
			{ "<leader>ll", "<cmd>Leet list<cr>", desc = "Leet list questions" },
			{ "<leader>lr", "<cmd>Leet run<cr>", desc = "Leet run question" },
			{ "<leader>lt", "<cmd>Leet tabs<cr>", desc = "Leet tabs" },
			{ "<leader>lc", "<cmd>Leet console<cr>", desc = "Leet toggle console" },
			{ "<leader>ls", "<cmd>Leet submit<cr>", desc = "Leet submit question" },
			{ "<leader>lo", "<cmd>Leet open<cr>", desc = "Leet open question on browser" },
			{ "<leader>lh", "<cmd>Leet hints<cr>", desc = "Leet open hints" },
			{ "<leader>lf", "<cmd>Leet fold<cr>", desc = "Leet fold" },
		},
	},
	{ "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },
}
