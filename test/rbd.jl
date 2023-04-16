using RigidBodyDynamics

urdfpath = "test/urdf/digit/digit_model.urdf"
mechanism = parse_urdf(urdfpath; floating=true)
state = MechanismState(mechanism)
:Done
