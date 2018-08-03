a = read.csv(file="out-sha384.txt", header=TRUE)
plot(density(unlist(a[1,2:4097])))
lines(density(unlist(a[11,2:4097])), col="red")
lines(density(unlist(a[17,2:4097])), col="green")
lines(density(unlist(a[50,2:4097])), col="blue"

r = c()
for (i in c(2:255)){
   r[i] = ks.test(unlist(a[1,2:4097]), unlist(a[i,2:4097]))$p.value
}
which(unlist(r) < 0.05)


a = read.csv(file="out-sha384.txt", header=TRUE)
plot(ecdf(unlist(a[1,2:4097])))
lines(ecdf(unlist(a[11,2:4097])), col="red")
lines(ecdf(unlist(a[17,2:4097])), col="green")
lines(ecdf(unlist(a[50,2:4097])), col="blue")

r = c()
for (i in c(2:255)){
  r[i] = ks.test(unlist(a[1,2:4097]), unlist(a[i,2:4097]))[1]
}
qqnorm(unlist(r))


data=as.matrix(a)
# remove the row header
data=data[,2:length(data[2,])]
r = c()
for (i in c(2:length(data[,1]))){r[i] = ks.test(data[1,], data[i,])$p.value}
which(unlist(r) < 0.05/255)

