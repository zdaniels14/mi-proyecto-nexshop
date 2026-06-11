DROP DATABASE IF EXISTS nexshop;

CREATE DATABASE nexshop
CHARACTER SET utf8mb4
COLLATE utf8mb4_spanish_ci;

USE nexshop;

CREATE TABLE sede (
id_sede INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
tipo ENUM('tienda','almacen') NOT NULL,
ciudad VARCHAR(100) NOT NULL,
direccion VARCHAR(255)
);

CREATE TABLE categoria (
id_categoria INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
id_categoria_padre INT NULL,
CONSTRAINT fk_categoria_padre
FOREIGN KEY (id_categoria_padre)
REFERENCES categoria(id_categoria)
ON DELETE SET NULL
);

CREATE TABLE cliente (
id_cliente INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100),
apellidos VARCHAR(150),
email VARCHAR(150) UNIQUE,
password_hash VARCHAR(255),
fecha_nacimiento DATE,
registrado TINYINT(1) DEFAULT 0,
fecha_registro DATETIME
);

CREATE TABLE empleado (
id_empleado INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
apellidos VARCHAR(150) NOT NULL,
dni VARCHAR(20) NOT NULL UNIQUE,
email_corporativo VARCHAR(150) NOT NULL UNIQUE,
fecha_incorporacion DATE NOT NULL,
id_sede INT NOT NULL,
rol VARCHAR(50) NOT NULL,
CONSTRAINT fk_empleado_sede
FOREIGN KEY (id_sede)
REFERENCES sede(id_sede)
);

CREATE TABLE producto (
id_producto INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(200) NOT NULL,
descripcion TEXT,
pvp_actual DECIMAL(10,2) NOT NULL,
id_subcategoria INT NOT NULL,
activo TINYINT(1) DEFAULT 1,
CONSTRAINT fk_producto_categoria
FOREIGN KEY (id_subcategoria)
REFERENCES categoria(id_categoria)
);

CREATE TABLE direccion (
id_direccion INT AUTO_INCREMENT PRIMARY KEY,
id_cliente INT NOT NULL,
tipo ENUM('domicilio','trabajo','otra') NOT NULL,
calle VARCHAR(200) NOT NULL,
numero VARCHAR(10),
piso VARCHAR(20),
codigo_postal VARCHAR(10) NOT NULL,
ciudad VARCHAR(100) NOT NULL,
pais VARCHAR(100) NOT NULL,
CONSTRAINT fk_direccion_cliente
FOREIGN KEY (id_cliente)
REFERENCES cliente(id_cliente)
);

CREATE TABLE proveedor (
id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(150) NOT NULL,
email VARCHAR(150),
telefono VARCHAR(30),
id_representante INT,
CONSTRAINT fk_proveedor_representante
FOREIGN KEY (id_representante)
REFERENCES empleado(id_empleado)
);

CREATE TABLE historial_precio (
id_historial INT AUTO_INCREMENT PRIMARY KEY,
id_producto INT NOT NULL,
pvp DECIMAL(10,2) NOT NULL,
fecha_inicio DATE NOT NULL,
fecha_fin DATE,
CONSTRAINT fk_historial_producto
FOREIGN KEY (id_producto)
REFERENCES producto(id_producto)
);

CREATE TABLE promocion (
id_promocion INT AUTO_INCREMENT PRIMARY KEY,
id_producto INT NOT NULL,
descuento_porcentual DECIMAL(5,2) NOT NULL,
fecha_inicio DATE NOT NULL,
fecha_fin DATE NOT NULL,
descripcion VARCHAR(255),
CONSTRAINT fk_promocion_producto
FOREIGN KEY (id_producto)
REFERENCES producto(id_producto),
CONSTRAINT chk_descuento
CHECK (descuento_porcentual > 0 AND descuento_porcentual <= 100)
);

CREATE TABLE condicion_proveedor (
id_condicion INT AUTO_INCREMENT PRIMARY KEY,
id_proveedor INT NOT NULL,
id_producto INT NOT NULL,
precio_coste DECIMAL(10,2) NOT NULL,
plazo_entrega_dias INT NOT NULL,
fecha_inicio DATE NOT NULL,
fecha_fin DATE,
CONSTRAINT fk_condicion_proveedor
FOREIGN KEY (id_proveedor)
REFERENCES proveedor(id_proveedor),
CONSTRAINT fk_condicion_producto
FOREIGN KEY (id_producto)
REFERENCES producto(id_producto)
);

CREATE TABLE pedido_online (
id_pedido INT AUTO_INCREMENT PRIMARY KEY,
id_cliente INT NOT NULL,
id_direccion_entrega INT NOT NULL,
fecha_pedido DATETIME NOT NULL,
estado ENUM(
'pendiente',
'en_proceso',
'enviado',
'entregado',
'cancelado'
) NOT NULL,
total DECIMAL(10,2) NOT NULL,
puntos_descuento INT DEFAULT 0,
CONSTRAINT fk_pedido_cliente
FOREIGN KEY (id_cliente)
REFERENCES cliente(id_cliente),
CONSTRAINT fk_pedido_direccion
FOREIGN KEY (id_direccion_entrega)
REFERENCES direccion(id_direccion)
);

CREATE TABLE linea_pedido (
id_linea INT AUTO_INCREMENT PRIMARY KEY,
id_pedido INT NOT NULL,
id_producto INT NOT NULL,
cantidad INT NOT NULL,
precio_unitario DECIMAL(10,2) NOT NULL,
descuento_aplicado DECIMAL(5,2) DEFAULT 0,
CONSTRAINT fk_linea_pedido
FOREIGN KEY (id_pedido)
REFERENCES pedido_online(id_pedido),
CONSTRAINT fk_linea_producto
FOREIGN KEY (id_producto)
REFERENCES producto(id_producto),
CONSTRAINT chk_cantidad_pedido
CHECK (cantidad > 0)
);

CREATE TABLE envio (
id_envio INT AUTO_INCREMENT PRIMARY KEY,
id_pedido INT NOT NULL,
id_sede_origen INT NOT NULL,
numero_seguimiento VARCHAR(100) UNIQUE,
transportista VARCHAR(100),
fecha_estimada DATE,
fecha_entrega_real DATE,
estado ENUM(
'preparando',
'en_camino',
'entregado'
) NOT NULL,
CONSTRAINT fk_envio_pedido
FOREIGN KEY (id_pedido)
REFERENCES pedido_online(id_pedido),
CONSTRAINT fk_envio_sede
FOREIGN KEY (id_sede_origen)
REFERENCES sede(id_sede)
);

CREATE TABLE linea_envio (
id_linea_envio INT AUTO_INCREMENT PRIMARY KEY,
id_envio INT NOT NULL,
id_producto INT NOT NULL,
cantidad INT NOT NULL,
CONSTRAINT fk_linea_envio_envio
FOREIGN KEY (id_envio)
REFERENCES envio(id_envio),
CONSTRAINT fk_linea_envio_producto
FOREIGN KEY (id_producto)
REFERENCES producto(id_producto),
CONSTRAINT chk_cantidad_envio
CHECK (cantidad > 0)
);

CREATE TABLE venta_presencial (
id_venta INT AUTO_INCREMENT PRIMARY KEY,
id_sede INT NOT NULL,
id_empleado INT NOT NULL,
id_cliente INT NULL,
fecha_venta DATETIME NOT NULL,
total DECIMAL(10,2) NOT NULL,
CONSTRAINT fk_venta_sede
FOREIGN KEY (id_sede)
REFERENCES sede(id_sede),
CONSTRAINT fk_venta_empleado
FOREIGN KEY (id_empleado)
REFERENCES empleado(id_empleado),
CONSTRAINT fk_venta_cliente
FOREIGN KEY (id_cliente)
REFERENCES cliente(id_cliente)
);

CREATE TABLE linea_venta (
id_linea_venta INT AUTO_INCREMENT PRIMARY KEY,
id_venta INT NOT NULL,
id_producto INT NOT NULL,
cantidad INT NOT NULL,
precio_unitario DECIMAL(10,2) NOT NULL,
CONSTRAINT fk_linea_venta
FOREIGN KEY (id_venta)
REFERENCES venta_presencial(id_venta),
CONSTRAINT fk_linea_venta_producto
FOREIGN KEY (id_producto)
REFERENCES producto(id_producto),
CONSTRAINT chk_cantidad_venta
CHECK (cantidad > 0)
);

CREATE TABLE devolucion_presencial (
id_devolucion INT AUTO_INCREMENT PRIMARY KEY,
id_venta INT NOT NULL,
id_empleado INT NOT NULL,
fecha_devolucion DATETIME NOT NULL,
motivo TEXT,
total_devuelto DECIMAL(10,2) NOT NULL,
CONSTRAINT fk_devolucion_venta
FOREIGN KEY (id_venta)
REFERENCES venta_presencial(id_venta),
CONSTRAINT fk_devolucion_empleado
FOREIGN KEY (id_empleado)
REFERENCES empleado(id_empleado)
);

CREATE TABLE stock_ubicacion (
id_stock INT AUTO_INCREMENT PRIMARY KEY,
id_producto INT NOT NULL,
id_sede INT NOT NULL,
cantidad INT NOT NULL DEFAULT 0,
fecha_actualizacion DATETIME,
CONSTRAINT fk_stock_producto
FOREIGN KEY (id_producto)
REFERENCES producto(id_producto),
CONSTRAINT fk_stock_sede
FOREIGN KEY (id_sede)
REFERENCES sede(id_sede)
);

CREATE TABLE transferencia_stock (
id_transferencia INT AUTO_INCREMENT PRIMARY KEY,
id_producto INT NOT NULL,
id_sede_origen INT NOT NULL,
id_sede_destino INT NOT NULL,
cantidad INT NOT NULL,
fecha DATETIME NOT NULL,
id_empleado_autoriza INT NOT NULL,
CONSTRAINT fk_transferencia_producto
FOREIGN KEY (id_producto)
REFERENCES producto(id_producto),
CONSTRAINT fk_transferencia_origen
FOREIGN KEY (id_sede_origen)
REFERENCES sede(id_sede),
CONSTRAINT fk_transferencia_destino
FOREIGN KEY (id_sede_destino)
REFERENCES sede(id_sede),
CONSTRAINT fk_transferencia_empleado
FOREIGN KEY (id_empleado_autoriza)
REFERENCES empleado(id_empleado),
CONSTRAINT chk_transferencia_cantidad
CHECK (cantidad > 0)
);

CREATE TABLE ticket_incidencia (
id_ticket INT AUTO_INCREMENT PRIMARY KEY,
id_cliente INT NULL,
id_agente INT NOT NULL,
id_pedido INT NULL,
asunto VARCHAR(255) NOT NULL,
descripcion TEXT,
fecha_apertura DATETIME NOT NULL,
estado ENUM(
'abierto',
'en_gestion',
'resuelto'
) NOT NULL,
fecha_cierre DATETIME,
nota_resolucion TEXT,
CONSTRAINT fk_ticket_cliente
FOREIGN KEY (id_cliente)
REFERENCES cliente(id_cliente),
CONSTRAINT fk_ticket_agente
FOREIGN KEY (id_agente)
REFERENCES empleado(id_empleado),
CONSTRAINT fk_ticket_pedido
FOREIGN KEY (id_pedido)
REFERENCES pedido_online(id_pedido)
);

CREATE TABLE valoracion (
id_valoracion INT AUTO_INCREMENT PRIMARY KEY,
id_cliente INT NOT NULL,
id_producto INT NOT NULL,
puntuacion TINYINT NOT NULL,
comentario TEXT,
fecha DATETIME NOT NULL,
verificada TINYINT(1) NOT NULL DEFAULT 0,
UNIQUE (id_cliente, id_producto),
CONSTRAINT fk_valoracion_cliente
FOREIGN KEY (id_cliente)
REFERENCES cliente(id_cliente),
CONSTRAINT fk_valoracion_producto
FOREIGN KEY (id_producto)
REFERENCES producto(id_producto),
CONSTRAINT chk_valoracion
CHECK (puntuacion BETWEEN 1 AND 5)
);

CREATE TABLE movimiento_puntos (
id_movimiento INT AUTO_INCREMENT PRIMARY KEY,
id_cliente INT NOT NULL,
id_pedido INT NULL,
puntos INT NOT NULL,
tipo ENUM('ganado','canjeado') NOT NULL,
fecha DATETIME NOT NULL,
descripcion VARCHAR(255),
CONSTRAINT fk_movimiento_cliente
FOREIGN KEY (id_cliente)
REFERENCES cliente(id_cliente),
CONSTRAINT fk_movimiento_pedido
FOREIGN KEY (id_pedido)
REFERENCES pedido_online(id_pedido)
);