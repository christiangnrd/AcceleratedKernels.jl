include("common.jl")

n1 = 3
n2 = 1_000_000


println("\n===\nBenchmarking mapreduce(identity, +, dims=1) on $n1 × $n2 UInt32 - Base vs. AK")
display(@benchmark @sb(Base.reduce(+, v, init=UInt32(0), dims=1)) setup=(v = ArrayType(rand(UInt32(1):UInt32(100), n1, n2))))
display(@benchmark @sb(AK.reduce(+, v, init=UInt32(0), dims=1)) setup=(v = ArrayType(rand(UInt32(1):UInt32(100), n1, n2))))

println("\n===\nBenchmarking mapreduce(identity, +, dims=2) on $n1 × $n2 UInt32 - Base vs. AK")
display(@benchmark @sb(Base.reduce(+, v, init=UInt32(0), dims=2)) setup=(v = ArrayType(rand(UInt32(1):UInt32(100), n1, n2))))
display(@benchmark @sb(AK.reduce(+, v, init=UInt32(0), dims=2)) setup=(v = ArrayType(rand(UInt32(1):UInt32(100), n1, n2))))




println("\n===\nBenchmarking mapreduce(identity, +, dims=1) on $n1 × $n2 Int64 - Base vs. AK")
display(@benchmark @sb(Base.reduce(+, v, init=Int64(0), dims=1)) setup=(v = ArrayType(rand(Int64(1):Int64(100), n1, n2))))
display(@benchmark @sb(AK.reduce(+, v, init=Int64(0), dims=1)) setup=(v = ArrayType(rand(Int64(1):Int64(100), n1, n2))))

println("\n===\nBenchmarking mapreduce(identity, +, dims=2) on $n1 × $n2 Int64 - Base vs. AK")
display(@benchmark @sb(Base.reduce(+, v, init=Int64(0), dims=2)) setup=(v = ArrayType(rand(Int64(1):Int64(100), n1, n2))))
display(@benchmark @sb(AK.reduce(+, v, init=Int64(0), dims=2)) setup=(v = ArrayType(rand(Int64(1):Int64(100), n1, n2))))




println("\n===\nBenchmarking mapreduce(identity, +, dims=1) on $n1 × $n2 Float32 - Base vs. AK")
display(@benchmark @sb(Base.reduce(+, v, init=Float32(0), dims=1)) setup=(v = ArrayType(rand(Float32, n1, n2))))
display(@benchmark @sb(AK.reduce(+, v, init=Float32(0), dims=1)) setup=(v = ArrayType(rand(Float32, n1, n2))))

println("\n===\nBenchmarking mapreduce(identity, +, dims=2) on $n1 × $n2 Float32 - Base vs. AK")
display(@benchmark @sb(Base.reduce(+, v, init=Float32(0), dims=2)) setup=(v = ArrayType(rand(Float32, n1, n2))))
display(@benchmark @sb(AK.reduce(+, v, init=Float32(0), dims=2)) setup=(v = ArrayType(rand(Float32, n1, n2))))




println("\n===\nBenchmarking mapreduce(sin, +, dims=1) on $n1 × $n2 Float32 - Base vs. AK")
display(@benchmark @sb(Base.mapreduce(sin, +, v, init=Float32(0), dims=1)) setup=(v = ArrayType(rand(Float32, n1, n2))))
display(@benchmark @sb(AK.mapreduce(sin, +, v, init=Float32(0), dims=1)) setup=(v = ArrayType(rand(Float32, n1, n2))))

println("\n===\nBenchmarking mapreduce(sin, +, dims=2) on $n1 × $n2 Float32 - Base vs. AK")
display(@benchmark @sb(Base.mapreduce(sin, +, v, init=Float32(0), dims=2)) setup=(v = ArrayType(rand(Float32, n1, n2))))
display(@benchmark @sb(AK.mapreduce(sin, +, v, init=Float32(0), dims=2)) setup=(v = ArrayType(rand(Float32, n1, n2))))
