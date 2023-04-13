function generate_link_pose_function(robot::Robot, link_name::String;
                                    filename="out.jl",
                                    function_name="out_func",
                                    offset=[0.0, 0.0, 0.0])
    link = findbody(robot.mechanism, link_name)
    pt = Point3D(default_frame(link), offset[1], offset[2], offset[3])
    TF = transform_to_root(robot.state, link)
    t = transform(pt, TF).v
    R = rotation(TF)
    T = (t, R) 
    T = simplify.(T)
    func_string = string(build_function(T, robot.qvars, robot.vvars) )
    func_string = func_string[10:end]
    header = "function "*function_name
    func_string = header*func_string 
    func_string = replace(func_string, "Num"=>"")
    write(filename, func_string)
    return nothing
end

function generate_relative_link_pose_function(robot::Robot, from_link_name::String, to_link_name::String, filename::String)
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