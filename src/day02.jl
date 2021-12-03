module Day02

using AdventOfCode2021

function day02(data::Any = readInput(joinpath(@__DIR__, "..", "data", "day02.txt")))
    # part 1
    horizontal = 0
    depth = 0 
    for (command, value) in eachrow(data)
        if command == "forward"
            horizontal+=value
        elseif command == "down"
            depth+=value
        elseif command == "up"
            depth-=value
        else
            @show command
            throw(KeyError(command))
        end
    end
    part1 = depth*horizontal

    # part 2
    horizontal = 0
    aim = 0 
    depth = 0
    for (command, value) in eachrow(data)
        if command == "forward"
            horizontal+=value
            depth+=aim*value
        elseif command == "down"
            aim+=value
        elseif command == "up"
            aim-=value
        else
            @show command
            throw(KeyError(command))
        end
    end
    part2 = depth*horizontal
    return part1,part2
end
end # module
