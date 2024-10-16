Current = {
	_id = "current",
}

function Current:new(area, tab)
	return setmetatable({
		_area = area,
		_tab = tab,
		_folder = tab.current,
	}, { __index = self })
end

function Current:empty()
	local line
	if self._folder.files.filter then
		line = ui.Line("No filter results")
	else
		line = ui.Line(self._folder.stage.is_loading and "Loading..." or "No items")
	end

	return {
		ui.Text(line):area(self._area):align(ui.Text.CENTER),
	}
end

function Current:render()
	local files = self._folder.window
	if #files == 0 then
		return self:empty()
	end

	local entities, linemodes = {}, {}
	for _, f in ipairs(files) do
		linemodes[#linemodes + 1] = Linemode:new(f):render()
		entities[#entities + 1] = Entity:new(f):render()
	end

	return {
		ui.List(entities):area(self._area),
		ui.Text(linemodes):area(self._area):align(ui.Text.RIGHT),
	}
end

-- Mouse events
function Current:click(event, up)
	if up or event.is_middle then
		return
	end

	local f = self._folder
	local y = event.y - self._area.y + 1
	if y > #f.window or not f.hovered then
		return
	end

	ya.manager_emit("arrow", { y + f.offset - f.hovered.idx })
	if event.is_right then
		ya.manager_emit("open", {})
	end
end

function Current:scroll(event, step) ya.manager_emit("arrow", { step }) end

function Current:touch(event, step) end
