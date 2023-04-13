struct Robot 
    mechanism::Mechanism 
    state::MechanismState 
    qvars::Symbolics.Arr{Symbolics.Num, 1}
    vvars::Symbolics.Arr{Symbolics.Num, 1}
end