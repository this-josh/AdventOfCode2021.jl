module AdventOfCode2021

using BenchmarkTools
using Printf
using DelimitedFiles

solvedDays = [1, 2]

# Include the source files:
for day in solvedDays
    ds = @sprintf("%02d", day)
    include(joinpath(@__DIR__, "day$ds.jl"))
end

function readInput(pth, args)
    return DelimitedFiles.readdlm(pth,args)
end


export readInput


# Export a function `dayXY` for each day:
for d in solvedDays
    global ds = @sprintf("day%02d.txt", d)
    global modSymbol = Symbol(@sprintf("Day%02d", d))
    global dsSymbol = Symbol(@sprintf("day%02d", d))

    @eval begin
        input_path = joinpath(@__DIR__, "..", "data", ds)
        function $dsSymbol(input::String = readInput($d))
            return AdventOfCode2021.$modSymbol.$dsSymbol(input)
        end
        export $dsSymbol
    end
end

# Benchmark a list of different problems:
function benchmark(days=solvedDays)
    results = []
    for day in days
        modSymbol = Symbol(@sprintf("Day%02d", day))
        fSymbol = Symbol(@sprintf("day%02d", day))
        input = readInput(joinpath(@__DIR__, "..", "data", @sprintf("day%02d.txt", day)))
        @eval begin
            bresult = @benchmark(AdventOfCode2021.$modSymbol.$fSymbol($input))
        end
        push!(results, (day, time(bresult), memory(bresult)))
    end
    return results
end

# Write the benchmark results into a markdown string:
function _to_markdown_table(bresults)
    header = "| Day | Time | Allocated memory |\n" *
             "|----:|-----:|-----------------:|"
    lines = [header]
    for (d, t, m) in bresults
        ds = string(d)
        ts = BenchmarkTools.prettytime(t)
        ms = BenchmarkTools.prettymemory(m)
        push!(lines, "| $ds | $ts | $ms |")
    end
    return join(lines, "\n")
end

end # module
