using JuliaHub, Dates

JuliaHub.submit_job(
    JuliaHub.appbundle(@__DIR__, "main.jl"),
    ncpu=4, memory=4, nnodes=1,
    alias="Appbundle submit test",
    timelimit=Hour(1)
)
