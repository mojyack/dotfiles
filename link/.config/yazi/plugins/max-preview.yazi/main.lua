--- @sync entry

local function toggle(self)
	local ratio = rt.mgr.ratio

    if self.restore == 1 then
        ratio.parent = self.parent   
        ratio.current = self.current  
        ratio.preview = self.preview  
        self.restore = 0
    else
        self.parent = ratio.parent
        self.current = ratio.current
        self.preview = ratio.preview
        self.restore = 1
        ratio.parent = 0
        ratio.current = 0
        ratio.preview = 200
    end
    ya.app_emit("resize", {})
end

local function move(self, cmd)
    local act_normal = {
        ["up"]   = {"arrow", {"prev"}},
        ["down"] = {"arrow", {"next"}},
        ["UP"]   = {"arrow", {"-100%"}},
        ["DOWN"] = {"arrow", {"+100%"}},
    }
    local act_preview = {
        ["up"]   = {"seek", {"-1"}},
        ["down"] = {"seek", {"+1"}},
        ["UP"]   = {"seek", {"-5"}},
        ["DOWN"] = {"seek", {"+5"}},
    }
    local act = self.restore == 1 and act_preview[cmd] or act_normal[cmd]
    ya.mgr_emit(act[1], act[2])
end

local function entry(self, job)
    if job.args[1] == "toggle" then
        toggle(self)
    else
        move(self, job.args[1])
    end
end

return {
    entry = entry
}
