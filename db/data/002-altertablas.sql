-- Agregar la llave foránea de promoción_id en la tabla recargas
ALTER TABLE recargas ADD COLUMN promocion_id INT REFERENCES promociones(id);

-- Agregar la llave foránea de dispositivo_id en la tabla viajes
ALTER TABLE viajes ADD COLUMN dispositivo_id INT REFERENCES dispositivos(id);
