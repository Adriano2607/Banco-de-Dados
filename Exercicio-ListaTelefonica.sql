create database exListaTelefonica;
use exListaTelefonica;

create table assinante (
cd_assinante INT not null primary Key,
nome_assinante varchar(75) not null,
cd_ramo  int not null,
cd_tipo int not null,
cd_end int not null);

create table Ramo_Atividade (
cd_ramo int not null primary key,
descricao_ramo varchar(100));

ALTER TABLE assinante ADD CONSTRAINT FK_CD_RAMO
FOREIGN KEY (cd_ramo) REFERENCES Ramo_Atividade(cd_ramo) ON DELETE CASCADE; 

create table Tipo_Assinante (
cd_tipo int not null primary key,
descricao_tipo varchar (50) );

ALTER TABLE assinante ADD CONSTRAINT FK_CD_TIPO_ASSINANTE
FOREIGN KEY (cd_tipo) REFERENCES Tipo_Assinante(cd_tipo) ON DELETE CASCADE; 

create table Endereco (
cd_endereco int not null primary key,
descricao_endereco varchar(150),
complemento varchar(100),
bairro varchar(150),
cep varchar(25),
end_munic int not null,
end_fone int not null);

ALTER TABLE assinante ADD CONSTRAINT FK_CD_ENDERECO
FOREIGN KEY (cd_end) REFERENCES Endereco(cd_endereco) ON DELETE CASCADE; 

create table Municipio(
cd_municipio int not null primary key,
descricao_municipio varchar(200)
);

ALTER TABLE Endereco ADD CONSTRAINT FK_CD_END_MUNIC
FOREIGN KEY (end_munic) REFERENCES Municipio(cd_municipio) ON DELETE CASCADE; 

create table Telefone(
cd_fone int not null primary key,
ddd varchar(5),
numero_fone varchar(35));

ALTER TABLE Endereco ADD CONSTRAINT FK_CD_END_FONE
FOREIGN KEY (end_fone) REFERENCES Telefone(cd_fone) ON DELETE CASCADE;

insert into Municipio values
(1,"Sao judas"),
(2,"Palmas"),
(3,"Terra de Ninguem");

insert into Telefone values 
(1,"55","4566789876"),
(2,"55","12345678");

insert into Endereco values
(1,"Casa Bonita","casa","Campina","34536346",1,1),
(2,"APTO","apto","Souza","45646476",1,2);

insert into Tipo_Assinante values
(1,"Comercial"),
(2,"Residencial");

insert into Ramo_Atividade values
(1,"Traficante"),
(2,"Contrabando");

insert into assinante values
(1,"Adriano",1,1,2);

insert into assinante values
(2,"Lucas",2,2,1);

select * from assinante;
select * from endereco;
select * from municipio;
select * from ramo_atividade;
select * from telefone;
select * from tipo_assinante;

-- 1. Listar os nomes dos assinantes, seguido dos dados do endereço e os telefones correspondentes.
select nome_assinante as NOME,numero_fone as TELEFONE , descricao_endereco as TIPO, complemento ,bairro,cep
from assinante a 
inner join endereco e on a.cd_end = e.cd_endereco
inner join telefone t on e.end_fone = t.cd_fone; 

-- 2. Listar os nomes dos assinantes, seguido do seu ramo, ordenados por ramo e posteriormente por nome. 
select nome_assinante,descricao_ramo from assinante
inner join ramo_atividade on ramo_atividade.cd_ramo = assinante.cd_ramo
order by descricao_ramo,nome_assinante ASC;

-- 3. Listar os assinantes do município de Pelotas que são do tipo residencial. 
select nome_assinante from assinante
inner join endereco on endereco.cd_endereco = assinante.cd_end
inner join municipio on municipio.cd_municipio = endereco.end_munic and municipio.descricao_municipio = 'Pelotas'
inner join tipo_assinante on tipo_assinante.cd_tipo = assinante.cd_tipo and tipo_assinante.descricao_tipo = 'Residencial'
order by assinante.nome_assinante ASC;
    
-- 4. Listar os nomes dos assinantes que possuem mais de um telefone
select nome_assinante from assinante
inner join endereco on endereco.cd_endereco = assinante.cd_end
inner join telefone on telefone;

-- 5. Listar os nomes dos assinantes seguido do número do telefone, tipo de assinante comercial, com endereço em Pelotas ou Canguçu. 
select nome_assinante,telefone from assinante
inner join tipo_assinante on tipo_assinante.cd_tipo = assinante.cd_tipo and tipo_assinante.descricao_tipo = 'Comercial'
inner join endereco on endereco.cd_endereco = assinante.cd_end
inner join municipio on municipio.cd_municipio = endereco.end_munic and (municipio.ds_municipio = 'Pelotas' OR municipio.descricao_municipio = 'Canguçu')
inner join telefone on telefone.CD_END = E.cd_endereco;


