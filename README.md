# NexShop Group S.A. — Base de Datos

## **Alumno:** Daniel Zanfaño García

## Descripción del proyecto

Diseño e implementación completa de la base de datos relacional para **NexShop Group S.A.**, una empresa de distribución y venta al por menor con sede en Valencia. El proyecto cubre el análisis de requisitos, modelado entidad-relación, modelo relacional, script SQL y batería de consultas.



## Sobre la empresa

NexShop Group S.A. opera bajo dos líneas de negocio: una tienda online (nexshop.es) y una red de tres tiendas físicas en Valencia, Madrid y Barcelona. Ambas líneas comparten el mismo catálogo de más de 2.000 productos pero funcionan con equipos independientes. La sede central de Valencia coordina la logística, los pedidos a proveedores y la reposición de stock en todas las ubicaciones.



## Estructura del repositorio

```
mi-proyecto-nexshop/
├── README.md
├── docs/
│   ├── memoria.pdf              # Análisis, entidades, relaciones y preguntas de reflexión
│   ├── diagrama\\\_er.png          # Diagrama Entidad-Relación completo
│   └── modelo\\\_relacional.pdf    # Modelo relacional con PKs, FKs y restricciones
├── sql/
│   ├── schema.sql               # CREATE TABLE con tipos, PKs, FKs y CHECK
│   └── datos.sql                # INSERT con datos de prueba realistas
└── consultas/
    └── consultas.sql            # 14 consultas comentadas
```



## Diagrama ER

https://github.com/zdaniels14/mi-proyecto-nexshop/blob/main/docs/diagrama_er.png



## Cómo importar la base de datos

### Requisitos

* MySQL 8.0 o superior
* MySQL Workbench o acceso por terminal

### Pasos

**Opción A — Terminal:**

```bash
# 1. Crear la base de datos
mysql -u root -p -e "CREATE DATABASE nexshop;"

# 2. Importar el esquema
mysql -u root -p nexshop < sql/schema.sql

# 3. Importar los datos de prueba
mysql -u root -p nexshop < sql/datos.sql
```

**Opción B — MySQL Workbench:**

1. Abre MySQL Workbench y conéctate a tu servidor
2. Ve a **Server → Data Import**
3. Selecciona **Import from Self-Contained File**
4. Importa primero `sql/schema.sql` y luego `sql/datos.sql`



## Cómo ejecutar las consultas

```bash
# Ejecutar todas las consultas de una vez
mysql -u root -p nexshop < consultas/consultas.sql

# O abre consultas/consultas.sql en MySQL Workbench y ejecútalas una a una
```



## Entidades principales del modelo

|Entidad|Descripción|
|-|-|
|SEDE|Tiendas físicas y almacén central|
|EMPLEADO|Personal con rol y sede asignada|
|PRODUCTO|Catálogo con historial de precios|
|CLIENTE|Registrados y anónimos (presenciales)|
|PEDIDO\_ONLINE|Compras online con envíos parciales|
|VENTA\_PRESENCIAL|Ventas en tienda física|
|PROVEEDOR|Proveedores con condiciones históricas|
|TICKET\_INCIDENCIA|Atención al cliente|
|MOVIMIENTO\_PUNTOS|Programa de fidelización|



## Tecnologías utilizadas

* **MySQL 8.0** — Motor de base de datos
* **MySQL Workbench** — Diseño y gestión
* **draw.io** — Diagrama ER



## 

