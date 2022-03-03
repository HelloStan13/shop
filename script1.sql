/* Script 1  Mysql*/
/* Creacion de base y las tablas requeridas con las relaciones necesarias OK */

create database ourappsw_shop;

use ourappsw_shop;

CREATE TABLE config_table (
  id_table INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  list_depend TINYINT(0) NOT NULL,
  state TINYINT(1) NULL,
  create_time TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_table)) ENGINE = InnoDB;


CREATE TABLE config_data (
  id_data INT NOT NULL AUTO_INCREMENT,
  fk_config_table_id INT NOT NULL,
  name VARCHAR(100) NOT NULL,
  ref_id INT NOT NULL,
  state TINYINT(1) NULL,
  create_time TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_data), 
    FOREIGN KEY (fk_config_table_id)
    REFERENCES config_table (id_table)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION) ENGINE = InnoDB;

CREATE TABLE seller (
  id_sell INT NOT NULL AUTO_INCREMENT,
  fk_config_typedoc INT NOT NULL,
  number_doc VARCHAR(12) NOT NULL,
  name VARCHAR(100) NOT NULL,
  create_time TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_sell),
     FOREIGN KEY (fk_config_typedoc)
    REFERENCES config_data (id_data)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION) ENGINE = InnoDB;

CREATE TABLE client (
  id_client INT NOT NULL AUTO_INCREMENT,
  fk_config_typedoc INT NOT NULL,
  number_doc VARCHAR(12) NOT NULL,
  state TINYINT(1) NULL,
  create_time TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_client),  
    FOREIGN KEY (fk_config_typedoc)
    REFERENCES config_data (id_data)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)ENGINE = InnoDB;

CREATE TABLE supplier (
  id_supplier INT NOT NULL AUTO_INCREMENT,
  fk_config_typedoc INT NOT NULL,
  number_doc VARCHAR(12) NOT NULL,
  name VARCHAR(100) NOT NULL,
  state TINYINT(1) NULL,
  create_time TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_supplier), 
    FOREIGN KEY (fk_config_typedoc)
    REFERENCES config_data (id_data)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)ENGINE = InnoDB;

CREATE TABLE product (
  id_product INT NOT NULL AUTO_INCREMENT,
  fk_supplier_id INT NOT NULL,
  sku VARCHAR(45) NOT NULL,
  name VARCHAR(100) NOT NULL,
  price INT NOT NULL,
  state TINYINT(1) NULL,
  create_time TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_product),  
    FOREIGN KEY (fk_supplier_id)
    REFERENCES supplier (id_supplier)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)ENGINE = InnoDB;

CREATE TABLE invoice (
  id_invoice INT NOT NULL AUTO_INCREMENT,
  fk_client_id INT NOT NULL,
  fk_seller_id INT NOT NULL,
  total INT NOT NULL,
  state TINYINT(1) NULL,
  create_time TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_invoice),  
    FOREIGN KEY (fk_client_id)
    REFERENCES client (id_client)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (fk_seller_id)
    REFERENCES seller (id_sell)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)ENGINE = InnoDB;


CREATE TABLE product_invoice (
  id_product_invo INT NOT NULL AUTO_INCREMENT,
  fk_invoice_id INT NOT NULL,
  fk_product_id INT NOT NULL,
  sku VARCHAR(45) NOT NULL,
  amount INT NOT NULL,
  price INT NOT NULL,
  price_total INT NOT NULL,
  state TINYINT(1) NULL,
  create_time TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_product_invo),  
    FOREIGN KEY (fk_invoice_id)
    REFERENCES invoice (id_invoice)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (fk_product_id)
    REFERENCES product (id_product)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)ENGINE = InnoDB;
	
	/* Llenado de tablas con información previa para poder manipular la base de datos a nivel de datos */
	INSERT INTO config_table( name, list_depend, state) VALUES ('tipo_documento',0,1);
	
	INSERT INTO config_data( fk_config_table_id, name, ref_id, state) VALUES (1, 'Cedula de ciudadania',0,1),
	(1, 'Cedula de Extranjeria',0,1),
	(1, 'Passaporte',0,1),
	(1, 'Nit',0,1),
	(1, 'Otro',0,1);
	
	INSERT INTO seller(fk_config_typedoc, number_doc, name) VALUES (1,'1000333555','Julian Lasso');
	
	INSERT INTO client(fk_config_typedoc, number_doc, state) VALUES (1,'1088088088',1),
	(2,'135628',1),
	(1,'1089089089',1),
	(1,'1056056056',1),
	(1,'1078078078',1);
	
	
	INSERT INTO supplier(fk_config_typedoc, number_doc, name, state) VALUES (4,'8914444444','Ibay',1),
	(4,'891555555','Multiservice SAS',1),
	(4,'891666666','DotaWeb SAS',1),
	(4,'891777777','Industrias SAS',1),
	(4,'891999999','Web mas SAS',1);
	
	
	INSERT INTO invoice(fk_client_id, fk_seller_id, total, state) VALUES (1,1,700000,1),
	(2,1,805000,1),
	(1,1,900000,1),
	(3,1,70000,1),
	(4,1,1005000,1),
	(5,1,800000,1),
	(1,1,235000,1),
	(4,1,160000,1),
	(2,1,80000,1),
	(3,1,1600000,1);
    
    INSERT INTO product ( fk_supplier_id, sku, name, price, state) VALUES
( 1, '2-01', 'Monitor 20', 700000, 1),
( 2, '2-02', 'Monitor 20', 700000, 1),
( 1, '2-03', 'Monitor 19', 600000, 1),
( 4, '2-04', 'Monitor 22 pulgadas', 800000, 1),
( 5, '2-05', 'Mouse ergonomico', 35000, 1),
( 4, '2-06', 'Camara Web-Cam hd1080', 200000, 1),
(1, '2-07', 'Teclado', 70000, 1),
( 2, '2-08', 'Diadema monoaural', 160000, 1),
(1, '2-09', 'Diadema sencilla', 80000, 1),
( 1, '2-10', 'Monitor 23.5', 900000, 1);
	
	INSERT INTO product_invoice(fk_invoice_id,fk_product_id,sku,amount,price,price_total,state) VALUES 
	(1,1,'2-01',1,700000,700000,1),
	(2,1,'2-01',1,700000,700000,1),
	(2,5,'2-05',1,35000,35000,1),
	(2,7,'2-07',1,70000,70000,1),
	(3,10,'2-10',1,900000,900000,1),
	(4,7,'2-07',1,70000,70000,1),
	(5,5,'2-05',1,35000,35000,1),
	(5,10,'2-10',1,900000,900000,1),
	(5,7,'2-07',1,70000,70000,1),
	(6,4,'2-04',1,800000,800000,1),
	(7,5,'2-05',1,35000,35000,1),
	(7,6,'2-06',1,200000,200000,1),
	(8,8,'2-08',1,160000,160000,1),
	(9,9,'2-09',1,80000,80000,1),
	(10,1,'2-01',1,700000,700000,1),
	(10,10,'2-10',1,900000,900000,1);
		
	/*Borrado logico*/
	UPDATE invoice SET state=0 WHERE id_invoice=1 OR id_invoice=2;
	
	/*Borrado fisico*/
	
	DELETE FROM product_invoice WHERE fk_invoice_id =10 or fk_invoice_id=9;
	DELETE FROM invoice WHERE id_invoice=10 or id_invoice=9;
	
	/*Modificacion de tres productos en su nombre y proveedor que los provee. */
	
	UPDATE product SET fk_supplier_id=4, name='Monitor 22 pulgadas' WHERE id_product=4;
	UPDATE product SET fk_supplier_id=5, name='Mouse ergonomico' WHERE id_product=5;
	UPDATE product SET fk_supplier_id=4, name='Camara Web-Cam hd1080' WHERE id_product=6;
	