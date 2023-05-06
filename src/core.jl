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

function break_expression(expression::String)
    expr = Meta.parse(expression)
    var_count = 0
    chunks = []    
    function break_subexpr(subexpr)
        if isa(subexpr, Expr)
            chunk_name = Symbol("chunk", var_count += 1)
            subexpr.args[2:end] = break_subexpr.(subexpr.args[2:end]) 
            push!(chunks,  :($chunk_name = $subexpr))
            return chunk_name
        else
            return subexpr
        end
    end    
    break_subexpr(expr) 
    return chunks 
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

# in-place
function generate_function2(expr, robot::Robot, 
            function_name::String, 
            filename::String)
    func_header="function $function_name(qvars, vvars)\n"
    outlength = length(expr)
    func_string = "\n    out = zeros($outlength)"
    for i=1:outlength
        elstr = "\n    out[$i] = "*string(expr[i])
        func_string *= elstr
    end
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
    gen_func_string = func_header*vars*"\n    "*func_string*"\n    return out\nend"
    write(filename, gen_func_string)
    nothing
end

# segmented expressions
function generate_function3(expr, robot::Robot, 
                            function_name::String, 
                            filename::String)
    func_header="function $function_name(qvars, vvars)\n"
    outlength = length(expr)
    func_string = "\n    out = zeros($outlength)"
    for i=1:outlength 
        e = expr[i]
        str = string(e)
        println("created string exp")
        chunks = break_expression(str)
        println("chunked string exp")
        # for ch in chunks 
        #     func_string *= "\n "*string(ch)
        # end
        func_string *= "\n    "
        func_string *= join(chunks, "\n    ")
        println("strung")
        func_string *= "\n out[$i] = "*string(chunks[end])
        println("appended")
    end  
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
    gen_func_string = func_header*vars*"\n    "*func_string*"\n    return out\nend"
    write(filename, gen_func_string)
    nothing

end