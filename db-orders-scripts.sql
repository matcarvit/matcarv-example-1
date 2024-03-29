---------------- MICROSERVIÇOS DE PEDIDOS ------------------
CREATE SCHEMA ORDERS;

--DROP CASCADE--
DROP TABLE IF EXISTS ORDER_ITEMS CASCADE;
DROP TABLE IF EXISTS ORDER_ITEMS_AUD CASCADE;
DROP TABLE IF EXISTS ORDERS CASCADE;
DROP TABLE IF EXISTS ORDERS_AUD CASCADE;
DROP TABLE IF EXISTS REVINFO CASCADE;

--PEDIDOS--
CREATE TABLE ORDERS (
	ID_ORDER VARCHAR(255) NOT NULL, 
	ORDER_DATE DATE NOT NULL, 
	ORDER_STATUS_TYPE VARCHAR(255) NOT NULL, 
	PRIMARY KEY (ID_ORDER)
);

CREATE TABLE ORDERS_AUD (
	ID_ORDER VARCHAR(255) NOT NULL, 
	REV INTEGER NOT NULL, 
	REVTYPE TINYINT, 
	ORDER_DATE DATE NOT NULL, 
	ORDER_STATUS_TYPE VARCHAR(255), 
	PRIMARY KEY (ID_ORDER, REV)
);

--ITENS DO PEDIDO--
CREATE TABLE ORDER_ITEMS (
	ID_ORDER_ITEM VARCHAR(255) NOT NULL, 
	ORDER_STATUS_TYPE VARCHAR(255) NOT NULL, 
	ID_PRODUCT VARCHAR(255) NOT NULL,
	PRODUCT_DESCRIPTION VARCHAR(255) NOT NULL, 
	QUANTITY DECIMAL(7,3) NOT NULL, 
	ID_ORDER VARCHAR(255) NOT NULL, 
	PRIMARY KEY (ID_ORDER_ITEM)
);

CREATE TABLE ORDER_ITEMS_AUD (
	ID_ORDER_ITEM VARCHAR(255) NOT NULL, 
	REV INTEGER NOT NULL, 
	REVTYPE TINYINT, 
	ORDER_STATUS_TYPE VARCHAR(255), 
	PRODUCT_DESCRIPTION VARCHAR(255), 
	ID_PRODUCT VARCHAR(255), 
	QUANTITY DECIMAL(7,3), 
	PRIMARY KEY (ID_ORDER_ITEM, REV)
);

ALTER TABLE ORDER_ITEMS ADD CONSTRAINT FKJ18EF1AGDHKB3F8RMGRRGDBVU FOREIGN KEY (ID_ORDER) REFERENCES ORDERS;

--AUDIT--
CREATE TABLE REVINFO (
	REV INTEGER GENERATED BY DEFAULT AS IDENTITY, 
	REVTSTMP BIGINT, PRIMARY KEY (REV)
);

ALTER TABLE ORDERS_AUD ADD CONSTRAINT FKINUJAB7LJKELFLU16C9JJCH19 FOREIGN KEY (REV) REFERENCES REVINFO;
ALTER TABLE ORDER_ITEMS_AUD ADD CONSTRAINT FKP1DP41JYQ8K6SHC0ICIHXXVW7 FOREIGN KEY (REV) REFERENCES REVINFO;