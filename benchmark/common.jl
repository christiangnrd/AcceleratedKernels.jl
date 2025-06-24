import AcceleratedKernels as AK
using KernelAbstractions

using BenchmarkTools
using Random
Random.seed!(0)

# does nothing for cpu backend
macro default_sync(ex)
    :($(esc(ex)))
end

# macro default_sync(ex)
#     quote
#         $(esc(ex))
#     end
# end

# Choose the Array backend:
#
# using CUDA
# const ArrayType = CuArray
# const var"@sb" = CUDA.var"@sync"
#
# using AMDGPU
# const ArrayType = ROCArray
# const var"@sb" = AMDGPU.var"@sync"
#
# using oneAPI
# const ArrayType = oneArray
# const var"@sb" = oneAPI.var"@sync"
#
# using Metal;
# const ArrayType = MtlArray
# const var"@sb" = Metal.var"@sync"
#
# using OpenCL
# const ArrayType = CLArray
# const var"@sb" = var"@default_sync" # Not sure how to sync
#
const ArrayType = Array
const var"@sb" = var"@default_sync"

println("Using ArrayType: ", ArrayType)


# To run all benchmarks
# begin
#     benches = filter(x -> x ∉ ["Manifest.toml", "Project.toml", "common.jl"], Base.readdir())
#     for b in benches
#         include(b)
#     end
# end
