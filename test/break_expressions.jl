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
# using MacroTools
# function break_expression(expression::String)
#     expr = Meta.parse(expression)
#     var_count = Ref(0)
#     chunks = []    
#     function break_subexpr!(subexpr)
#         if isa(subexpr, Expr)
#             chunk_name = Symbol("chunk", var_count[] += 1)
#             new_subexpr = MacroTools.prewalk(break_subexpr!, subexpr)
#             push!(chunks,  :($chunk_name = $new_subexpr))
#             subexpr.head = :call
#             subexpr.args[1] = chunk_name
#             return chunk_name 
#         end
#     end    
#     break_subexpr!(expr) 
#     return chunks 
# end

# function break_expression(expression::String)
#     expr = Meta.parse(expression)
#     var_count = Ref(0)
#     chunks = []

#     stack = [expr]
    
#     while !isempty(stack)
#         subexpr = pop!(stack)
        
#         if isa(subexpr, Expr)
#             for i in 2:length(subexpr.args)
#                 arg = subexpr.args[i]
#                 if isa(arg, Expr)
#                     push!(stack, arg)
#                 else
#                     chunk_name = Symbol("chunk", var_count[] += 1)
#                     new_chunk = :($chunk_name = $arg)
#                     push!(chunks, (chunk_name, new_chunk))
#                     subexpr.args[i] = chunk_name
#                 end
#             end
#         end
#     end

#     push!(chunks, (expr.args[1], expr))
#     return chunks
# end

# Example expression
# expression = "(a + b) * (c - d) / e"
expression = read("test/exp1.txt", String) 
# Variables to be used in the expression
a = 1
b = 2
c = 3
d = 4
e = 5

# Break down the expression
chunks = break_expression(expression)

# Combine the broken down expression
# eval(broken_expression)

# Print the result
# println("The result is: ", chunk1)