function generate_link_pose_function(robot::Robot, link_name::String;
                                    filename="out.jl",
                                    function_name="out_func",
                                    offset=[0.0, 0.0, 0.0],
                                    write_to_file=true)
    link = findbody(robot.mechanism, link_name)
    pt = Point3D(default_frame(link), offset...)
    TF = transform_to_root(robot.state, link)
    t = transform(pt, TF).v
    R = rotation(TF)
    T = t 
    # T = simplify.(T)
    if write_to_file
        # func_string = string(build_function(T, robot.qvars, robot.vvars) )
        # func_string = func_string[10:end]
        # header = "function "*function_name
        # func_string = header*func_string 
        # func_string = replace(func_string, "Num"=>"")
        # write(filename, func_string)
        generate_function(T, robot, function_name, filename)
    end
    return T
end

function generate_relative_link_pose_function(robot::Robot, from_link_name::String, 
                            to_link_name::String;
                            filename="out.jl",
                            function_name="out_func",
                            offset=[0.0,0.0,0.0],
                            write_to_file=true)
    from_link = findbody(robot.mechanism, from_link_name)
    to_link = findbody(robot.mechanism, to_link_name)
    pt = Point3D(default_frame(to_link), offset...) 
    TF_from = transform_to_root(robot.state, from_link)
    TF_to = transform_to_root(robot.state, to_link)
    TF = inv(TF_from)*TF_to
    t = transform(pt, TF).v
    R = rotation(TF)
    T = t 
    if write_to_file
        # func_string = string(build_function(T, robot.qvars, robot.vvars;parallel=Symbolics.ShardedForm(80, 4))[2] )
        # func_string = func_string[10:end]
        # header = "function "*function_name*"_helper"
        # func_string = header*func_string 
        # func_string = replace(func_string, "Num"=>"")
        # func_string = replace(func_string, "Symbolics."=>"")
        # # func_string = replace(func_string, "(^)"=>"\n   (^)")
        # gen_func_string = "function "*function_name
        # gen_body_string = "(qvars, vvars)\n   out=zeros(3)\n   $(function_name)_helper(out, qvars, vvars)\n   return out\nend"
        # gen_func_string = func_string*"\n\n"*gen_func_string*gen_body_string
        # write(filename, gen_func_string)
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