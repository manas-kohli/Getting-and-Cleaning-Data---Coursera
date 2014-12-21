testdata <- function(){
	initialtestdata <- read.table("./test/X_test.txt")	
	typetest <- read.table("./test/y_test.txt")
	propertestdata <- cbind(typetest, initialtestdata)
	colnames(propertestdata)[1] <- "activity"
	subjecttest <- read.table("./test/subject_test.txt")
	propertestdata <- cbind(subjecttest, propertestdata)
	colnames(propertestdata)[1] <- "SubjectId"
	for (i in 1:2947){
		if (propertestdata[i,2] == "1"){
			propertestdata[i,2] = "WALKING"
		}
		if (propertestdata[i,2] == "2"){
			propertestdata[i,2] = "WALKING_UPSTAIRS"
		}
		if (propertestdata[i,2] == "3"){
			propertestdata[i,2] = "WALKING_DOWNSTAIRS"
		}
		if (propertestdata[i,2] == "4"){
			propertestdata[i,2] = "SITTING"
		}
		if (propertestdata[i,2] == "5"){
			propertestdata[i,2] = "STANDING"
		}	
		if (propertestdata[i,2] == "6"){
			propertestdata[i,2] = "LAYING"
		}
	}
	counter <- ncol(propertestdata)
	propertest <- data.frame(nrow=2947)
	for (i in 3:counter){
		propertest <- cbind(propertest, as.numeric(unlist(propertestdata[i])))
	}

	propertest <- cbind(propertestdata[2], propertest)
	propertest <- cbind(propertestdata[1], propertest)
	propertest[3] <- NULL
	tempmean <- rowMeans(propertest[,3:563])
	propertest <- cbind(propertest, tempmean)
	colnames(propertest)[564] <- "Mean"
	featurenames <- read.table("features.txt")
	featurevector <- featurenames[c(1:561),]
	featurevector <- as.character(featurevector)
	colnames(propertest)[3:563] <- featurevector 
	numericmean <- grep("mean", names(propertest))
 	numericstd <- grep("std", names(propertest))
 	numericsubset <- c(1,2,numericmean,numericstd)
	propertest <- propertest[,numericsubset]
	finalnumber <- ncol(propertest) - 2
	tempmean <- rowMeans(propertest[,3:finalnumber])
	propertest <- cbind(propertest, tempmean)
	colnames(propertest)[ncol(propertest)] <- "MeanSubject"
	finalnumber <- nrow(propertest) - 2
	tempmean <- colMeans(propertest[,3:finalnumber])
	tempmean <- c(NA, NA, tempmean)
	propertest <- rbind(propertest, tempmean)
	rownames(propertest)[nrow(propertest)] <- "MeanVariable"

	return (propertest)
}

traindata <- function(){
	initialtraindata <- read.table("./train/X_train.txt")	
	typetrain <- read.table("./train/y_train.txt")
	propertraindata <- cbind(typetrain, initialtraindata)
	colnames(propertraindata)[1] <- "activity"
	subjecttrain <- read.table("./train/subject_train.txt")
	propertraindata <- cbind(subjecttrain, propertraindata)
	colnames(propertraindata)[1] <- "SubjectId"
	featurenames <- read.table("features.txt")
	featurenames <- data.frame(t(featurenames))
	featurevector <- featurenames[c(1:561),]
	featurevector <- as.character(featurevector)
	colnames(propertraindata)[3:563] <- featurevector
	for (i in 1:7352){
		if (propertraindata[i,2] == "1"){
			propertraindata[i,2] = "WALKING"
		}
		if (propertraindata[i,2] == "2"){
			propertraindata[i,2] = "WALKING_UPSTAIRS"
		}
		if (propertraindata[i,2] == "3"){
			propertraindata[i,2] = "WALKING_DOWNSTAIRS"
		}
		if (propertraindata[i,2] == "4"){
			propertraindata[i,2] = "SITTING"
		}
		if (propertraindata[i,2] == "5"){
			propertraindata[i,2] = "STANDING"
		}	
		if (propertraindata[i,2] == "6"){
			propertraindata[i,2] = "LAYING"
		}
	}
	counter <- ncol(propertraindata)
	propertrain <- data.frame(nrow=7352)
	for (i in 3:counter){
		propertrain <- cbind(propertrain, as.numeric(unlist(propertraindata[i])))
	}
	propertrain <- cbind(propertraindata[2], propertrain)
	propertrain <- cbind(propertraindata[1], propertrain)
	propertrain[3] <- NULL
	tempmean <- rowMeans(propertrain[,3:563])
	propertrain <- cbind(propertrain, tempmean)
	colnames(propertrain)[564] <- "Mean"
	featurenames <- read.table("features.txt")
	featurevector <- featurenames[c(1:561),]
	featurevector <- as.character(featurevector)
	colnames(propertrain)[3:563] <- featurevector
	numericmean <- grep("mean", names(propertrain))
 	numericstd <- grep("std", names(propertrain))
 	numericsubset <- c(1,2,numericmean,numericstd)
	propertrain <- propertrain[,numericsubset]
	tempproper <- data.frame(nrow = 98)
	uniqueSubjects = unique(traindata)[,1]
	for (i in 1:c(1,3,5,6,7,8,11,14,15,16,17,19,21,22,23,25,26,27,28,29,30)){
		tmp1 <- subset(propertrain, SubjectId == i & activity == "WALKING", drop = FALSE)
		tmp2 <- subset(propertrain, SubjectId == i & activity == "WALKING_UPSTAIRS", drop = FALSE)
		tmp3 <- subset(propertrain, SubjectId == i & activity == "WALKING_DOWNSTAIRS", drop = FALSE)
		tmp4 <- subset(propertrain, SubjectId == i & activity == "LAYING", drop = FALSE)
		tmp5 <- subset(propertrain, SubjectId == i & activity == "SITTING", drop = FALSE)
		tmp6 <- subset(propertrain, SubjectId == i & activity == "STANDING", drop = FALSE)
		tmp1num <- data.frame(nrow = nrow(tmp1))
		tmp2num <- data.frame(nrow = nrow(tmp2))
		tmp3num <- data.frame(nrow = nrow(tmp3))
		tmp4num <- data.frame(nrow = nrow(tmp4))
		tmp5num <- data.frame(nrow = nrow(tmp5))
		tmp6num <- data.frame(nrow = nrow(tmp6))
		for (i in 3:ncol(tmp1)){
			tmp1num <- cbind(tmp1num, as.numeric(as.character(unlist(tmp1[,i]))))
		}
		for (i in 3:ncol(tmp2)){
			tmp2num <- cbind(tmp2num, as.numeric(as.character(unlist(tmp2[,i]))))
		}
		for (i in 3:ncol(tmp3)){
			tmp3num <- cbind(tmp3num, as.numeric(as.character(unlist(tmp3[,i]))))
		}
		for (i in 3:ncol(tmp4)){
			tmp4num <- cbind(tmp4num, as.numeric(as.character(unlist(tmp4[,i]))))
		}
		for (i in 3:ncol(tmp5)){
			tmp5num <- cbind(tmp5num, as.numeric(as.character(unlist(tmp5[,i]))))
		}
		for (i in 3:ncol(tmp6)){
			tmp6num <- cbind(tmp6num, as.numeric(as.character(unlist(tmp6[,i]))))
		}
		
		tmp1means <- colMeans(tmp1num) 
		tmp2means <- colMeans(tmp2num)
		tmp3means <- colMeans(tmp3num)
		tmp4means <- colMeans(tmp4num)
		tmp5means <- colMeans(tmp5num)
		tmp6means <- colMeans(tmp6num)	
		tempproper <- rbind(tempproper, tmp1means)
		tempproper <- rbind(tempproper, tmp2means)
 		tempproper <- rbind(tempproper, tmp3means)
		tempproper <- rbind(tempproper, tmp4means)
		tempproper <- rbind(tempproper, tmp5means)
		tempproper <- rbind(tempproper, tmp6means)
	}
	colnames(tempproper) <- colnames(propertrain)[3:81]
	return (propertrain)
}

mergedatasets <- function(){
	testmergedata <- testdata()
	trainmergedatcola <- traindata()
	mergedData <- merge(testmergedata,trainmergedata,by = intersect(names(x), names(y)),
      by.x = by, by.y = by,all=TRUE)
	return (mergedData)
}
