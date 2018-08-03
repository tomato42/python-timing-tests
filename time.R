h <- hist(all_data, breaks=5000,plot=FALSE)
breaks = c(h$breaks)
hm <- rbind(hist(all_data[1,], breaks=breaks, plot=FALSE)$counts)
for (i in c(2:255)) {hm <- rbind(hm, hist(all_data[i,], breaks=breaks, plot=FALSE)$counts)}
levelplot(hm, ylim=c(0,200))

r = c()
for (i in c(2:length(all_data[,1]))){r[i] = ks.test(all_data[1,], all_data[i,])$p.value}
which(unlist(r) < 0.05/255)

a = read.csv(file="timing-ct_le_u32-1.csv", header=TRUE)
data=as.matrix(a)
# remove the row header
data=data[,2:length(data[2,])]
levelplot(data)


h <- hist(data, breaks=5000,plot=FALSE)
breaks = c(h$breaks)
hm <- rbind(hist(data[,1], breaks=breaks, plot=FALSE)$counts)
for (i in c(2:255)) {hm <- rbind(hm, hist(data[,i], breaks=breaks, plot=FALSE)$counts)}
levelplot(hm, ylim=c(0,200))



h <- hist(data, breaks=5000,plot=FALSE)
breaks = c(h$breaks)
hm <- rbind(hist(data[1,], breaks=breaks, plot=FALSE)$counts)
for (i in c(2:255)) {hm <- rbind(hm, hist(data[i,], breaks=breaks, plot=FALSE)$counts)}
levelplot(hm, ylim=c(0,200))
