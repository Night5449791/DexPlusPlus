local releaseUrl = "https://github.com/Night5449791/DexPlusPlus/releases/latest/download/out.lua"
local repositoryUrl = "https://raw.githubusercontent.com/Night5449791/DexPlusPlus/main/out.lua"

local function fetchChunk(url)
	local ok, result = pcall(function()
		local source = game:HttpGet(url)
		if not source or source == "" then
			error("empty response from " .. url, 0)
		end

		local chunk, compileError = loadstring(source)
		if not chunk then
			error(compileError or "failed to compile bundle", 0)
		end

		return chunk
	end)

	if ok then
		return result
	end

	return nil, result
end

local chunk, releaseError = fetchChunk(releaseUrl)

if not chunk then
	local repoChunk, repoError = fetchChunk(repositoryUrl)
	if not repoChunk then
		error("Dex++ failed to load: release=" .. tostring(releaseError) .. " repository=" .. tostring(repoError), 0)
	end
	chunk = repoChunk
end

chunk()
