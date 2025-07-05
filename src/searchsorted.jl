# Taken from julia.Base to ensure consistent results with the Base CPU version
# License is MIT: https://julialang.org/license
function _searchsortedfirst(v, x, lo::T, hi::T, comp) where T<:Integer
    hi = hi + T(1)
    len = hi - lo
    @inbounds while len != 0x0
        half_len = len >>> 0x1
        m = lo + half_len
        if comp(v[m], x)
            lo = m + 0x1
            len -= half_len + 0x1
        else
            hi = m
            len = half_len
        end
    end
    return lo
end


function _searchsortedfirst(v, x, lo::T, hi::T, ord::Base.Order.Ordering) where T<:Integer
    hi = hi + T(1)
    len = hi - lo
    @inbounds while len != 0x0
        half_len = len >>> 0x1
        m = lo + half_len
        if Base.Order.lt(ord, v[m], x)
            lo = m + 0x1
            len -= half_len + 0x1
        else
            hi = m
            len = half_len
        end
    end
    return lo
end


function _searchsortedlast(v, x, lo::T, hi::T, comp) where T<:Integer
    u = T(1)
    lo = lo - u
    hi = hi + u
    @inbounds while lo < hi - u
        m = lo + ((hi - lo) >>> 0x1)
        if comp(x, v[m])
            hi = m
        else
            lo = m
        end
    end
    return lo
end


function _searchsortedlast(v, x, lo::T, hi::T, ord::Base.Order.Ordering) where T<:Integer
    u = T(1)
    lo = lo - u
    hi = hi + u
    @inbounds while lo < hi - u
        m = lo + ((hi - lo) >>> 0x1)
        if Base.Order.lt(ord, x, v[m])
            hi = m
        else
            lo = m
        end
    end
    return lo
end


"""
    searchsortedfirst!(
        ix::AbstractVector,
        v::AbstractVector,
        x::AbstractVector,
        backend::Backend=get_backend(x);

        by=identity, lt=isless, rev::Bool=false,

        # CPU settings
        max_tasks::Int=Threads.nthreads(),
        min_elems::Int=1000,
        prefer_threads::Bool=true,

        # GPU settings
        block_size::Int=256,
    )

Equivalent to applying `searchsortedfirst!` element-wise to each element of `x`. The CPU and GPU
settings are the same as for [`foreachindex`](@ref).
"""
function searchsortedfirst!(
    ix::AbstractVector,
    v::AbstractVector,
    x::AbstractVector,
    backend::Backend=get_backend(x);

    by=identity, lt=isless, rev::Bool=false,

    # CPU settings with different default from `foreachindex`
    min_elems::Int=1000,

    kwargs...
)
    # Simple sanity checks
    @argcheck length(ix) == length(x)

    # Construct comparator
    ord = Base.Order.ord(lt, by, rev)
    comp = (x, y) -> Base.Order.lt(ord, x, y)

    foreachindex(
        x, backend;
        min_elems, kwargs...
    ) do i
        @inbounds ix[i] = _searchsortedfirst(v, x[i], firstindex(v), lastindex(v), comp)
    end
end


"""
    searchsortedfirst(
        v::AbstractVector,
        x::AbstractVector,
        backend::Backend=get_backend(x);

        by=identity, lt=isless, rev::Bool=false,

        # CPU settings
        max_tasks::Int=Threads.nthreads(),
        min_elems::Int=1000,
        prefer_threads::Bool=true,

        # GPU settings
        block_size::Int=256,
    )

Equivalent to applying `searchsortedfirst` element-wise to each element of `x`. The CPU and GPU
settings are the same as for [`foreachindex`](@ref).
"""
function searchsortedfirst(
    v::AbstractVector,
    x::AbstractVector,
    backend::Backend=get_backend(x);
    kwargs...
)
    ix = similar(x, Int)
    searchsortedfirst!(
        ix, v, x, backend;
        kwargs...
    )
    ix
end


"""
    searchsortedlast!(
        ix::AbstractVector,
        v::AbstractVector,
        x::AbstractVector,
        backend::Backend=get_backend(x);

        by=identity, lt=isless, rev::Bool=false,

        # CPU settings
        max_tasks::Int=Threads.nthreads(),
        min_elems::Int=1000,
        prefer_threads::Bool=true,

        # GPU settings
        block_size::Int=256,
    )

Equivalent to applying `searchsortedlast!` element-wise to each element of `x`. The CPU and GPU
settings are the same as for [`foreachindex`](@ref).
"""
function searchsortedlast!(
    ix::AbstractVector,
    v::AbstractVector,
    x::AbstractVector,
    backend::Backend=get_backend(x);

    by=identity, lt=isless, rev::Bool=false,

    # CPU settings with different default from `foreachindex`
    min_elems::Int=1000,

    kwargs...
)
    # Simple sanity checks
    @argcheck length(ix) == length(x)

    # Construct comparator
    ord = Base.Order.ord(lt, by, rev)
    comp = (x, y) -> Base.Order.lt(ord, x, y)

    foreachindex(
        x, backend;
        min_elems, kwargs...
    ) do i
        @inbounds ix[i] = _searchsortedlast(v, x[i], firstindex(v), lastindex(v), comp)
    end
end


"""
    searchsortedlast(
        v::AbstractVector,
        x::AbstractVector,
        backend::Backend=get_backend(x);

        by=identity, lt=isless, rev::Bool=false,

        # CPU settings
        max_tasks::Int=Threads.nthreads(),
        min_elems::Int=1000,
        prefer_threads::Bool=true,

        # GPU settings
        block_size::Int=256,
    )

Equivalent to applying `searchsortedlast` element-wise to each element of `x`. The CPU and GPU
settings are the same as for [`foreachindex`](@ref).
"""
function searchsortedlast(
    v::AbstractVector,
    x::AbstractVector,
    backend::Backend=get_backend(x);
    kwargs...
)
    ix = similar(x, Int)
    searchsortedlast!(
        ix, v, x, backend;
        kwargs...
    )
    ix
end
