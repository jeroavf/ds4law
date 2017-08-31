#leitura com jsonlite 
library(jsonlite)
library(listviewer)
###
library(tidyr)
library(dplyr)
library(lubridate)

###
#library(tidyjson)
#library(dplyr)
url <- 'https://api-supremo.lexana.com.br/penal'

# read url and convert to data.frame
processos <- fromJSON(txt=url)
#teste de controle de versão

#desnormaliza , transformando em observa'çoes de uma linha sem multivaloracoes
processos_flat <- unnest(processos)
#> select(processos_flat , data_inicio_processo)
#Erro: found duplicated column name: classe
#visualizacao com listviewer
jsonedit(processos_flat)

colnames(processos_flat ) <- c("numero_processo", "classe_processo", "numero_protocolo", 
                               "data_inicio_processo","numero_unico", "data_protocolo", 
                               "origem", "estado", "tipo", "nome_instituicao", "idpartes", 
                               "ordem", "nome", "classe_parte"  )
names(processos_flat)
# acerta tipo factor 
filter(processos_flat , numero_processo == "4760")
processos_flat$classe_parte <- factor(processos_flat$classe_parte )
processos_flat$nome_instituicao <- factor(processos_flat$nome_instituicao )
processos_flat$tipo <- factor(processos_flat$tipo )
processos_flat$estado <- factor(processos_flat$estado )
processos_flat$origem <- factor(processos_flat$origem )
processos_flat$classe_processo <- factor(processos_flat$classe_processo )
processos_flat$data_protocolo <- ymd_hms(processos_flat$data_protocolo )
glimpse(processos_flat)
