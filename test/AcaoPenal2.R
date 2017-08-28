#leitura com jsonlite 
library(jsonlite)
library(listviewer)
###
library(tidyr)
library(dplyr)

###
#library(tidyjson)
#library(dplyr)
url <- 'https://api-supremo.lexana.com.br/penal'

# read url and convert to data.frame
processos <- fromJSON(txt=url)

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
filter(processos_flat , numero_processo == "4760")

