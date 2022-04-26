install.packages("forecast")
install.packages("astsa")
library(forecast) 
library(astsa)
z<-scan("C:/20062020.txt")
chi<-ts(z,start=c(2006,1,1),frequency=12)


fit<-hw(chi,seosonal="multiplicative", h=15)
ts.plot(resid(fit), ylab="residual"); abline(h=0)


fit$model
plot(fit,  ylab="chicken pox ", xlab="month", lty=1, col="blue")
lines(fit$fitted, col="red", lty=2)


ts.plot(resid(fit), ylab="residual"); abline(h=0)

