local function flypy_time_translator(input, seg)
    if (input == "ouj") then
       local cand = Candidate("time", seg.start, seg._end, os.date("%H:%M"), " ")
       cand.quality = 1
       yield(cand)
    end
end

return flypy_time_translator
