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

#names(processos_flat[!duplicated(colnames(processos_flat))] )
#identifica a ultima coluna com nome classe
indice_duplicado_no_final  <- processos_flat %>% 
         colnames() %>%
         duplicated()

#identifica a primeira coluna com nome classe
indice_duplicado_no_inicio  <- processos_flat %>% 
        colnames() %>%
        duplicated(fromLast = TRUE)

#guarda os dados das classes de processo e parte 
classe_parte <- as.list(processos_flat[indice_duplicado_no_final])
classe_processo <- as.list(processos_flat[indice_duplicado_no_inicio])

#exclui as duas colunas com nome classe , se nao for feito dessa forma , ocorre erro de 
# colunas com nome duplicado 
colunas_que_ficam <- c("numero_processo", "numero_protocolo", "data_inicio_processo","numero_unico", "data_protocolo", "origem", "estado", "tipo", "nome_instituicao", "idpartes", "ordem", "nome")
processos2 <- processos_flat[colunas_que_ficam]

#inclui as colunas com as classes renomeadas 
processos2$classe_parte <- classe_parte
processos2$classe_processo <- classe_processo

jsonedit(processos2)

