/*
*********************************************************************
Trigger(ou gatilho) é um objeto de banco de dados que é associado 
a uma tabela com uma espécie de condicional. Quando tal condição
se dá por verdadeira, o gatilho é acionado e executa uma determinada
ação. Trigger normalmente são criados no termino das declaração das
tabelas.
*********************************************************************
*Criação de um trigger:
create trigger (1) (2) (3) on (4)
for each row (5);
onde:
(1): Nome dado ao trigger, normalmente iniciado com tr como (trExemplo)
(2): before(antes), after(depois)
(3): ação a ser comparada como insert, delete, delete e replace
(4): tabela à ser afetada pela ação (3)
(5): ação a ser realizada
*/
-- realiza o "drop" do banco caso haja um criado
drop database if exists dbExemplo;

-- Cria o banco
create database dbExemplo;
-- Ou "create database if not exists dbExemplo"


-- Seta como "usavél" o banco selecionado
use dbExemplo;

-- Cria a tabela
create table tbEscola(
idEscola int not null auto_increment primary key,
/*not null: não vazio, auto_increment: Insere automaticamente um valor
primary key: usado na chave estrangeira, unsigned: Apenas valores 
positivos, unique: o conteudo deve ser unico, zerofill: auto completa
"0" para preencher, vindo sempre depois da variavel
*/
nomeEscola varchar(255),
numeroEscola varchar(255)
/* Pode ser setado assim também
primary key (id)*/
);

create table tbAluno(
idAluno int not null auto_increment primary key,
nomeAluno varchar(255),
serieAluno varchar(10),
estudandoAluno bool, -- equivalente a variavel boolean
salvar_idEscola int,
/* 
Criação de chave estrangeira:
foreign key (nome da variavel na propria tabela)
	references nome_da_tabela (nome_da_variavel_à_ser_puxada)
E ao inves de setar uma variavel pode-se se usar o CONSTRAINT
que possuí a mesma função
*/
foreign key (salvar_idEscola)
	references tbEscola (idEscola)
);
create table tbBackup(
id int not null auto_increment primary key,
nomeRecuperado varchar(255),
numeroRecuperado varchar(255)
);


/*
   - INSERT: o operador NEW.nome_coluna, nos permite verificar o valor 
   enviado para ser inserido em uma coluna de uma tabela. OLD.nome_coluna
   não está disponível.
   
   - DELETE: o operador OLD.nome_coluna nos permite verificar o valor
   excluído ou a ser excluído. NEW.nome_coluna não está disponível.
   
   - UPDATE: tanto OLD.nome_coluna quanto NEW.nome_coluna estão 
   disponíveis, antes (BEFORE) ou depois (AFTER) da atualização de 
   uma linha.
*/
-- Exemplo de trigger
create trigger trExemplo before delete on tbEscola
for each row insert into tbBackup(nomeRecuperado, numeroRecuperado) 
values(old.nomeEscola, old.numeroEscola);

/*
**************************************************************************
Comandos básicos:
INSERT INTO NOME_DA_TABELA (CAMPOS_QUE_DESEJA_INSERIR_DADOS) 
VALUES (VALORES_DOS_CAMPOS)

UPDATE NOME_DA_TABELA SET campo1 = valor1, campo2 = valor2 WHERE id = 1;

DELETE FROM NOME_DA_TABELA WHERE id = VALOR_DO_ID;

SELECT * FROM NOME_DA_TABELA;

*Exemplo de replace(Trocando 'a' por 'a$a')								   
UPDATE NOME_DA_TABELA SET campo1 = replace( campo1, 'a', 'a$a' );		   
***************************************************************************
*/
insert into tbEscola(nomeEscola,numeroEscola) 
	values ('Etec','1'),('Drummond','2');

insert into tbAluno(nomeAluno, serieAluno, estudandoAluno)
	values ('Brenda', '2ID', true);

update tbEscola set nomeEscola = 'Camargo', numeroEscola = 1 where idEscola = 1;

delete from tbEscola where idEscola = 1;


select * from tbEscola;
select * from tbBackup;

desc tbAluno;
/* Utilizado para vizualizar a estrutura de uma tabela criada
Sintaxe: desc nome_da_tabela
*/

alter table tbAluno add teste varchar(255) not null;
/*
Serve para alterar a tabela depois de criada
Sintaxe: alter table (1) (2) (3);
Onde:
(1): Nome da tabela à ser alterada
(2): add(adicionar), drop(deletar) e change(alterar) a variavel de uma determinada coluna
*/