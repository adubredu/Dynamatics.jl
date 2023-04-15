function generate_link_pose_function(robot::Robot, link_name::String;
                                    filename="out.jl",
                                    function_name="out_func",
                                    offset=[0.0, 0.0, 0.0],
                                    write_to_file=true,
                                    return_val=:position)
    link = findbody(robot.mechanism, link_name)
    pt = Point3D(default_frame(link), offset...)
    TF = transform_to_root(robot.state, link)
    t = transform(pt, TF).v
    R = rotation(TF)
    T = return_val == :orientation ? R : t  
    if write_to_file 
        generate_function(T, robot, function_name, filename)
    end
    return T
end

function generate_relative_link_pose_function(robot::Robot, from_link_name::String, 
                            to_link_name::String;
                            filename="out.jl",
                            function_name="out_func",
                            offset=[0.0,0.0,0.0],
                            write_to_file=true,
                            return_val=:position)
    from_link = findbody(robot.mechanism, from_link_name)
    to_link = findbody(robot.mechanism, to_link_name)
    pt = Point3D(default_frame(to_link), offset...) 
    TF_from = transform_to_root(robot.state, from_link)
    TF_to = transform_to_root(robot.state, to_link)
    TF = inv(TF_from)*TF_to
    t = transform(pt, TF).v
    R = rotation(TF)
    T = return_val == :orientation ? R : t
    if write_to_file 
        generate_function(T, robot, function_name, filename)
    end
    return T
end

function generate_geometric_jacobian_function(robot::Robot, link_name::String, filename::String)
end

function generate_relative_geometric_jacobian_function(robot::Robot, from_link_name::String, to_link_name::String, filename::String)
end

function generate_point_jacobian_function(robot::Robot, link_name::String, filename::String)
end

function generate_relative_point_jacobian_function(robot::Robot, from_link_name::String, to_link_name::String, filename::String)
end

function generate_center_of_mass_function(robot::Robot, filename::String)
end