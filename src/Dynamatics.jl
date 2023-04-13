module Dynamatics

using Symbolics 
using Quaternions 
using RigidBodyDynamics

include("overloads.jl")
include("types.jl") 
include("core.jl")
include("kinematics.jl")
include("dynamics.jl")

# Core 
export create_robot

end
