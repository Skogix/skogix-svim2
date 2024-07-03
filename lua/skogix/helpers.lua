Spawn_lazyterm = function()
	LazyVim.terminal(nil, { cwd = LazyVim.root() })
end

Open_readme = function()
	local readme_path = vim.fn.globpath(".", "**/readme.norg", true, 0)[1]

	if readme_path == nil then
		readme_path = vim.fn.globpath(".", "**/README.md", true, 1)[1]
	end

	if readme_path ~= nil then
		vim.cmd("tabnew")
		vim.cmd("edit " .. readme_path)
	else
		print("Neither readme.norg nor readme.md found in the current directory.")
	end
end
