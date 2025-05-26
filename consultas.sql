/*Cantidad de cambios de estado por mes durante el último año*/
SELECT extract(MONTH FROM fecha) AS mes, count(*) AS total_cambios
FROM auditoria_estado_tarjeta
WHERE EXTRACT(YEAR FROM fecha)=2025
GROUP BY extract (MONTH FROM fecha)
ORDER BY mes ASC; 

/*Las 5 tarjetas con mayor número de cambios de estado*/
SELECT tarjeta_id, count(*) AS total_cambios
FROM auditoria_estado_tarjeta
GROUP BY tarjeta_id
ORDER BY count(*) DESC LIMIT 5;

/*Recargas con descripción de la promoción aplicada*/
SELECT p.descripcion, count(r.recarga_id) AS total
FROM recargas r
JOIN promociones p 
ON r.promocion_id = p.id
GROUP BY p.descripcion;

/*Monto total recargado por cada tipo de promoción en los últimos 3 meses*/
SELECT p.tipo, sum(r.monto) AS total_recargado
FROM recargas r
JOIN promociones p
ON r.promocion_id = p.id
WHERE extract (MONTH FROM fecha) >2
GROUP BY p.tipo;

/*Promociones cuyo nombre contenga la palabra "bonus"*/
SELECT * FROM promociones 
WHERE nombre ilike '%bonus%'

/*Viajes sin registro de validación*/
SELECT d.tipo, count(*) AS total_sin_registro
FROM viajes v
JOIN dispositivos d
ON v.dispositivo_id = d.id
WHERE d.tipo ilike '%sin%'
GROUP BY d.tipo;

/*Validaciones realizadas por dispositivos de tipo móvil en abril de 2025*/
SELECT d.tipo, count(*) AS total_validaciones
FROM viajes v
JOIN dispositivos d 
ON v.dispositivo_id = d.id
WHERE extract(MONTH FROM v.fecha)= 4 AND extract(YEAR FROM v.fecha)=2025 AND d.tipo ilike '%móvil%'
GROUP BY d.tipo;

/* Comprobación de validaciones en abril*/ 
SELECT extract(MONTH FROM fecha), count(*)
FROM viajes
WHERE extract(YEAR FROM fecha)=2025
GROUP BY extract(MONTH FROM fecha);

/*Dispositivo con mayor cantidad de validaciones*/
SELECT d.tipo, count(*) AS total_validaciones
FROM viajes v
JOIN dispositivos d
ON v.dispositivo_id = d.id
GROUP BY d.tipo
ORDER BY total_validaciones DESC LIMIT 1;

/*Total recargado por tarjeta (últimos 3 meses)*/
SELECT tarjeta_id, sum(monto) AS total_recargado
FROM movimientos_saldo
WHERE tipo_movimiento = 'recarga' AND extract (MONTH FROM fecha) >2
GROUP BY tarjeta_id
ORDER BY total_recargado DESC;

/*Historial de saldo con nombre del usuario*/
SELECT u.nombre, u.apellido, ms. fecha, ms.tipo_movimiento, ms.monto, ms.descripcion
FROM movimientos_saldo ms
JOIN tarjetas t 
ON ms.tarjeta_id = t.tarjeta_id
JOIN usuarios u 
ON t.usuario_id = u.usuario_id
ORDER BY ms.fecha DESC;

/*Tarjetas con más viajes y su saldo gastado en viajes*/
SELECT ms.tarjeta_id, count(*) AS total_viajes, sum(ms.monto) AS saldo_actual
FROM movimientos_saldo ms
JOIN tarjetas t
ON ms.tarjeta_id = t.tarjeta_id
WHERE ms.tipo_movimiento = 'viaje'
GROUP BY ms.tarjeta_id
ORDER by total_viajes DESC LIMIT 5;
