include("common.jl")

n = 1_000_000
ix = ArrayType(ones(Int, n))


# Memory-bound, so not much improvement expected when multithreading
println("\n===\nBenchmarking sortperm! on $n UInt32 - Base vs. AK")
display(@benchmark @sb(Base.sortperm!($ix, v)) setup=(v = ArrayType(rand(UInt32(1):UInt32(1_000_000), n))))
display(@benchmark @sb(AK.sortperm!($ix, v)) setup=(v = ArrayType(rand(UInt32(1):UInt32(1_000_000), n))))


# Lexicographic sorting of tuples - more complex comparators
ntup = 5
println("\n===\nBenchmarking sortperm! on $n NTuple{$ntup, Int64} - Base vs. AK")
display(@benchmark @sb(Base.sortperm!($ix, v)) setup=(v = ArrayType(rand(NTuple{ntup, Int64}, n))))
display(@benchmark @sb(AK.sortperm!($ix, v)) setup=(v = ArrayType(rand(NTuple{ntup, Int64}, n))))


# Memory-bound again
println("\n===\nBenchmarking sortperm! on $n Float32 - Base vs. AK")
display(@benchmark @sb(Base.sortperm!($ix, v)) setup=(v = ArrayType(rand(Float32, n))))
display(@benchmark @sb(AK.sortperm!($ix, v)) setup=(v = ArrayType(rand(Float32, n))))


# More complex by=sin
println("\n===\nBenchmarking sortperm!(by=sin) on $n Float32 - Base vs. AK")
display(@benchmark @sb(Base.sortperm!($ix, v, by=sin)) setup=(v = ArrayType(rand(Float32, n))))
display(@benchmark @sb(AK.sortperm!($ix, v, by=sin)) setup=(v = ArrayType(rand(Float32, n))))

