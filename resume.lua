local utils = require "mp.utils"
local msg = require "mp.msg"

local subs_for = {}

local accmd = assert(mp.get_opt("re-anitomy-cli-cmd"), "re-anitomy-cli-cmd not passed")
local args = {
    "/bin/sh",
    "-c",
    [[
{
 printf '%s\0' "$@"
 printf '\0'
 find -type f -regextype posix-extended -iregex '.*\.(ass|srt)' -print0
} | ]] .. accmd .. " -z attach",
    "_", -- this will be $0
}
for i = 0, mp.get_property_number("playlist/count") - 1 do
    table.insert(args, mp.get_property("playlist/" .. i .. "/filename"))
end
local resp = utils.subprocess{args=args}
if resp.error then
    error("mp.utils.subprocess() returned error: " .. resp.error)
elseif resp.status ~= 0 then
    error("sh exited with non-zero code: " .. resp.status)
end
local cur_file = nil
for line in resp.stdout:gmatch("(.-)\0") do
    if line == "" then
        cur_file = nil
    elseif not cur_file then
        cur_file = line
        subs_for[cur_file] = {}
    else
        table.insert(subs_for[cur_file], line)
    end
end
assert(mp.register_event("file-loaded", function(data)
    local subs = subs_for[mp.get_property("filename")]
    if subs then
        for _, sub in ipairs(subs) do
            mp.commandv("sub-add", sub)
        end
    end
end), "file-loaded event not found!")
