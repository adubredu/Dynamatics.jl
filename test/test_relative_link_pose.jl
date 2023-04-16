using Revise 
using Dynamatics 

urdfpath = "test/urdf/digit/digit_model.urdf"
robot = create_robot(urdfpath)

from_link_name = "torso"
to_link_name = "left_toe_pitch"
T=generate_relative_link_pose_function(robot, from_link_name, 
                            to_link_name;
                            filename="test/gen/p_base_to_left_foot2.jl",
                            function_name="p_base_to_left_foot2")
:Done