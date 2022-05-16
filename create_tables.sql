drop table if exists linhas cascade;
drop table if exists linhas_empresas cascade; 
drop table if exists linhas_pontos cascade; 
drop table if exists empresas cascade;
drop table if exists tipo_funcionario cascade;
drop table if exists PASSAGEIROS_VIAGENS cascade;
drop table if exists CARTOES cascade;
drop table if exists VEICULOS cascade;
drop table if exists viagens cascade;
drop table if exists FUNCIONARIOS cascade;
drop table if exists PASSAGEIROS cascade;

--CRIA TABELA DE EMPRESAS
CREATE TABLE IF NOT EXISTS EMPRESAS(
CNPJ BIGINT PRIMARY KEY NOT NULL,
RAZAO_SOCIAL VARCHAR(100) NOT NULL

);

--CRIA TABELA DE TIPO FUNCIONARIO
CREATE TABLE IF NOT EXISTS TIPO_FUNCIONARIO(
ID INT PRIMARY KEY NOT NULL,
DESCRICAO VARCHAR(100) NOT NULL

);



--CRIA TABELA DE PASSAGEIROS
CREATE TABLE IF NOT EXISTS PASSAGEIROS (
ID INTEGER PRIMARY KEY NOT NULL,
NOME VARCHAR(100) NOT NULL
);


--CRIA TABELA DE VIAGENS
CREATE TABLE IF NOT EXISTS VIAGENS(
ID INTEGER PRIMARY KEY NOT NULL ,
VALOR_PASSAGEM DOUBLE PRECISION NOT NULL,
VEICULO_PLACA VARCHAR(8) NOT NULL,
CRIADO_EM DATE NOT NULL


);



--CRIA TABELA DE LINHAS
CREATE TABLE IF NOT EXISTS LINHAS(
NUMERO INTEGER PRIMARY KEY NOT null,
NOME VARCHAR(100) NOT NULL,
ID_VIAGEM INTEGER NOT NULL ,
CONSTRAINT FK_VIAGEM_ID FOREIGN KEY (ID_VIAGEM) REFERENCES
VIAGENS (ID)

);

--CRIA TABELA DE FUNCIONARIOS

CREATE TABLE IF NOT EXISTS FUNCIONARIOS(
CPF BIGINT PRIMARY KEY NOT NULL,
TRABALHA_PARA BIGINT NOT NULL,
NOME VARCHAR(100) NOT NULL,
TIPO INT NOT NULL,
VIAGEM_ID INT NOT NULL,
CONSTRAINT FK_VIAGEM FOREIGN KEY (VIAGEM_ID) REFERENCES
VIAGENS (ID),
CONSTRAINT FK_TRABALHA_PARA FOREIGN KEY (TRABALHA_PARA) REFERENCES
EMPRESAS (CNPJ),
CONSTRAINT FK_TIPO FOREIGN KEY (TIPO) REFERENCES
TIPO_FUNCIONARIO (ID)

);


--CRIA TABELA DE VEICULOS
CREATE TABLE IF NOT EXISTS VEICULOS (
PLACA VARCHAR(8) PRIMARY KEY NOT NULL,
CPF_FUNCIONARIO BIGINT NOT NULL,
CONSTRAINT FK_FUNCIONARIO FOREIGN KEY (CPF_FUNCIONARIO) REFERENCES FUNCIONARIOS (CPF)
);


--CRIA TABELA DE PONTOS
CREATE TABLE IF NOT EXISTS PONTOS(
ID INTEGER PRIMARY KEY NOT NULL,
LOCALIZACAO VARCHAR(50) NOT NULL
);

--CRIA TABELA DE VEICULOS
CREATE TABLE IF NOT EXISTS VEICULOS (
PLACA VARCHAR(8) PRIMARY KEY NOT NULL,
CPF_FUNCIONARIO BIGINT NOT NULL,
CONSTRAINT FK_FUNCIONARIO FOREIGN KEY (CPF_FUNCIONARIO) REFERENCES FUNCIONARIOS (CPF)
);

--CRIA TABELA QUE MESCLA LINHAS E PONTOS
CREATE TABLE IF NOT EXISTS LINHAS_PONTOS(
ID INTEGER PRIMARY KEY NOT NULL ,
LINHA_NUMERO INTEGER NOT NULL,
PONTOS_ID INTEGER NOT NULL,
CONSTRAINT FK_LINHAS_PONTOS_LINHAS FOREIGN KEY (LINHA_NUMERO) REFERENCES LINHAS
(NUMERO),
CONSTRAINT FK_LINHAS_PONTOS_PONTOS FOREIGN KEY (PONTOS_ID) REFERENCES PONTOS (ID)
);

--CRIA TABELA DE CARTOES
CREATE TABLE IF NOT EXISTS CARTOES(
ID INTEGER PRIMARY KEY NOT NULL ,
SALDO DOUBLE PRECISION DEFAULT 0,
PASSAGEIRO_ID INTEGER NOT NULL,
TIPO INTEGER NOT NULL,
CONSTRAINT FK_CARTOES_PASSAGEIROS FOREIGN KEY (PASSAGEIRO_ID) REFERENCES
PASSAGEIROS (ID)
);



CREATE TABLE IF NOT EXISTS LINHAS_EMPRESAS(
EMPRESA_CNPJ bigint REFERENCES EMPRESAS(CNPJ) ON UPDATE CASCADE ON DELETE CASCADE,
NUMERO_LINHA INTEGER REFERENCES LINHAS(NUMERO) ON UPDATE CASCADE,
CONSTRAINT EMPRESA_LINHA PRIMARY KEY (EMPRESA_CNPJ, NUMERO_LINHA)
);

CREATE TABLE IF NOT EXISTS PASSAGEIROS_VIAGENS(
--ID integer PRIMARY KEY NOT NULL ,
PASSAGEIRO_ID BIGINT REFERENCES PASSAGEIROS(ID) ON UPDATE CASCADE ON DELETE CASCADE,
VIAGEM_ID INTEGER REFERENCES VIAGENS(ID) ON UPDATE cascade,
CONSTRAINT PASSAGEIRO_VIAGEM PRIMARY KEY (PASSAGEIRO_ID, VIAGEM_ID)
);


