function create_robot(urdfpath::String; floating=true)
    mechanism = parse_urdf(urdfpath; scalar_type=Num, floating=floating)
    state = MechanismState(mechanism)
    q = configuration(state)
    v = velocity(state)
    Nq = num_positions(state)
    Nv = num_velocities(state)
    @variables qvars[1:Nq]
    @variables vvars[1:Nv]
    for i=1:Nq q[i] = qvars[i] end 
    for i=1:Nv v[i] = vvars[i] end 
    robot = Robot(mechanism, state, qvars, vvars)
    return robot
end

function generate_function(expr, robot::Robot, 
                        function_name::String, 
                        filename::String)
    func_header="function $function_name(qvars, vvars)\n"
    func_string = string(expr)
    func_string = replace(func_string, "Symbolics.Num"=>"")
    nq = num_positions(robot.state)
    nv = num_velocities(robot.state)
    vars = ""
    for i = 1:nq  
        func_string = replace(func_string, "qvars[$i]"=>"qvars$i")
        vars = vars*"    qvars$i = qvars[$i]\n"
    end
    for i = 1:nv  
        func_string = replace(func_string, "vvars[$i]"=>"vvars$i")
        vars = vars*"    vvars$i = vvars[$i]\n"
    end
    gen_func_string = func_header*vars*"\n    out = "*func_string*"\n    return out\nend"
    write(filename, gen_func_string)
    nothing
end