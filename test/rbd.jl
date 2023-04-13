using RigidBodyDynamics

urdfpath = "test/urdf/acrobot.urdf"
mechanism = parse_urdf(urdfpath; floating=true)
state = MechanismState(mechanism)

