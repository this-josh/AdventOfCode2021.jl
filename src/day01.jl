module Day01

using AdventOfCode2021
using IterTools

function num_increasing(arr)
    arr_shift = arr[2:end]
    diff = arr[1:end-1]-arr_shift
    return count(ii->(ii<0), diff)
end

function day01(data::Any = readInput(joinpath(@__DIR__, "..", "data", "day01.txt")))
    # part 1
    part1 = num_increasing(data)
    # part 2
    windows = zeros(size(data)[1])
    for (idx, window) in enumerate(IterTools.partition(data, 3,1))
        windows[idx]=  sum(window)
    end
    part2 = num_increasing(windows)

    return part1, part2
end

end # module
