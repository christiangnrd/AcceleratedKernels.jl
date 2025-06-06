@testset "truth" begin

    Random.seed!(0)

    # Simple correctness tests
    v = array_from_host(1:100)

    @test AK.any(x->x<0, v) === false
    @test AK.any(x->x>99, v) === true

    @test AK.all(x->x>0, v) === true
    @test AK.all(x->x<100, v) === false

    for _ in 1:100
        num_elems = rand(1:100_000)
        v = array_from_host(rand(Float32, num_elems))
        @test AK.any(x->x<0, v) === false
        @test AK.any(x->x<1, v) === true
        @test AK.all(x->x<1, v) === true
        @test AK.all(x->x<0, v) === false
    end

    for _ in 1:100
        num_elems = rand(1:100_000)
        v = array_from_host(rand(Float32, num_elems))
        @test AK.any(x->x<0, v) === false
        @test AK.any(x->x<1, v) === true
        @test AK.all(x->x<1, v) === true
        @test AK.all(x->x<0, v) === false
    end

    # Test the MapReduce algorithm which works on all platforms
    for _ in 1:100
        num_elems = rand(1:100_000)
        v = array_from_host(rand(Float32, num_elems))
        alg=AK.MapReduce(temp=similar(v, Bool), switch_below=100)
        @test AK.any(x->x<0, v; alg) === false
        @test AK.any(x->x<1, v; alg) === true
        @test AK.all(x->x<1, v; alg) === true
        @test AK.all(x->x<0, v; alg) === false
    end

    # Testing different settings
    v = array_from_host(rand(-5:5, 100_000))
    AK.any(x->x<5, v, max_tasks=2, min_elems=100, block_size=64)
    AK.all(x->x<5, v, max_tasks=2, min_elems=100, block_size=64)
end
