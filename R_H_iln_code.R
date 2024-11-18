library(ks)

## ISE1_script_theta1

n_iter = 100

# for original data
for (n in c(50,100,200,500,1000)){
  
  for (i in seq(n_iter)){
    
    loc_X = paste('./iln_H/theta1/without nondetect', '/n_',n,'/X_',i,'.csv', sep ='')
    
    X = as.matrix(read.csv(loc_X, header = FALSE))
    
    H = Hscv(X) # (d-1) * (d-1) matrix => 2 by 2
    
    loc_H = paste('./iln_H/theta1/without nondetect', '/n_',n,'/H_',i,'.csv', sep ='')
    
    write.csv(H, loc_H, row.names = FALSE) # 
    
    print(i)
    
  }
}


# for non-detect data

for (n in c(50,100,200,500,1000)){
  
  for (i in seq(n_iter)){
    
    loc_X = paste('./iln_H/theta1/nondetect', '/n_',n,'/X_',i,'.csv', sep ='')
    
    X = as.matrix(read.csv(loc_X, header = FALSE))
    
    H = Hscv(X) # (d-1) * (d-1) matrix => 2 by 2
    
    loc_H = paste('./iln_H/theta1/nondetect', '/n_',n,'/H_',i,'.csv', sep ='')
    
    write.csv(H, loc_H, row.names = FALSE) # 
    
    print(i)
    
  }
}


## ISE1_script_theta2

n_iter = 100

# for original data
for (n in c(50,100,200,500,1000)){
  
  for (i in seq(n_iter)){
    
    loc_X = paste('./iln_H/theta2/without nondetect', '/n_',n,'/X_',i,'.csv', sep ='')
    
    X = as.matrix(read.csv(loc_X, header = FALSE))
    
    H = Hscv(X) # (d-1) * (d-1) matrix => 2 by 2
    
    loc_H = paste('./iln_H/theta2/without nondetect', '/n_',n,'/H_',i,'.csv', sep ='')
    
    write.csv(H, loc_H, row.names = FALSE) # 
    
    print(i)
    
  }
}


# for non-detect data

for (n in c(50,100,200,500,1000)){
  
  for (i in seq(n_iter)){
    
    loc_X = paste('./iln_H/theta2/nondetect', '/n_',n,'/X_',i,'.csv', sep ='')
    
    X = as.matrix(read.csv(loc_X, header = FALSE))
    
    H = Hscv(X) # (d-1) * (d-1) matrix => 2 by 2
    
    loc_H = paste('./iln_H/theta2/nondetect', '/n_',n,'/H_',i,'.csv', sep ='')
    
    write.csv(H, loc_H, row.names = FALSE) # 
    
    print(i)
    
  }
}

###=============================================================###


# Nut Real Data Analysis

X1 = as.matrix(read.csv('./food/H_iln/ilr_beef.csv', header = FALSE))
H1 = Hscv(X1)
write.csv(H1, file = './food/H_iln/H_beef.csv', row.names = FALSE)

X3 = as.matrix(read.csv('./food/H_iln/ilr_fish.csv', header = FALSE))
H3 = Hscv(X3)
write.csv(H3, './food/H_iln/H_fish.csv', row.names = FALSE)


X4 = as.matrix(read.csv('./food/H_iln/ilr_sweet.csv', header = FALSE))
H4 = Hscv(X4)
write.csv(H4, './food/H_iln/H_sweet.csv', row.names = FALSE)

