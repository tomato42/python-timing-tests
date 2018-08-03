require(lattice)
a = read.csv(file="out-sha384.txt", header=TRUE)
data=as.matrix(a)
# remove "Delta" - row header
data=data[,2:length(data[2,])]
h <- hist(data, breaks=2000,plot=FALSE)
breaks = c(h$breaks)
hm <- rbind(hist(data[1,], breaks=breaks, plot=FALSE)$counts)
for (i in c(2:255)) {hm <- rbind(hm, hist(data[i,], breaks=breaks, plot=FALSE)$counts)}
levelplot(hm, ylim=c(0,200))
