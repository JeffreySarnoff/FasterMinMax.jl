module FasterMinMax

export unsafe_min, unsafe_max, unsafe_minmax, unsafe_maxmin,
       minnum, maxnum, minmaxnum, maxminnum,
       minmag, maxmag, minmaxmag, maxminmag,

const FastFloat = Union{Float32, Float64}

function unsafe_min(x::T, y::T) where {T<:FastFloat}
    x_y = x - y
    (signbit(x_y) || isnan(x)) ? x : y
end

function unsafe_max(x::T, y::T) where {T<:FastFloat}
    y_x = y - x
    (signbit(y_x) || isnan(x)) ? x : y
end

function unsafe_minmax(x::T, y::T) where {T<:FastFloat} 
    (unsafe_min(x,y), unsafe_max(x,y))
end

function unsafe_maxmin(x::T, y::T) where {T<:FastFloat}
    (signbit(y-x) || isnan(x)) ? (x,y) : (y,x)
end

function minnum(x::T, y::T) where {T<:FastFloat}
end

function maxnum(x::T, y::T) where {T<:FastFloat}
end

function minmaxnum(x::T, y::T) where {T<:FastFloat}
end

function maxminnum(x::T, y::T) where {T<:FastFloat}
end

function minmag(x::T, y::T) where {T<:FastFloat}
end

function maxmag(x::T, y::T) where {T<:FastFloat}
end

function minmaxmag(x::T, y::T) where {T<:FastFloat}
end

function maxminmag(x::T, y::T) where {T<:FastFloat}
end

end  # FasterMinMax
