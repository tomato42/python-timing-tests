a = read.csv(file="timing-compare_digest-perf-1.csv", header=FALSE)
data = as.matrix(a)
vals = cbind(apply(data, 1, quantile, 0.80))
 
for (i in 1:4) {
  name = paste("timing-compare_digest-r-", i, "-perf-1.csv", sep="")
  a = read.csv(file=name, header=FALSE)
  data = as.matrix(a)
  vals = cbind(vals, apply(data, 1, quantile, 0.80))
}
corrplot(cor(vals, method="spearman"), method="ellipse")





a = read.csv(file="timing-compare_digest-perf-1.csv", header=FALSE)
data = as.matrix(a)
r = c()
for (i in c(1:length(data[,1]))){r[i] = ks.test(data[2,], data[i,])$statistic}
vals = cbind(r)

for (i in 2:4) {
  name = paste("timing-compare_digest-perf-", i, ".csv", sep="")
  a = read.csv(file=name, header=FALSE)
  data = as.matrix(a)
  r = c()
  for (i in c(1:length(data[,1]))){r[i] = ks.test(data[2,], data[i,])$statistic}
  vals = cbind(vals, r)
}

for (i in 1:4) {
  name = paste("timing-compare_digest-r-", i, "-perf-1.csv", sep="")
  a = read.csv(file=name, header=FALSE)
  data = as.matrix(a)
  r = c()
  for (i in c(1:length(data[,1]))){r[i] = ks.test(data[2,], data[i,])$statistic}
  vals = cbind(vals, r)
}
corrplot(cor(vals, method="spearman"), method="ellipse")






a = read.csv(file="timing-compare_digest-8-perf-1.csv", header=FALSE)
data = as.matrix(a)
h <- hist(data, breaks=200,plot=FALSE)
breaks = c(h$breaks)
mids = c(h$mids)
hm <- rbind(hist(data[1,], breaks=breaks, plot=FALSE)$counts)
for (i in c(2:length(data[,1]))) {
  hm <- rbind(hm, hist(data[i,], breaks=breaks, plot=FALSE)$counts)}

d = data.frame(x=rep(seq(1, nrow(hm), length=nrow(hm)), ncol(hm)),
               y=rep(mids, each=nrow(hm)),
               z=c(hm))
levelplot(z~x*y, data=d, xlab="delta", ylab="time (s)",
  ylim=c(min(data), quantile(data, 0.99)))





a = read.csv(file="timing-xor-perf-1-csv.csv", header=FALSE)

a = read.csv(file="timing-xor-2-timeit-1.csv", header=FALSE, col.names=seq(1, 20), fill=TRUE)
data = as.matrix(a)
med = apply(data, 1, median, na.rm=TRUE)
# full lines
len = length(med)
columns = ceiling(length(med) / 256)
d = data.frame(x=rep(seq(0, 255), length.out=len, 256),
               y=rep(seq(0, 255), length.out=len, each=256),
               z=med)
my.at = seq(min(med), max(med), length=40)
levelplot(z~x*y, data=d, xlab="b", ylab="a", xlim=c(0, 20), ylim=c(0, 20), at=my.at, colorkey=list(at=my.at, labels=list(at=my.at)))





a = read.csv(file="timing-or-timeit-1.csv", header=FALSE, col.names=seq(1, 20), fill=TRUE)
data = as.matrix(a)
med = apply(data, 1, median, na.rm=TRUE)
# full lines
len = length(med)
columns = ceiling(length(med) / 256)
d = data.frame(x=rep(seq(0, 255), length.out=len, 256),
               y=rep(seq(0, 255), length.out=len, each=256),
               z=med)
my.at = seq(min(med), max(med), length=40)
levelplot(z~x*y, data=d, xlab="b", ylab="a", at=my.at, colorkey=list(at=my.at, labels=list(at=my.at)))






a = read.csv(file="timing-hmac-split-perf-1.csv", header=FALSE)
data = as.matrix(a)
h <- hist(data, breaks=200,plot=FALSE)
breaks = c(h$breaks)
mids = c(h$mids)
hm <- rbind(hist(data[1,], breaks=breaks, plot=FALSE)$counts)
for (i in c(2:length(data[,1]))) {
  hm <- rbind(hm, hist(data[i,], breaks=breaks, plot=FALSE)$counts)}

d = data.frame(x=rep(seq(1, nrow(hm), length=nrow(hm)), ncol(hm)),
               y=rep(mids, each=nrow(hm)),
               z=c(hm))
levelplot(z~x*y, data=d, xlab="delta", ylab="time (s)",
  ylim=c(min(data), quantile(data, 0.995)))


  
a = read.csv(file="timing-hmac-split-perf-1.csv", header=FALSE)
data = as.matrix(a)
r=c()
for (i in c(1:nrow(data))){r[i] = ks.test(data[2,], data[i,])$p.value}
which(unlist(r) < 0.05/(nrow(normalised)-1))
  
  
  
  
a = read.csv(file="timing-hmac-split-perf-1.csv", header=FALSE)
all_data = as.matrix(a)

for (i in 2:30) {
  name = paste("timing-hmac-split-perf-", i, ".csv", sep="")
  a = read.csv(file=name, header=FALSE)
  all_data = cbind(all_data, as.matrix(a))
}

normalised = all_data[,]
for (i in 1:nrow(normalised)) { normalised[i,] = normalised[i,] - median(normalised[i,])}


for (i in c(1:length(normalised[,1]))){r[i] = ks.test(normalised[1,], normalised[i,])$statistic}

h <- hist(all_data, breaks=1000,plot=FALSE)
breaks = c(h$breaks)
mids = c(h$mids)
hm <- rbind(hist(all_data[1,], breaks=breaks, plot=FALSE)$counts)
for (i in c(2:length(all_data[,1]))) {
  hm <- rbind(hm, hist(all_data[i,], breaks=breaks, plot=FALSE)$counts)}

d = data.frame(x=rep(seq(1, nrow(hm), length=nrow(hm)), ncol(hm)),
               y=rep(mids, each=nrow(hm)),
               z=c(hm))
levelplot(z~x*y, data=d, xlab="delta", ylab="time (s)",
  ylim=c(min(all_data), quantile(all_data, 0.99)))



a = read.csv(file="timing-hmac-split-perf-1.csv", header=FALSE)
data = as.matrix(a)
r = c()
for (i in c(1:length(data[,1]))){r[i] = ks.test(data[1,], data[i,])$statistic}
vals = cbind(r)
colnames(vals) = c('X1')

for (i in 2:18) {
  name = paste("timing-hmac-split-perf-", i, ".csv", sep="")
  a = read.csv(file=name, header=FALSE)
  data = as.matrix(a)
  r = c()
  for (j in c(1:length(data[,1]))){r[j] = ks.test(data[1,], data[j,])$statistic}
  r = cbind(r)
  colnames(r) = c(paste('X', i, sep=''))
  vals = cbind(vals, r)
}
corrplot(cor(vals, method="spearman"), method="ellipse")
