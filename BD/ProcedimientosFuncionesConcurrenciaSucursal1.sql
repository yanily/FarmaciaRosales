CREATE OR ALTER PROCEDURE AddFacturaDetalle(@idFactura int, @idProducto int, @costo int, @cantidad int, @subtotal int, @idFarmacia int)
AS

BEGIN
	BEGIN TRY
		BEGIN TRANSACTION;
		DECLARE @existencias INT;

		SELECT @existencias = existencias FROM SUCURSAL1.dbo.INVENTARIO WITH (HOLDLOCK)  WHERE idProducto = @idProducto;

		SET @existencias = @existencias - @cantidad;

		IF @existencias >= 0
		begin
			INSERT INTO DETALLEFACTURA VALUES (@idFactura, @idProducto, @costo, @cantidad, @subtotal, @idFarmacia);

			UPDATE SUCURSAL1.dbo.INVENTARIO SET existencias = @existencias WHERE idProducto = @idProducto;

			COMMIT TRANSACTION;
		end

		else
		begin
			COMMIT TRANSACTION;
			RAISERROR('CANTIDAD SUPERA EXISTENCIAS', 16, 1);
		end
	END TRY

	BEGIN CATCH
		;THROW
	END CATCH
	
END
GO

CREATE OR ALTER PROCEDURE ADDFACTURA(@idFactura int, @montototal decimal, @idEmpleado int, @tipoPago int, @correo varchar(50), @descuento int)
AS

BEGIN
	BEGIN TRY
		BEGIN TRANSACTION;
		SELECT * FROM FACTURAS WITH (TABLOCKX);

		INSERT INTO FACTURAS VALUES (@idFactura, GETDATE(), @montototal, @idEmpleado, 1, @tipoPago, @correo, @descuento, 13, 2);

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		;THROW
	END CATCH
END
GO

CREATE OR ALTER FUNCTION ConsultarExistencias(@cantidad int, @idProducto int)
RETURNS INT

AS
BEGIN
	DECLARE @existencias int,
			@resp int;

	SELECT @existencias = existencias from INVENTARIO where idProducto = @idProducto;

	SET @existencias = @existencias - @cantidad;

	IF @existencias >= 0
	BEGIN
		SET @resp = 0;
	END

	ELSE
	BEGIN
		SET @resp = 1;
	END

	RETURN @resp;

END
GO

CREATE OR ALTER PROCEDURE AddEmpleado(@idEmpleado int, @nombre varchar(50), @direccion varchar(50), @salario decimal, @rol varchar(50), @idFarmacia int,
	@correo varchar(50), @telefono varchar(50))
AS

BEGIN
	BEGIN TRY
		BEGIN TRANSACTION;
		SELECT * FROM EMPLEADOS WITH (TABLOCKX);

		INSERT INTO EMPLEADOS VALUES (@idEmpleado, @nombre, @direccion, @salario, @rol, @idFarmacia);
		INSERT INTO EMPLEADOS_CORREOS VALUES (@idEmpleado, @correo, @idFarmacia);
		INSERT INTO EMPLEADOS_TELEFONOS VALUES (@idEmpleado, @telefono, @idFarmacia);

		COMMIT TRANSACTION;
	END TRY

	BEGIN CATCH
		;THROW
	END CATCH
END
GO

