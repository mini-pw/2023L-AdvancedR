
library(missMDA)
library(FactoMineR)

# PCA ---------------------------------------------------------------------

data(orange)
## First the number of components has to be chosen
## (for the imputation step)
# estim_ncpPCA - Estimate the number of dimensions for the Principal Component Analysis by cross-validation
#ncp.max integer corresponding to the maximum number of components to test
#method.cv string with the values "gcv" for generalised cross-validation, "loo" for leave-
#one-out or "Kfold" cross-validation
nb <- estim_ncpPCA(orange,ncp.max=5) ## Time consuming, nb = 2
#ncp argument- integer corresponding to the number of components used to to predict the missing entries
##Impute the missing values of a dataset with the PCA model. 
res.comp <- imputePCA(orange,ncp=nb$ncp)
## A PCA can be performed on the imputed data
View(res.comp$completeObs)
res.pca <- PCA(res.comp$completeObs)
summary(res.pca)


data(orange)
nb = estim_ncpPCA(orange,ncp.max=5)
#MIPCA performs Multiple Imputation with a PCA model.
# nboot the number of imputed datasets
res.comp = MIPCA(orange, ncp = nb$ncp, nboot = 1000)
plot(res.comp) 
#visualize the impact of the different imputed values on the PCA results

# Confidence Areas --------------------------------------------------------

data("geno", package = "missMDA")
ncomp <- estim_ncpPCA(geno)
res.imp <- imputePCA(geno, ncp = ncomp$ncp) # domyślnie regularyzowane

View(res.imp$completeObs)

res.pca <- PCA(res.imp$completeObs)

resMIPCA <- MIPCA(geno, ncp = 2, nboot = 200)
plot(resMIPCA, choice = "ind.supp", axes = c(1, 2), new.plot = TRUE, main = NULL, level.conf = 0.95)

# MCA ---------------------------------------------------------------------

data("vnf", package = "missMDA")
# ncomp <- estim_ncpMCA(vnf, method.cv = "Kfold")
# Ustalmy ncomp$ncp = 4 żeby się nie zaliczyć
tab.disj.impute <- imputeMCA(vnf, ncp = 4)$tab.disj
res.mca <- MCA(vnf, tab.disj = tab.disj.impute)

plot(res.mca, choix = "ind", invisible = "ind")

# FAMD --------------------------------------------------------------------

data("snorena", package = "missMDA")
res.impute <- imputeFAMD(snorena, ncp = 3)
res.famd <- FAMD(snorena, tab.disj = res.impute$tab.disj)

# MFA ---------------------------------------------------------------------

data("gene", package = "missMDA")
res.impute <- imputeMFA(gene[, -1], group = c(76, 356), type = rep("s", 2), ncp = 2)
res.mfa <- MFA(cbind.data.frame(gene[, 1], res.impute$completeObs), group = c(1, 76, 356), type = c("n", rep("s", 2)),
               name.group = c("WHO", "CGH", "expr"), num.group.sup = 1)

#individual factor map
plot(res.mfa, habillage = 1, lab.ind = FALSE)
#correlation circle
plot(res.mfa, choix = "var", lab.var = FALSE, habillage = "group")

#partial individual factor map
plot(res.mfa, invisible = "ind", partial = "all", habillage = "group")

