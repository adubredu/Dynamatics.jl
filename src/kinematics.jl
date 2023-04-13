function generate_link_pose_function(robot::Robot, link_name::String, 
                                    filename::String; offset=[0.0, 0.0, 0.0])
    link = findbody(robot.mechanism, link_name)
    t = Point3D(default_frame(link), offset[1], offset[2], offset[3]).v 
    R = rotation(transform_to_root(robot.state, link))
    return (t, R)
end

function generate_relative_link_pose_function(robot::Robot, from_link_name::String, to_link_name::String, filename::String)
end

function generate_geometric_jacobian_function(link_name::String, filename::String)
end

function generate_relative_geometric_jacobian_function(from_link_name::String, to_link_name::String, filename::String)
end

function generate_point_jacobian_function(link_name::String, filename::String)
end

function generate_relative_point_jacobian_function(from_link_name::String, to_link_name::String, filename::String)
end

function generate_center_of_mass_function(filename::String)
end