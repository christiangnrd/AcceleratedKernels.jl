include("common.jl")

acc_f(x, y) = sin(x) + cos(y)

if !(ArrayType <: Array)
    using GPUArrays
    GPUArrays.neutral_element(::typeof(acc_f), T) = T(0)
end

n = 1_000_000


println("\n===\nBenchmarking accumulate(+) on $n UInt32 - Base vs. AK")
display(@benchmark @sb(Base.accumulate(+, v, init=UInt32(0))) setup=(v = ArrayType(rand(UInt32(1):UInt32(100), n))))
display(@benchmark @sb(AK.accumulate(+, v, init=UInt32(0))) setup=(v = ArrayType(rand(UInt32(1):UInt32(100), n))))


println("\n===\nBenchmarking accumulate(+) on $n Int64 - Base vs. AK")
display(@benchmark @sb(Base.accumulate(+, v, init=Int64(0))) setup=(v = ArrayType(rand(Int64(1):Int64(100), n))))
display(@benchmark @sb(AK.accumulate(+, v, init=Int64(0))) setup=(v = ArrayType(rand(Int64(1):Int64(100), n))))


println("\n===\nBenchmarking accumulate(+) on $n Float32 - Base vs. AK")
display(@benchmark @sb(Base.accumulate(+, v, init=Float32(0))) setup=(v = ArrayType(rand(Float32, n))))
display(@benchmark @sb(AK.accumulate(+, v, init=Float32(0))) setup=(v = ArrayType(rand(Float32, n))))


println("\n===\nBenchmarking accumulate((x, y) -> sin(x) + cos(y)) on $n Float32 - Base vs. AK")
display(@benchmark @sb(Base.accumulate(acc_f, v, init=Float32(0))) setup=(v = ArrayType(rand(Float32, n))))
display(@benchmark @sb(AK.accumulate(acc_f, v, init=Float32(0), neutral=Float32(0))) setup=(v = ArrayType(rand(Float32, n))))

