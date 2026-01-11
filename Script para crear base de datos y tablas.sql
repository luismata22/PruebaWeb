-- Crear la base de datos 
CREATE DATABASE PruebaWeb; 
GO

-- Crear la tabla de estado civil
CREATE TABLE ESTADOCIVIL(
	id_estado_civil INT IDENTITY(1,1) PRIMARY KEY,
	nombre VARCHAR(20) NOT NULL,
	ind_activo BIT NOT NULL DEFAULT 1
)

-- Insertar registros a la tabla de estado civil
INSERT INTO ESTADOCIVIL (nombre) VALUES
('Soltero'), ('Casado'), ('Divorciado'), ('Viudo')

-- Crear tabla de clientes
CREATE TABLE SEVECLIE (
	id_clie BIGINT IDENTITY(1,1) PRIMARY KEY,
	id_estado_civil INT NOT NULL REFERENCES ESTADOCIVIL(id_estado_civil),
	cedula VARCHAR(10) NOT NULL UNIQUE,
	nombre VARCHAR (100) NOT NULL,
	genero CHAR(1) NOT NULL,
	fecha_nac DATE NOT NULL
)