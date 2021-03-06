
all_data = array(dim=c(256, 256, 10))

for (i in 1:10) {
    a = read.csv(file=paste("timing-or-native-", i, ".csv", sep=""), header=TRUE)
    data=as.matrix(a)
    # remove "Delta" - row header
    data=data[,2:length(data[2,])]
    all_data[,,i] = data
}

cleaned = array(dim=c(256, 256))

for (x in 1:256) { for (y in 1:256) {
    cleaned[x, y] = quantile(all_data[x, y, ], 0.1)
}}

require(lattice)
levelplot(cleaned)


h <- hist(all_data, breaks=2000,plot=FALSE)
breaks = c(h$breaks)
hm <- rbind(hist(all_data[1,], breaks=breaks, plot=FALSE)$counts)
for (i in c(2:length(all_data[,1]))) {hm <- rbind(hm, hist(all_data[i,], breaks=breaks, plot=FALSE)$counts)}
levelplot(hm, ylim=c(0,200))

r = c()
for (i in c(1:length(all_data[,1]))){r[i] = ks.test(all_data[2,], all_data[i,])$p.value}
which(unlist(r) < 0.05/255)


data = as.matrix(a)
all_data = cbind(all_data, data)
h <- hist(data, breaks=2000,plot=FALSE)
breaks = c(h$breaks)
hm <- rbind(hist(data[1,], breaks=breaks, plot=FALSE)$counts)
for (i in c(2:255)) {hm <- rbind(hm, hist(data[i,], breaks=breaks, plot=FALSE)$counts)}
levelplot(hm, ylim=c(0,200))


r = c()
for (i in c(1:length(data[,1]))){r[i] = ks.test(data[2,], data[i,])$p.value}
which(unlist(r) < 0.05/255)
