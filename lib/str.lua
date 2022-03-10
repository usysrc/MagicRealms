local partition = function(text)
    local t = ""
    local newline
    for i=1, #text do
        local c = text:sub(i,i)
        if i%50 == 0 then
            newline = true
        end
        if newline and c == " " then
            t = t .. "\n"
            newline = false
        else
            t = t .. c
        end
    end
    return t
end

return {
    partition = partition
}