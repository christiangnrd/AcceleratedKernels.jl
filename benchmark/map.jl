include("common.jl")

n = 1_000_000
f(x) = typeof(x)(2) * x


println("\n===\nBenchmarking map(x->2x) on $n UInt32 - Base vs. AK")
display(@benchmark @sb(Base.map(f, v)) setup=(v = ArrayType(rand(UInt32(1):UInt32(1_000_000), n))))
display(@benchmark @sb(AK.map(f, v)) setup=(v = ArrayType(rand(UInt32(1):UInt32(1_000_000), n))))


println("\n===\nBenchmarking map(x->2x) on $n Int64 - Base vs. AK")
display(@benchmark @sb(Base.map(f, v)) setup=(v = ArrayType(rand(Int64(1):Int64(1_000_000), n))))
display(@benchmark @sb(AK.map(f, v)) setup=(v = ArrayType(rand(Int64(1):Int64(1_000_000), n))))


println("\n===\nBenchmarking map(x->2x) on $n Float32 - Base vs. AK")
display(@benchmark @sb(Base.map(f, v)) setup=(v = ArrayType(rand(Float32, n))))
display(@benchmark @sb(AK.map(f, v)) setup=(v = ArrayType(rand(Float32, n))))


println("\n===\nBenchmarking map(x->sin(x)) on $n Float32 - Base vs. AK")
display(@benchmark @sb(Base.map(sin, v)) setup=(v = ArrayType(rand(Float32, n))))
display(@benchmark @sb(AK.map(sin, v)) setup=(v = ArrayType(rand(Float32, n))))

