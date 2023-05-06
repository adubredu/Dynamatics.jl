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
 

nq=31
nv=30
qvars = rand(nq)
vvars = rand(nv)
vars=""
function_name = "pose"
func_header="function $function_name(qvars, vvars)\n"
instring = read("test/test_str2.txt", String)
instring = replace(instring, "Symbolics.Num"=>"") 

expr = Meta.parse(instring)
outlength = length(expr)
func_string = "\n    out = zeros($outlength)"
for i=1:outlength 
    e = expr[i]
    chunks = break_expression(string(e))
    for ch in chunks 
        func_string *= "\n "*string(ch)
    end
    func_string *= "\n out[$i] = "*string(chunks[end])
end

# for i=1:outlength
#     elstr = "\n    out[$i] = "*string(expr[i])
#     func_string *= elstr
# end
for i = 1:nq  
    func_string = replace(func_string, "qvars[$i]"=>"qvars$i")
    vars = vars*"    qvars$i = qvars[$i]\n"
end
for i = 1:nv  
    func_string = replace(func_string, "vvars[$i]"=>"vvars$i")
    vars = vars*"    vvars$i = vvars[$i]\n"
end
gen_func_string = func_header*vars*"\n    "*func_string*"\n    return out\nend"
write("chunk1.jl", gen_func_string)
nothing