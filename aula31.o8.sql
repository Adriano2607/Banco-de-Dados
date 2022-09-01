create database Produtos;
use Produtos;

create table prods(
codigo numeric(3) not null,
nome varchar(50) not null,
preco numeric(5,2) not null,
tipo char(1) null,
constraint PK1 primary key(codigo));

insert into prods values
(10,'hd',200,'c'),
(11,'memoria',250,'c'),
(12,'impressora',680,'p'),
(13,'processador',600,'c'),
(14,'DVD-RW',2,'s'),
(15,'Papel A4',19,'s'),
(16,'Scanner',199,'p');

select count(nome) as somaprodutos from prods;

select count(tipo) as somatipo from prods;

SELECT DISTINCT tipo FROM prods;

select count(tipo) as somatipop from prods where tipo like 'p';
select count(tipo) as somatipoc from prods where tipo like 'c';
select count(tipo) as somatipos from prods where tipo like 's';
select count(*) as soma from prods group by tipo;

SELECT AVG(preco) FROM prods;

SELECT AVG(preco) FROM prods where tipo like 'p';
SELECT AVG(preco) FROM prods where tipo like 'c';
SELECT AVG(preco) as media from prods group by tipo;



