mutable struct RandomOCClassifier <: OCClassifier
    data
    outlier_bias
    adjust_K::Bool
    kernel_fct::Kernel
    RandomOCClassifier(data) = new(data, 0.1, false, MLKernels.GaussianKernel(2.0))
    RandomOCClassifier(data, pools::Vector) = RandomOCClassifier(data)
    RandomOCClassifier(data, outlier_bias::Float64) = new(data, outlier_bias, false, MLKernels.GaussianKernel(2.0))
    RandomOCClassifier(data, outlier_bias::Float64, pools::Vector) = RandomOCClassifier(data, outlier_bias)
end

set_adjust_K!(model::RandomOCClassifier, adjust_K::Bool) = nothing

get_model_params(model::RandomOCClassifier) = (:Ϟ => 0.42, :param2 => 5)

function fit!(model::RandomOCClassifier, solver)
    debug(LOGGER, "[FIT] $(typeof(model)) always returns :Optimal.")
    return JuMP.MathOptInterface.OPTIMAL
end

function predict(model::RandomOCClassifier, target::Array{T,2}) where T <: Real
    rand(size(target, 2)) * 2 .- model.outlier_bias * 2
end

initialize!(model::RandomOCClassifier, strategy::InitializationStrategy) = nothing

get_kernel(model::RandomOCClassifier) = model.kernel_fct

invalidate_solution!(model::RandomOCClassifier) = nothing

set_pools!(model::RandomOCClassifier, pools::Vector{Symbol}) = nothing
set_pools!(model::RandomOCClassifier, pools::Dict{Symbol, Vector{Int}}) = nothing

function set_data!(model::RandomOCClassifier, data::Array{T, 2}) where T <: Real
    model.data = data
    return nothing
end

update_with_feedback!(model::RandomOCClassifier, new_data, new_pools::Vector{Symbol}, query_ids::Vector{Int},
    old_idx_remaining::Vector{Int},
    new_idx_remaining::Vector{Int}) = nothing
