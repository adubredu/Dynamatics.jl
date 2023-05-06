using Revise 
using Dynamatics 

# urdfpath = "test/urdf/acrobot.urdf"
# robot = create_robot(urdfpath)

urdfpath = "test/urdf/digit/digit_model.urdf"
robot = create_robot(urdfpath)
T = generate_link_pose_function(robot, "left_toe_pitch"; filename="digitlegchunk1.jl", function_name="dchunkpose") 

:Done
    