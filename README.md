# TP01 — Integração de Sistemas de Informação

## 1. Identificação do Projeto

*Tema:* Análise de Acidentes Rodoviários em Londres — Agosto de 2025  
*Unidade Curricular:* Integração de Sistemas de Informação  
*Curso:* Engenharia de Sistemas Informáticos

*Autores:*
- Rafael Costa — Nº 31524
- David Faria — Nº 31517

## 2. Descrição do Projeto

O presente projeto tem como objetivo desenvolver um processo de Extração, Transformação e Carregamento (ETL), integrando diferentes fontes de dados relacionadas com acidentes rodoviários ocorridos em Londres durante agosto de 2025.

Foram utilizados dois datasets, Collisions e Vehicles, complementados com informação meteorológica histórica obtida através da API Open-Meteo.

O projeto foi implementado em duas ferramentas de integração de dados:

- *Pentaho Data Integration (Kettle):* processamento, integração e carregamento dos dados no SQL Server, incluindo automatização através de um Job.
- *KNIME Analytics Platform:* implementação alternativa do processo ETL, com armazenamento dos resultados em PostgreSQL.

Adicionalmente, ambas as implementações incluem a geração de estatísticas, o envio automático de emails e a visualização dos resultados através de dashboards desenvolvidos em Node-RED. A implementação KNIME inclui também exportação de dados em JSON e XML e monitorização dos logs associados à ligação ao PostgreSQL.

## 3. Estrutura dos Ficheiros

| Pasta/Ficheiro | Descrição |
|---|---|
| README.md | Descrição do projeto e instruções de execução. |
| doc/ | Relatório final do projeto em formato PDF. |
| dataintegration/pentaho/ | Transformações .ktr e Job .kjb desenvolvidos no Pentaho. |
| dataintegration/knime/ | Projeto e workflows desenvolvidos no KNIME. |
| data/input/ | Ficheiros CSV utilizados como entrada no processo ETL. |
| data/output/ | Ficheiros CSV e JSON produzidos durante o processamento. |
| src/ | Scripts SQL e ficheiros de configuração do dashboard Node-RED. |

## 4. Ferramentas Utilizadas

- Pentaho Data Integration 10.2
- KNIME Analytics Platform 5.12.0
- Microsoft SQL Server e SQL Server Management Studio
- PostgreSQL
- Node-RED com Dashboard 2.0
- API Open-Meteo

## 5. Instruções de Execução

### 5.1. Pentaho Data Integration

*Preparação*

1. Instalar o Pentaho Data Integration 10.2.
2. Extrair os ficheiros do projeto, mantendo a estrutura das pastas.
3. Confirmar os caminhos dos ficheiros CSV utilizados nas transformações.
4. Configurar a ligação ao SQL Server no Pentaho.
5. Criar a base de dados e as tabelas necessárias, utilizando os scripts SQL disponibilizados na pasta src/.
6. Configurar os parâmetros de envio de email, caso se pretenda utilizar essa funcionalidade.

*Execução*

1. Abrir o Pentaho Spoon.
2. Abrir o Job 00_ETL_Acidentes_Londres.kjb, localizado em dataintegration/pentaho/.
3. Executar o Job através do botão Run.
4. Acompanhar a execução das transformações e verificar se todas terminam com sucesso.

O Job executa as etapas de limpeza, processamento, recolha meteorológica, integração, carregamento no SQL Server e geração de estatísticas.

Após a execução, os resultados podem ser consultados nas tabelas Acidentes e Veiculos e nos ficheiros JSON produzidos.

*Nota:* As transformações iniciais de preparação dos datasets (01_Preparacao_Collisions.ktr e 02_Preparacao_Vehicles.ktr) devem ser executadas previamente caso os respetivos ficheiros preparados ainda não existam.

### 5.2. KNIME Analytics Platform

**Preparação**

1. Instalar o KNIME Analytics Platform 5.12.0 e o PostgreSQL 18.
2. Importar os workflows disponíveis em `dataintegration/KNIME/`.
3. Confirmar os caminhos dos ficheiros CSV utilizados nos workflows.
4. Criar a base de dados e as tabelas necessárias através do script `src/Criacao_Base_Dados_PostgreSQL.sql`.
5. Configurar a ligação ao PostgreSQL nos nodes `PostgreSQL Connector`.
6. Configurar os parâmetros de envio de email, caso se pretenda utilizar essa funcionalidade.

**Execução**

1. Abrir o KNIME Analytics Platform.
2. Executar sequencialmente os workflows `01_Limpeza_Collisions` até `06_Integração_Dados`.
3. Executar o workflow `07_Carregamento_PostgresSQL`, garantindo que os acidentes são carregados antes dos veículos.
4. Executar `08_Exportacao_Resultados` para gerar os ficheiros JSON, XML e as estatísticas.
5. Executar `09_Logs_KNIME` para obter os registos associados ao PostgreSQL Connector.
6. Verificar os resultados obtidos na base de dados e nos ficheiros exportados.

Após a execução, os resultados podem ser consultados nas tabelas `collisions` e `vehicles` do PostgreSQL, contendo respetivamente **1701 acidentes e 3120 veículos**.

**Nota:** Os workflows são executados sequencialmente, não existindo um Job de orquestração na implementação KNIME.

### 5.3. Dashboard Node-RED

1. Instalar o Node.js e o Node-RED.
2. Iniciar o Node-RED através do comando:

   node-red

3. Aceder a http://localhost:1880.
4. Importar o ficheiro correspondente à implementação pretendida, disponível na pasta `src/`:
   - Pentaho: `Dashboard_Acidentes_Londres(31524).json`
   - KNIME: `Dashboard_Acidentes_Londres_NodeRED(31517).json`

5. Configurar os caminhos dos ficheiros JSON de estatísticas produzidos pela respetiva implementação ETL.
6. Configurar os caminhos dos seis ficheiros JSON produzidos pelo Pentaho.
7. Efetuar o Deploy e executar os nós de leitura dos ficheiros, quando necessário.
8. Aceder ao dashboard através do endereço configurado no Node-RED.

## 6. Resultados Obtidos

A execução do processo ETL permitiu integrar e analisar:

- *1701 acidentes rodoviários*;
- *3120 registos de veículos*;
- Informação meteorológica histórica relativa aos 33 distritos de Londres;
- Estatísticas gerais e análises por sexo, faixa etária, gravidade, período do dia e condições meteorológicas.

Os resultados são armazenados nas bases de dados relacionais e disponibilizados através de ficheiros JSON, email automático e dashboard.

## 7. Vídeo de Demonstração

O vídeo apresenta o funcionamento da solução, incluindo as principais transformações, a execução do processo ETL, o carregamento dos dados e a visualização dos resultados.

*Link do vídeo (31524):* https://drive.google.com/file/d/1vFIQQKoutkhPokwqFppEj7OlEXicWPcL/view?usp=sharing

*Link do video (31517):* https://drive.google.com/file/d/1kZvIWJcJJ3nSVIgxceZ7-FFwFOZ6rWQL/view?usp=drive_link

## 8. Fontes de Dados

*Road Safety Open Data — Department for Transport*  
https://www.gov.uk/government/statistical-data-sets/road-safety-open-data

*Historical Weather API — Open-Meteo*  
https://open-meteo.com/en/docs/historical-weather-api
