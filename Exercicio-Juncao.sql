create database exJuncao;
use exJuncao;

CREATE TABLE CLIENTE(
CPF INT PRIMARY KEY,
NOME varchar(60),
DTNASC date
);

CREATE TABLE VEICULO(
PLACA VARCHAR(8) PRIMARY KEY,
MODELO_CODMOD INT,
CLIENTE_CPF INT,
COR VARCHAR(20)
);

CREATE TABLE MODELO(
CODMOD INT PRIMARY KEY,
DESC_2 VARCHAR(40)
);

CREATE TABLE PATIO(
NUM INT PRIMARY KEY,
ENDER VARCHAR(40),
CAPACIDADE INT
);

CREATE TABLE ESTACIONA(
COD INT PRIMARY KEY,
PATIO_NUM INT,
VEICULO_PLACA VARCHAR(8),
DTENTRADA VARCHAR(10),
DTSAIDA VARCHAR(10),
HSENTRADA VARCHAR(10),
HSSAIDA VARCHAR(10)
);

ALTER TABLE VEICULO ADD CONSTRAINT FK_COD_MODELO
FOREIGN KEY (MODELO_CODMOD) REFERENCES MODELO(CODMOD) ON DELETE RESTRICT;

ALTER TABLE VEICULO ADD CONSTRAINT FK_CLIENTE_CPF
FOREIGN KEY (CLIENTE_CPF) REFERENCES CLIENTE(CPF) ON DELETE RESTRICT;

ALTER TABLE ESTACIONA ADD CONSTRAINT FK_PATIO_NUM
FOREIGN KEY (PATIO_NUM) REFERENCES PATIO(NUM) ON DELETE RESTRICT;

ALTER TABLE ESTACIONA ADD CONSTRAINT FK_VEICULO_PLACA
FOREIGN KEY (VEICULO_PLACA) REFERENCES VEICULO(PLACA) ON DELETE RESTRICT;

select * from cliente;
select * from estaciona;
select * from modelo;
select * from patio;
select * from veiculo;

-- a) Exiba a placa e o nome dos donos de todos os veículos.
select placa,nome from veiculo
inner join cliente on cliente.cpf = veiculo.cliente_cpf;

-- b) Exiba o CPF e o nome do cliente que possui o veiculo de placa “JJJ-2020”.
select cpf,nome from cliente
inner join veiculo on veiculo.cliente_cpf = cliente.cpf
where placa = 'JJJ-2020';

-- c) Exiba a placa e a cor do veículo que possui o código de estacionamento 1.
select placa,cor from veiculo
inner join estaciona on estaciona.veiculo_placa = veiculo.placa
where estaciona.cod = '1';

-- d) Exiba a placa e o ano do veículo que possui o código de estacionamento 1
select v.placa, v.ano from Veiculo v 
INNER JOIN Estaciona e
ON v.placa = e.Veiculo_placa
WHERE e.cod = 1;

-- e) Exiba a placa, o ano do veículo e a descrição de seu modelo, se ele possuir ano a partir de 2000
select placa,ano,desc_2 from veiculo
inner join modelo on modelo.codmod = veiculo.modelo_codmod
where ano >= 2000;

-- f) Exiba o endereço, a data de entrada e de saída dos estacionamentos do veículo de placa “JEG-1010”
select ender,dtEntrada,dtSaida 
from patio inner join estaciona 
on estaciona.patio_num = patio.num
where veiculo_placa = 'JEG-1010';

-- g) Exiba a quantidade de vezes que os veículos de cor verde estacionaram. 
SELECT count(e.cod) AS Quantidade
FROM Veiculo v INNER JOIN Estaciona e
ON v.placa = e.Veiculo_placa
WHERE v.cor = 'verde';

-- h) Liste todos os clientes que possuem carro de modelo 1.
select nome from cliente
inner join veiculo on veiculo.cliente_cpf = cliente.cpf
where veiculo.modelo_codmod = '1';

-- i) Liste as placas, os horários de entrada e saída dos veículos de cor verde
select v.placa,e.hsentrada,e.hssaida from veiculo v
inner join estaciona e on e.veiculo_placa = v.placa
where v.cor = 'verde';

-- j) Liste todos os estacionamentos do veículo de placa “JJJ-2020”.
select e.cod,e.dtentrada,e.dtsaida,e.hsentrada,e.hssaida from estaciona e
inner join veiculo v on v.placa = e.veiculo_placa
where v.placa = 'JJJ-2020';

-- k) Exiba o nome do cliente que possui o veículo cujo código do estacionamento é 2.	
select c.nome from cliente c
inner join veiculo v on v.cliente_cpf = c.cpf
inner join estaciona e on e.veiculo_placa = v.placa
where e.cod = '2';

-- l) Exiba o CPF do cliente que possui o veículo cujo código do estacionamento é 3.
select c.cpf from cliente c
inner join veiculo v on v.cliente_cpf = c.cpf
inner join estaciona e on e.veiculo_placa = v.placa
where e.cod = '3';

-- m) Exiba a descrição do modelo do veículo cujo código do estacionamento é 2.
select m.descricao from modelo m
inner join veiculo v on m.codmod = v.modelo_codmod
inner join estaciona e on e.veiculo_placa = v.placa
where e.cod = '2';

-- n) Exiba a placa, o nome dos donos e a descrição dos os modelos de todos os veículos.
select v.placa, c.nome, m.descricao from Modelo m 
inner join Veiculo v on m.codMod = v.Modelo_codMod 
inner join Cliente c on c.cpf = v.Cliente_cpf;
