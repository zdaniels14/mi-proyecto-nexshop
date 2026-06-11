USE nexshop;

-- SEDES
INSERT INTO sede (nombre,tipo,ciudad,direccion) VALUES
('Madrid Centro','tienda','Madrid','Gran Via 120'),
('Barcelona Diagonal','tienda','Barcelona','Av. Diagonal 350'),
('Valencia Centro','tienda','Valencia','Calle Colon 45'),
('Almacen Central','almacen','Valencia','Poligono Norte');

-- CATEGORIAS
INSERT INTO categoria (nombre,id_categoria_padre) VALUES
('Informatica',NULL),
('Perifericos',NULL),
('Portatiles',1),
('Sobremesa',1),
('Teclados',2),
('Ratones',2);

-- CLIENTES
INSERT INTO cliente VALUES
(1,'Carlos','Martin Lopez','carlos@email.com','hash1','1995-03-12',1,'2025-01-15 10:00:00'),
(2,'Laura','Sanchez Ruiz','laura@email.com','hash2','1998-07-21',1,'2025-02-10 12:30:00'),
(3,'David','Fernandez Gil','david@email.com','hash3','1990-11-05',1,'2025-03-08 16:20:00'),
(4,'Marta','Perez Gomez','marta@email.com','hash4','2000-01-18',1,'2025-04-01 09:10:00');

-- DIRECCIONES
INSERT INTO direccion VALUES
(1,1,'domicilio','Alcala','15','3A','28001','Madrid','España'),
(2,1,'trabajo','Serrano','120','2B','28006','Madrid','España'),
(3,2,'domicilio','Aragon','87','1C','08015','Barcelona','España'),
(4,3,'domicilio','Blasco Ibañez','54','4D','46021','Valencia','España'),
(5,4,'domicilio','Princesa','18','2A','28008','Madrid','España');

-- EMPLEADOS
INSERT INTO empleado VALUES
(1,'Javier','Moreno Ruiz','12345678A','javier@nexshop.com','2023-01-10',1,'Vendedor'),
(2,'Ana','Gil Martin','23456789B','ana@nexshop.com','2023-02-15',2,'Vendedor'),
(3,'Pedro','Lopez Diaz','34567890C','pedro@nexshop.com','2022-11-01',3,'Encargado'),
(4,'Lucia','Garcia Torres','45678901D','lucia@nexshop.com','2024-01-05',4,'Logistica'),
(5,'Sergio','Navarro Ruiz','56789012E','sergio@nexshop.com','2021-09-12',4,'Administrador');

-- PRODUCTOS
INSERT INTO producto VALUES
(1,'Lenovo ThinkPad E14','Portatil profesional',849.99,3,1),
(2,'HP Pavilion 15','Portatil multimedia',749.99,3,1),
(3,'PC Gaming Ryzen 7','Sobremesa gaming',1299.99,4,1),
(4,'Logitech G502','Raton gaming',59.99,6,1),
(5,'Corsair K70 RGB','Teclado mecanico',139.99,5,1),
(6,'HP 290 G9','PC oficina',699.99,4,1);

INSERT INTO proveedor VALUES
(1,'TechDistribucion SL','ventas@techdist.es','961111111',5),
(2,'Global Hardware','contacto@globalhw.es','931234567',5),
(3,'Informatica Europa','compras@infoeuropa.es','914567890',3);

INSERT INTO historial_precio VALUES
(1,1,899.99,'2024-01-01','2025-01-01'),
(2,1,849.99,'2025-01-02',NULL),
(3,2,799.99,'2024-06-01','2025-02-01'),
(4,2,749.99,'2025-02-02',NULL),
(5,3,1399.99,'2024-01-01','2025-03-01'),
(6,3,1299.99,'2025-03-02',NULL);

INSERT INTO promocion VALUES
(1,1,10,'2025-06-01','2025-06-30','Promocion verano'),
(2,4,15,'2025-06-01','2025-06-30','Oferta gaming'),
(3,5,20,'2025-11-20','2025-11-30','Black Friday');

INSERT INTO condicion_proveedor VALUES
(1,1,1,620,5,'2025-01-01',NULL),
(2,1,2,540,5,'2025-01-01',NULL),
(3,2,3,980,7,'2025-01-01',NULL),
(4,2,4,35,4,'2025-01-01',NULL),
(5,3,5,90,6,'2025-01-01',NULL),
(6,3,6,500,8,'2025-01-01',NULL);

INSERT INTO pedido_online VALUES
(1,1,1,'2025-05-01 10:00:00','entregado',909.98,50),
(2,2,3,'2025-05-03 12:00:00','enviado',59.99,0),
(3,3,4,'2025-05-05 16:00:00','entregado',139.99,10),
(4,4,5,'2025-05-07 11:00:00','pendiente',699.99,0),
(5,1,2,'2025-05-10 18:00:00','cancelado',749.99,0);

INSERT INTO linea_pedido VALUES
(1,1,1,1,849.99,10),
(2,1,4,1,59.99,0),
(3,2,4,1,59.99,0),
(4,3,5,1,139.99,0),
(5,4,6,1,699.99,0),
(6,5,2,1,749.99,0);

INSERT INTO envio VALUES
(1,1,4,'TRK001','Correos','2025-05-05','2025-05-04','entregado'),
(2,2,4,'TRK002','SEUR','2025-05-07',NULL,'en_camino'),
(3,3,4,'TRK003','MRW','2025-05-08','2025-05-08','entregado'),
(4,4,4,'TRK004','Correos','2025-05-12',NULL,'preparando');

INSERT INTO linea_envio VALUES
(1,1,1,1),(2,1,4,1),
(3,2,4,1),
(4,3,5,1),
(5,4,6,1);

INSERT INTO venta_presencial VALUES
(1,1,1,1,'2025-05-02 13:00:00',59.99),
(2,2,2,2,'2025-05-04 17:00:00',139.99),
(3,3,3,NULL,'2025-05-06 12:00:00',699.99),
(4,1,1,3,'2025-05-08 18:00:00',849.99);

INSERT INTO linea_venta VALUES
(1,1,4,1,59.99),
(2,2,5,1,139.99),
(3,3,6,1,699.99),
(4,4,1,1,849.99);

INSERT INTO devolucion_presencial VALUES
(1,2,2,'2025-05-10 10:00:00','Teclado defectuoso',139.99),
(2,4,1,'2025-05-15 16:00:00','Cambio de modelo',849.99);

INSERT INTO stock_ubicacion VALUES
(1,1,1,8,NOW()),
(2,1,4,25,NOW()),
(3,2,4,15,NOW()),
(4,3,4,10,NOW()),
(5,4,1,30,NOW()),
(6,5,2,20,NOW()),
(7,6,3,12,NOW());

INSERT INTO transferencia_stock VALUES
(1,1,4,1,5,'2025-05-01 09:00:00',5),
(2,5,4,2,4,'2025-05-03 09:00:00',5),
(3,6,4,3,3,'2025-05-05 09:00:00',5);

INSERT INTO ticket_incidencia VALUES
(1,1,1,1,'Retraso pedido','Consulta estado','2025-05-02 10:00:00','resuelto','2025-05-03 09:00:00','Pedido localizado'),
(2,2,2,2,'Seguimiento','No aparece actualizacion','2025-05-05 11:00:00','en_gestion',NULL,NULL),
(3,3,3,NULL,'Consulta producto','Compatibilidad hardware','2025-05-06 12:00:00','abierto',NULL,NULL);

INSERT INTO valoracion VALUES
(1,1,1,5,'Excelente portatil','2025-05-10 10:00:00',1),
(2,2,4,4,'Muy buen raton','2025-05-11 12:00:00',1),
(3,3,5,5,'Teclado perfecto','2025-05-12 18:00:00',1),
(4,4,6,4,'Buen equipo oficina','2025-05-13 17:00:00',0);

INSERT INTO movimiento_puntos VALUES
(1,1,1,90,'ganado','2025-05-01 10:00:00','Compra online'),
(2,1,1,50,'canjeado','2025-05-01 10:00:00','Descuento aplicado'),
(3,2,2,6,'ganado','2025-05-03 12:00:00','Compra online'),
(4,3,3,14,'ganado','2025-05-05 16:00:00','Compra online');
