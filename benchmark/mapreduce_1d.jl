include("common.jl")

n = 1_000_000


println("\n===\nBenchmarking mapreduce(identity, +) on $n UInt32 - Base vs. AK")
display(@benchmark @sb(Base.reduce(+, v, init=UInt32(0))) setup=(v = ArrayType(rand(UInt32(1):UInt32(100), n))))
display(@benchmark @sb(AK.reduce(+, v, init=UInt32(0))) setup=(v = ArrayType(rand(UInt32(1):UInt32(100), n))))


println("\n===\nBenchmarking mapreduce(identity, +) on $n Int64 - Base vs. AK")
display(@benchmark @sb(Base.reduce(+, v, init=Int64(0))) setup=(v = ArrayType(rand(Int64(1):Int64(100), n))))
display(@benchmark @sb(AK.reduce(+, v, init=Int64(0))) setup=(v = ArrayType(rand(Int64(1):Int64(100), n))))


println("\n===\nBenchmarking mapreduce(identity, +) on $n Float32 - Base vs. AK")
display(@benchmark @sb(Base.reduce(+, v, init=Float32(0))) setup=(v = ArrayType(rand(Float32, n))))
display(@benchmark @sb(AK.reduce(+, v, init=Float32(0))) setup=(v = ArrayType(rand(Float32, n))))


println("\n===\nBenchmarking mapreduce!(sin, +) on $n Float32 - Base vs. AK")
display(@benchmark @sb(Base.mapreduce(sin, +, v, init=Float32(0))) setup=(v = ArrayType(rand(Float32, n))))
display(@benchmark @sb(AK.mapreduce(sin, +, v, init=Float32(0))) setup=(v = ArrayType(rand(Float32, n))))

