# FasterMinMax.jl

### More performant `min, max, minmax` with simpler native code.  

> __IEEE754 conformance requires__
>  minmax(-0.0, 0.0) === minmax(0.0, -0.0) === (-0.0, 0.0)
>  This package quashes negative zeros (replaces them with 0.0).
>  In that respect alone, FasterMinMax is not IEEE754 compliant.

# versions that quash negative zeros
jsmax(a, b)    = signbit(b-a) ? a : b + (a-a)
jsmin(a, b)    = signbit(a-b) ? b : a + (b-b)
jsminmax(a, b) = (jsmin(a, b), jsmax(a, b))

const FastFloat = Union{Float32, Float64}

function min(a::T, b::T) where {T<:FastFloat}
    a_b = a-b
    signbit(a_b) ? a  : ifelse(isnan(b), a, b)
end

function max(a::T, b::T) where {T<:FastFloat}
    b_a = b-a
    signbit(b_a) ? a : ifelse(isnan(a), a, b)
end

minmax(a::T, b::T) where {T<:FastFloat} =
    (min(a, b), max(a, b))

# not IEEE754 compliant

min(a::T, b::T) where {T<:FastFloat} = 
    signbit(a - b) ? a : ifelse(b === -0.0, -0.0, b + (a - a))

max(a::T, b::T) where {T<:FastFloat} =
    signbit(b - a) ? a : b + (a - a)

minmax(a::T, b::T) where {T<:FastFloat} =
    (min(a, b), max(a, b))
    
