include("common.jl")

acc_f(x, y) = sin(x) + cos(y)

if !(ArrayType <: Array)
    using GPUArrays
    GPUArrays.neutral_element(::typeof(acc_f), T) = T(0)
end

n1 = 3
n2 = 1_000_000


println("\n===\nBenchmarking accumulate(+, dims=1) on $n1 × $n2 UInt32 - Base vs. AK")
display(@benchmark @sb(Base.accumulate(+, v, init=UInt32(0), dims=1)) setup=(v = ArrayType(rand(UInt32(1):UInt32(100), n1, n2))))
display(@benchmark @sb(AK.accumulate(+, v, init=UInt32(0), dims=1)) setup=(v = ArrayType(rand(UInt32(1):UInt32(100), n1, n2))))

println("\n===\nBenchmarking accumulate(+, dims=2) on $n1 × $n2 UInt32 - Base vs. AK")
display(@benchmark @sb(Base.accumulate(+, v, init=UInt32(0), dims=2)) setup=(v = ArrayType(rand(UInt32(1):UInt32(100), n1, n2))))
display(@benchmark @sb(AK.accumulate(+, v, init=UInt32(0), dims=2)) setup=(v = ArrayType(rand(UInt32(1):UInt32(100), n1, n2))))




println("\n===\nBenchmarking accumulate(+, dims=1) on $n1 × $n2 Int64 - Base vs. AK")
display(@benchmark @sb(Base.accumulate(+, v, init=Int64(0), dims=1)) setup=(v = ArrayType(rand(Int64(1):Int64(100), n1, n2))))
display(@benchmark @sb(AK.accumulate(+, v, init=Int64(0), dims=1)) setup=(v = ArrayType(rand(Int64(1):Int64(100), n1, n2))))

println("\n===\nBenchmarking accumulate(+, dims=2) on $n1 × $n2 Int64 - Base vs. AK")
display(@benchmark @sb(Base.accumulate(+, v, init=Int64(0), dims=2)) setup=(v = ArrayType(rand(Int64(1):Int64(100), n1, n2))))
display(@benchmark @sb(AK.accumulate(+, v, init=Int64(0), dims=2)) setup=(v = ArrayType(rand(Int64(1):Int64(100), n1, n2))))




println("\n===\nBenchmarking accumulate(+, dims=1) on $n1 × $n2 Float32 - Base vs. AK")
display(@benchmark Base.accumulate(+, v, init=Float32(0), dims=1) setup=(v = ArrayType(rand(Float32, n1, n2))))
display(@benchmark AK.accumulate(+, v, init=Float32(0), dims=1) setup=(v = ArrayType(rand(Float32, n1, n2))))

println("\n===\nBenchmarking accumulate(+, dims=2) on $n1 × $n2 Float32 - Base vs. AK")
display(@benchmark Base.accumulate(+, v, init=Float32(0), dims=2) setup=(v = ArrayType(rand(Float32, n1, n2))))
display(@benchmark AK.accumulate(+, v, init=Float32(0), dims=2) setup=(v = ArrayType(rand(Float32, n1, n2))))




println("\n===\nBenchmarking accumulate((x, y) -> sin(x) + cos(y)), dims=1) on $n1 × $n2 Float32 - Base vs. AK")
display(@benchmark Base.accumulate(acc_f, v, init=Float32(0), dims=1) setup=(v = ArrayType(rand(Float32, n1, n2))))
display(@benchmark AK.accumulate(acc_f, v, init=Float32(0), neutral=Float32(0), dims=1) setup=(v = ArrayType(rand(Float32, n1, n2))))

println("\n===\nBenchmarking accumulate((x, y) -> sin(x) + cos(y)), dims=2) on $n1 × $n2 Float32 - Base vs. AK")
display(@benchmark Base.accumulate(acc_f, v, init=Float32(0), dims=2) setup=(v = ArrayType(rand(Float32, n1, n2))))
display(@benchmark AK.accumulate(acc_f, v, init=Float32(0), neutral=Float32(0), dims=2) setup=(v = ArrayType(rand(Float32, n1, n2))))
