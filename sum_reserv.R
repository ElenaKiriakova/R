library(tidyverse)
library(stringi)
library(stringr)
library(readxl)

path <- 'D:\\IT\\VBRR\\Для макроса\\';

files <- list.files(path)



name_files_all <- vector()
name_files_last_vers <- vector()

result <- vector()

for (el in files){
  
  if(el %in% name_files_all){
    continue
  }
  else{
    file <- list.files(paste(path, el,'\\', sep=''))
    name_files_all <- c(name_files_all, file)
    print(name_files_all)
  }
}


for (el in name_files_all){
  
  if (paste(str_trunc(el, (str_count(el) - 5),ellipsis = ""), " v1", '.xlsx', sep='') %in% name_files_all &
      paste(str_trunc(el, (str_count(el) - 5),ellipsis = ""), " v2", '.xlsx', sep='') %in% name_files_all){
    
    name_files_last_vers <- c(name_files_last_vers, el, paste(str_trunc(el, (str_count(el) - 5),ellipsis = ""), " v1", '.xlsx', sep=''))
  }
  
  else if(paste(str_trunc(el, (str_count(el) - 5),ellipsis = ""), " v1", '.xlsx', sep='') %in% name_files_all){
    name_files_last_vers <- c(name_files_last_vers, el)
  }
}

files_to_res <- name_files_all[!name_files_all %in% name_files_last_vers]
print(files_to_res)

for (el in files){
  
  file <- list.files(paste(path, el,'\\', sep=''))
  
  for (fl in file){
  
    if (fl %in% files_to_res){
    
    my_data <- read_excel(paste(path, el,'\\', fl, sep=''))
      
    for(col in colnames(my_data)){

      if (str_detect(col, "prov_ru")){
        print(col)
        result <- c(result, sum(my_data[col]))    
      }
    }
    
    }
  }
}

print(result)