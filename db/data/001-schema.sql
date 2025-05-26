CREATE TABLE USUARIOS (
    usuario_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    numero_celular VARCHAR(20),
    fecha_nacimiento DATE,
    direccion_residencia VARCHAR(255),
    numero_cedula VARCHAR(50),
    ciudad_nacimiento VARCHAR(100),
    departamento_nacimiento VARCHAR(100),
    fecha_registro DATE,
    genero CHAR(1),
    correo_electronico VARCHAR(100),
    contraseña VARCHAR(100),
    foto_perfil VARCHAR(500),
    estado VARCHAR(50),
    tipo varchar(50),
    fecha_actualizacion VARCHAR(50),
    acepta_terminos CHAR(1)
);

CREATE TABLE TARJETAS (
    tarjeta_id SERIAL PRIMARY KEY,
    usuario_id INTEGER REFERENCES USUARIOS(usuario_id),
    fecha_adquisicion DATE,
    estado VARCHAR(50),
    fecha_actualizacion DATE,
    fecha_caducidad varchar(50),
    tipo varchar(50)
);

CREATE TABLE LOCALIDADES (
    localidad_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100)
);


CREATE TABLE PUNTOS_RECARGA (
    punto_recarga_id SERIAL PRIMARY KEY,
    direccion VARCHAR(255),
    latitud FLOAT,
    longitud FLOAT,
    localidad_id INTEGER REFERENCES LOCALIDADES(localidad_id)
);

CREATE TABLE TARIFAS (
    tarifa_id SERIAL PRIMARY KEY,
    valor FLOAT,
    fecha DATE
);

CREATE TABLE RECARGAS (
    recarga_id SERIAL PRIMARY KEY,
    fecha DATE,
    monto FLOAT,
    punto_recarga_id INTEGER REFERENCES PUNTOS_RECARGA(punto_recarga_id),
    tarjeta_id INTEGER REFERENCES TARJETAS(tarjeta_id)
);

CREATE TABLE ESTACIONES (
    estacion_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    direccion VARCHAR(255),
    localidad_id INTEGER REFERENCES LOCALIDADES(localidad_id),
    latitud FLOAT,
    longitud FLOAT
);

CREATE TABLE RUTAS (
    ruta_id SERIAL PRIMARY KEY,
    estacion_origen_id INTEGER REFERENCES ESTACIONES(estacion_id),
    estacion_destino_id INTEGER REFERENCES ESTACIONES(estacion_id)
);

CREATE TABLE ESTACIONES_INTERMEDIAS (
    estacion_id INTEGER,
    ruta_id INTEGER,
    PRIMARY KEY (estacion_id, ruta_id),
    FOREIGN KEY (estacion_id) REFERENCES ESTACIONES(estacion_id),
    FOREIGN KEY (ruta_id) REFERENCES RUTAS(ruta_id)
);

CREATE TABLE VIAJES (
    viaje_id SERIAL PRIMARY KEY,
    estacion_abordaje_id INTEGER REFERENCES ESTACIONES(estacion_id),
    fecha DATE,
    tarifa_id INTEGER REFERENCES TARIFAS(tarifa_id),
    tarjeta_id INTEGER REFERENCES TARJETAS(tarjeta_id)
);

-- Creación Nuevas Tablas

CREATE TABLE auditoria_estado_tarjeta (
    id SERIAL PRIMARY KEY,
    tarjeta_id INT REFERENCES tarjetas(tarjeta_id),
    estado_anterior VARCHAR(20),
    estado_nuevo VARCHAR(20),
    fecha TIMESTAMP
);

CREATE TABLE promociones (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT,
    tipo VARCHAR(30),
    fecha_inicio DATE,
    fecha_fin DATE
);

CREATE TABLE dispositivos (
    id SERIAL PRIMARY KEY,
    tipo VARCHAR(50),
    descripcion TEXT
);

CREATE TABLE movimientos_saldo (
    id SERIAL PRIMARY KEY,
    tarjeta_id INT NOT NULL REFERENCES tarjetas(tarjeta_id),
    tipo_movimiento VARCHAR(20) NOT NULL,
    monto FLOAT NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion TEXT
);
