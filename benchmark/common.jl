import AcceleratedKernels as AK
using KernelAbstractions

using BenchmarkTools
using Random
Random.seed!(0)

# does nothing for cpu backend
macro default_sync(ex)
    :($(esc(ex)))
end

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
#     include("common.jl")
#     noinclude = ["Manifest.toml", "Project.toml", "common.jl"]
#     @isdefined(MtlArray) && append!(noinclude, ["sort.jl", "sortperm.jl"])
#     @isdefined(CuArray) && append!(noinclude, ["sortperm.jl"])
#     benches = filter(x -> x ∉ noinclude, Base.readdir())
#     for b in benches
#         include(b)
#     end
# end
