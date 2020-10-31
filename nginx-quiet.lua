local function log(line)
	io.write(line)
	io.write('\n')
	io.flush()
end

local function process_line(line)
	if not line then return end

	-- find the start of what I believe is the connection id
	-- SEE https://git.io/JT9oC
	local _, start_idx = line:find(': *', 1, true)
	if not start_idx then return log(line) end

	-- find the space after the connection id
	_, start_idx = line:find(' ', start_idx, true)
	if not start_idx then return log(line) end

	-- find the end, this looks for the start of the request info
	local end_idx = line:find(', client: ', start_idx, true)
	if not end_idx then return log(line:sub(start_idx + 1)) end

	log(line:sub(start_idx + 1, end_idx - 1))
end

while true do
	process_line(io.read())
end
