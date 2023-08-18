using Plots
using PlotThemes
using StatsBase
##############################################
# Code for plotting pdf (prob density funcion) of logistic map when chaotic (r=4)
# and the line function found 1/pi(x*1-x). Also, seeing that what random variable
# would give the similar results when transformed 
##############################################

function f_map(r,n) #value of r and number of iterations

    #x = LinRange(0, 1, n)#[i*10^(-n) for i=1:10^n]
    x = rand(Uniform(0,1))
    x_vals = zeros(n)
    x_vals[1] = x
    for i=1:n
        x = r*(x - x.*x)
        x_vals[i] = x
    end
    return x_vals
end


log_dat = f_map(4,10^6)


#################################################

histogram(log_dat,normalize=true,alpha=0.3)

t = 0:0.01:1

pdf_log = @. 1/(pi*sqrt(t*(1-t)))
pdf_sin = @. (sin(pi*(0.5 - t)))^2

plot( t , pdf_log)
plot!( t , pdf_sin)


savefig("hist_log_dat.png")


##################################################

y = Uniform(0,1)

rd_uni = rand(y,(10^6))

data_sin = @. (sin(pi*(0.5 - rd_uni)))^2

#plot(n_range,data)

histogram!(data_sin,normalize=true,alpha=0.5)

plot!( t , pdf_log)

savefig("hist_sin_dat.png")

savefig("hist_sin_log_combine_10e4.png")

###############################################
# Trying to get Uniform random numbers back from logistic map

uni_log_test =  2 .*(0.5 .- asin.(sqrt.(log_dat)) ./pi) 

histogram(uni_log_test,normalize=true,alpha = 0.5)

savefig("uni_rand_num_log_map.png")


################################################

Plots.theme(:dark)

p = plot(0,0)

popdisplay()

for i=1:N
    m = zeros(size(Y)[1])
    for j=1:size(Y)[1]
        m[j] = Y[j][i]
    end
    scatter!(r,m,markersize=0.2,color="white",alpha = 0.3,size = (2000, 1000),legend = false)
end


display(p)

savefig("plot_log_map.png") 


######################################################

new_log_dat = log_dat = f_map(4,10^4)

new_cor = autocor(new_log_dat, 1:(10000-1) ; demean=true)

#new_cor = abs.(new_cor)

#plot(1:9999,new_cor)
histogram(1:9999,new_cor)

