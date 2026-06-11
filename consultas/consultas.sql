---

-- CONSULTA 1: Mostrar todos los productos registrados
-- Permite visualizar el catálogo completo disponible en NexShop.
-- Resulta útil para comprobar que los productos han sido
-- almacenados correctamente en la base de datos.

---

SELECT * FROM producto;

---

-- CONSULTA 2: Nombre y correo electrónico de los clientes
-- Muestra únicamente los datos básicos de contacto de los clientes
-- registrados, evitando mostrar información innecesaria para esta
-- consulta.

---

SELECT nombre, email
FROM cliente;

---

-- CONSULTA 3: Pedidos pendientes de procesar
-- Recupera todos los pedidos cuyo estado es pendiente.
-- Esta información permite identificar las compras que todavía
-- no han comenzado su proceso de preparación o envío.

---

SELECT *
FROM pedido_online
WHERE estado = 'pendiente';

---

-- CONSULTA 4: Búsqueda de productos por palabra clave
-- Localiza los productos cuyo nombre contiene la cadena 'HP'.
-- Este tipo de búsqueda es habitual cuando un cliente desea
-- encontrar artículos de una marca concreta.

---

SELECT *
FROM producto
WHERE nombre LIKE '%HP%';

---

-- CONSULTA 5: Clientes cuyo nombre comienza por una letra
-- Muestra los clientes cuyo nombre empieza por la letra M.
-- Permite realizar filtrados rápidos sobre campos de texto.

---

SELECT *
FROM cliente
WHERE nombre LIKE 'M%';

---

-- CONSULTA 6: Pedidos realizados en un intervalo de fechas
-- Recupera los pedidos efectuados entre dos fechas concretas.
-- Puede utilizarse para analizar la actividad comercial durante
-- un periodo determinado.

---

SELECT *
FROM pedido_online
WHERE fecha_pedido BETWEEN '2025-05-01'
AND '2025-05-08 23:59:59';

---

-- CONSULTA 7: Productos dentro de un rango de precios
-- Muestra los productos cuyo precio se encuentra entre
-- 100 y 900 euros.
-- Resulta útil para segmentar el catálogo según presupuesto.

---

SELECT *
FROM producto
WHERE pvp_actual BETWEEN 100 AND 900;

---

-- CONSULTA 8: Líneas de pedido con cantidades elevadas
-- Recupera las líneas de pedido cuya cantidad es superior
-- a una unidad.
-- Permite detectar compras de varios artículos del mismo producto.

---

SELECT *
FROM linea_pedido
WHERE cantidad > 1;

---

-- CONSULTA 9: Pedidos ordenados cronológicamente
-- Muestra los pedidos desde el más antiguo hasta el más reciente.
-- Facilita el seguimiento temporal de las compras realizadas.

---

SELECT *
FROM pedido_online
ORDER BY fecha_pedido ASC;

---

-- CONSULTA 10: Productos ordenados por precio descendente
-- Presenta los productos desde el más caro hasta el más económico.
-- Esta información permite identificar rápidamente los artículos
-- de mayor valor económico.

---

SELECT *
FROM producto
ORDER BY pvp_actual DESC;

---

-- CONSULTA 11: Clientes ordenados alfabéticamente
-- Organiza los registros de clientes siguiendo el orden alfabético
-- de sus nombres.
-- Mejora la localización y consulta de información.

---

SELECT *
FROM cliente
ORDER BY nombre ASC;

---

-- CONSULTA 12: Actualización del estado de un pedido
-- Modifica el estado de un pedido concreto para reflejar
-- un cambio en el proceso logístico.
-- Simula una operación habitual de gestión de pedidos.

---

UPDATE pedido_online
SET estado = 'enviado'
WHERE id_pedido = 4;

---

-- CONSULTA 13: Modificación de datos de un cliente
-- Actualiza el correo electrónico de un cliente identificado
-- mediante su clave primaria.
-- Permite mantener actualizada la información de contacto.

---

UPDATE cliente
SET email = '[marta.actualizada@email.com](mailto:marta.actualizada@email.com)'
WHERE id_cliente = 4;

---

-- CONSULTA 14: Relación entre clientes y pedidos online
-- Combina la información de clientes y pedidos mediante JOIN
-- para identificar qué usuario realizó cada compra y conocer
-- el estado e importe asociado a sus pedidos.

---

SELECT
c.nombre,
c.apellidos,
p.id_pedido,
p.estado,
p.total
FROM cliente c
INNER JOIN pedido_online p
ON c.id_cliente = p.id_cliente;
