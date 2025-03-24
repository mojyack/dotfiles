local function fetch_yanks()
    local cwd = cx.active.current.cwd
    local is_cut = cx.yanked.is_cut
    local urls = {}
    for idx, url in pairs(cx.yanked) do
        urls[idx] = tostring(url)
    end
    ya.mgr_emit("unyank", {})
    return tostring(cwd), is_cut, urls
end

local sync_fetch_yanks = ya.sync(fetch_yanks)

function entry()
    local cwd, is_cut, urls = sync_fetch_yanks()
    -- ya.dbg("yanked list cut=" .. tostring(is_cut), "cwd=" .. cwd)
    -- for idx, url in pairs(urls) do
    --     ya.dbg(idx, url)
    -- end

    local command = Command("recursive-move")
    if not is_cut then
        command:arg("--copy")
    end
    for idx, url in pairs(urls) do
        command:arg(url)
    end
    command:arg(cwd)

    local status, err = command:status()
    if not status or not status.success then
        ya.notify{
            title = "merge-paste",
            content = "operation failed",
            level = "error",
            timeout = 3,
        }
    end
end

return {
    entry = entry
}
