function out_func1(qvars, vvars)
    qvars1 = qvars[1]
    qvars2 = qvars[2]
    qvars3 = qvars[3]
    qvars4 = qvars[4]
    qvars5 = qvars[5]
    qvars6 = qvars[6]
    qvars7 = qvars[7]
    qvars8 = qvars[8]
    qvars9 = qvars[9]
    vvars1 = vvars[1]
    vvars2 = vvars[2]
    vvars3 = vvars[3]
    vvars4 = vvars[4]
    vvars5 = vvars[5]
    vvars6 = vvars[6]
    vvars7 = vvars[7]
    vvars8 = vvars[8]

    out = [0.5(qvars2*qvars3 - qvars1*qvars4) + qvars5 - (qvars1^2 + qvars2^2 - (qvars3^2) - (qvars4^2))*sin(qvars8) - 2.0(qvars1*qvars3 + qvars2*qvars4)*cos(qvars8), 0.25(qvars1^2 + qvars3^2 - (qvars2^2) - (qvars4^2)) + qvars6 - 2.0(qvars3*qvars4 - qvars1*qvars2)*cos(qvars8) - 2.0(qvars1*qvars4 + qvars2*qvars3)*sin(qvars8), 0.5(qvars1*qvars2 + qvars3*qvars4) + qvars7 - 2.0(qvars2*qvars4 - qvars1*qvars3)*sin(qvars8) - (qvars1^2 + qvars4^2 - (qvars2^2) - (qvars3^2))*cos(qvars8)]
    return out
end