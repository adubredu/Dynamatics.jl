nq=31
nv=30
qvars = rand(nq)
vvars = rand(nv)
vars=""
function_name = "pose"
func_header="function $function_name(qvars, vvars)\n"
func_string = read("test/test_str2.txt", String)

for i = 1:nq 
    global func_string, vars
    func_string = replace(func_string, "qvars[$i]"=>"qvars$i")
    vars = vars*"    qvars$i = qvars[$i]\n"
end
for i = 1:nv 
    global func_string, vars
    func_string = replace(func_string, "vvars[$i]"=>"vvars$i")
    vars = vars*"    vvars$i = vvars[$i]\n"
end

gen_func_string = func_header*vars*"\n    out = "*func_string*"\n    return out\nend"
write("testout2.jl", gen_func_string)

:Done