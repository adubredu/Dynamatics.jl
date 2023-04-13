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
    robot = Robot(mechanism, state)
    return robot
end