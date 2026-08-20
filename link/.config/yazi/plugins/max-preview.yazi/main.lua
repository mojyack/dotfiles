--- @sync entry

local function toggle(self)
    if self.restore == 1 then
        rt.mgr.ratio = self.ratio
        self.restore = 0
    else
        self.ratio = rt.mgr.ratio
        rt.mgr.ratio = {0, 0, 1}
        self.restore = 1
    end
    ya.emit("app:resize", {})
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
    ya.emit(act[1], act[2])
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
