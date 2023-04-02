import Base:tryparse, typemin, typemax, /, *
tryparse(::Type{Num}, val::AbstractString) = Num(parse(Float64, val))
typemin(::Type{Num})=Num(typemin(Float64))
typemax(::Type{Num})=Num(typemax(Float64))
/(q::Quaternion, x::Num) = Quaternion(q.s / x, q.v1 / x, q.v2 / x, q.v3 / x)
*(q::Quaternion, x::Num) = Quaternion(q.s * x, q.v1 * x, q.v2 * x, q.v3 * x)
*(x::Num, q::Quaternion) = q * x