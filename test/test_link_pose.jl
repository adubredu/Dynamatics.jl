using Revise 
using Dynamatics 

urdfpath = "test/urdf/acrobot.urdf"
robot = create_robot(urdfpath)
T = generate_link_pose_function(robot, "lower_link"; filename="llfk.jl") 

function function_name(qvars, vvars)
    out = zeros(3)
    