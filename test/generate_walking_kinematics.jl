using Revise 
using Dynamatics 

urdfpath = "test/urdf/digit/digit_model.urdf"
robot = create_robot(urdfpath)

# Position vectors
from_link_name = "torso"
to_link_name = "left_toe_pitch"
T=generate_relative_link_pose_function(robot, from_link_name, 
                            to_link_name;
                            filename="test/gen/p_base_to_left_foot.jl",
                            function_name="p_base_to_left_foot",
                            return_val=:position)

from_link_name = "torso"
to_link_name = "right_toe_pitch"
T=generate_relative_link_pose_function(robot, from_link_name, 
                            to_link_name;
                            filename="test/gen/p_base_to_right_foot.jl",
                            function_name="p_base_to_right_foot",
                            return_val=:position)   
                            
                            
from_link_name = "left_toe_pitch"
to_link_name = "torso"
T=generate_relative_link_pose_function(robot, from_link_name, 
                            to_link_name;
                            filename="test/gen/p_left_foot_to_base.jl",
                            function_name="p_left_foot_to_base",
                            return_val=:position)

from_link_name = "right_toe_pitch"
to_link_name = "torso"
T=generate_relative_link_pose_function(robot, from_link_name, 
                            to_link_name;
                            filename="test/gen/p_right_foot_to_base.jl",
                            function_name="p_right_foot_to_base",
                            return_val=:position)

# Rotation matrices 
T=generate_relative_link_pose_function(robot, from_link_name, 
                            to_link_name;
                            filename="test/gen/R_base_to_left_foot.jl",
                            function_name="R_base_to_left_foot",
                            return_val=:orientation)

from_link_name = "torso"
to_link_name = "right_toe_pitch"
T=generate_relative_link_pose_function(robot, from_link_name, 
                            to_link_name;
                            filename="test/gen/R_base_to_right_foot.jl",
                            function_name="R_base_to_right_foot",
                            return_val=:orientation)   
                            
                            
from_link_name = "left_toe_pitch"
to_link_name = "torso"
T=generate_relative_link_pose_function(robot, from_link_name, 
                            to_link_name;
                            filename="test/gen/R_left_foot_to_base.jl",
                            function_name="R_left_foot_to_base",
                            return_val=:orientation)

from_link_name = "right_toe_pitch"
to_link_name = "torso"
T=generate_relative_link_pose_function(robot, from_link_name, 
                            to_link_name;
                            filename="test/gen/R_right_foot_to_base.jl",
                            function_name="R_right_foot_to_base",
                            return_val=:orientation)
:Done