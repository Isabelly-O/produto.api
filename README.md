# Script de criação do bd (Postgres)
```
-- Database: ProdutoAPI

-- DROP DATABASE IF EXISTS "ProdutoAPI";

CREATE DATABASE "ProdutoAPI"
	WITH
	OWNER = postgres
	ENCODING = 'UTF8'
	LC_COLLATE = 'Portuguese_Brazil.1252'
	LC_CTYPE = 'Portuguese_Brazil.1252'
	LOCALE_PROVIDER = 'libc'
	TABLESPACE = pg_default
	CONNECTION LIMIT = -1
	IS_TEMPLATE = False;
```
# Script de criação da tabela produtos (Postgres)
```
-- Table: public.produtos

-- DROP TABLE IF EXISTS public.produtos;

CREATE TABLE IF NOT EXISTS public.produtos
(
	id integer NOT NULL DEFAULT nextval('produtos_id_seq'::regclass),
	descricao text COLLATE pg_catalog."default" NOT NULL,
	preco numeric(10,2) NOT NULL,
	estoque integer DEFAULT 0,
	data timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT produtos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.produtos
	OWNER to postgres;
```
# Script de colonização (Postgres)
```
INSERT INTO public.produtos (descricao, preco, estoque) VALUES ('Produto A', 29.99, 100), ('Produto B', 15.50, 200), ('Produto C', 45.00, 50), ('Produto D', 5.99, 300), ('Produto E', 99.95, 25);
```