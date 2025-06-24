include("common.jl")

n = 1_000_000


# Memory-bound, so not much improvement expected when multithreading
println("\n===\nBenchmarking sort! on $n UInt32 - Base vs. AK")
display(@benchmark @sb(Base.sort!(v)) setup=(v = ArrayType(rand(UInt32(1):UInt32(1_000_000), n))))
display(@benchmark @sb(AK.sort!(v)) setup=(v = ArrayType(rand(UInt32(1):UInt32(1_000_000), n))))


# Lexicographic sorting of tuples - more complex comparators
ntup = 5
println("\n===\nBenchmarking sort! on $n NTuple{$ntup, Int64} - Base vs. AK")
display(@benchmark @sb(Base.sort!(v)) setup=(v = ArrayType(rand(NTuple{ntup, Int64}, n))))
display(@benchmark @sb(AK.sort!(v)) setup=(v = ArrayType(rand(NTuple{ntup, Int64}, n))))


# Memory-bound again
println("\n===\nBenchmarking sort! on $n Float32 - Base vs. AK")
display(@benchmark @sb(Base.sort!(v)) setup=(v = ArrayType(rand(Float32, n))))
display(@benchmark @sb(AK.sort!(v)) setup=(v = ArrayType(rand(Float32, n))))


# More complex by=sin
println("\n===\nBenchmarking sort!(by=sin) on $n Float32 - Base vs. AK")
display(@benchmark @sb(Base.sort!(v, by=sin)) setup=(v = ArrayType(rand(Float32, n))))
display(@benchmark @sb(AK.sort!(v, by=sin)) setup=(v = ArrayType(rand(Float32, n))))

