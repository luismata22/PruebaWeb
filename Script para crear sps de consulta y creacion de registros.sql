--Sp para consultar clientes por id
USE [PruebaWeb]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spConsultarClienteSEVECLIE]
    @id_clie BIGINT = -1
AS
BEGIN
    SELECT 
        s.id_clie, 
        s.cedula, 
        s.nombre, 
        s.genero, 
        s.fecha_nac, 
        s.id_estado_civil,
        ec.nombre AS estado_civil
    FROM SEVECLIE s
    INNER JOIN ESTADOCIVIL ec ON ec.id_estado_civil = s.id_estado_civil
    WHERE 
        (s.id_clie = @id_clie)
    ORDER BY 
        s.nombre;
END

-- Sp para consultar estados civiles
USE [PruebaWeb]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spConsultarEstadoCivil]
AS
BEGIN
    SELECT 
        id_estado_civil, 
        nombre 
    FROM 
        EstadoCivil 
    WHERE 
        ind_activo = 1 
    ORDER BY 
        nombre;
END

--Sp para consultar clientes mediante filtros
USE [PruebaWeb]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spConsultarSEVECLIE]
    @cedula VARCHAR(20) = NULL,
    @nombre VARCHAR(100) = NULL,
    @genero VARCHAR(1) = NULL,
    @idestadocivil int = -1
AS
BEGIN
    SELECT 
        s.id_clie, 
        s.cedula, 
        s.nombre, 
        s.genero, 
        s.fecha_nac, 
        s.id_estado_civil,
        ec.nombre AS estado_civil
    FROM SEVECLIE s
    INNER JOIN ESTADOCIVIL ec ON ec.id_estado_civil = s.id_estado_civil
    WHERE 
        (@cedula IS NULL OR s.cedula LIKE '%' + @cedula + '%')
      AND (@nombre IS NULL OR s.nombre LIKE '%' + @nombre + '%')
      AND (@genero IS NULL OR @genero = '' OR s.genero = @genero)
      AND (@idestadocivil = -1 OR s.id_estado_civil = @idestadocivil)
    ORDER BY 
        s.nombre;
END

-- Sp para eliminar Clientes mediante id
USE [PruebaWeb]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spEliminarSEVECLIE]
    @id_clie INT
AS
BEGIN
    BEGIN TRY
        DELETE FROM SEVECLIE WHERE id_clie=@id_clie;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000),
                @ErrorSeverity INT,
                @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();
        
        SELECT -1 AS id_clie, @ErrorMessage AS Error
    END CATCH
END

-- Sp para crear y modificar clientes
USE [PruebaWeb]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spInsertarModificarSEVECLIE]
    @id_clie BIGINT,
    @id_estado_civil INT,
    @cedula VARCHAR(20),
    @nombre VARCHAR(100),
    @genero CHAR(1),
    @fecha_nac DATE
AS
BEGIN
    BEGIN TRY
        IF(@id_clie = -1)
        BEGIN
            INSERT INTO SEVECLIE (cedula, nombre, genero, fecha_nac, id_estado_civil)
            VALUES (@cedula, @nombre, @genero, @fecha_nac, @id_estado_civil);
            SELECT SCOPE_IDENTITY() AS id_clie;
        END 
        ELSE
        BEGIN
            UPDATE SEVECLIE
            SET cedula=@cedula, 
                nombre=@nombre, 
                genero=@genero,
                fecha_nac=@fecha_nac, 
                id_estado_civil=@id_estado_civil
            WHERE id_clie=@id_clie;
            SELECT @id_clie;
        END
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000),
                @ErrorSeverity INT,
                @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();
        
        SELECT -1 AS id_clie, @ErrorMessage AS Error
    END CATCH
END
