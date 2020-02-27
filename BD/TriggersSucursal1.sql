CREATE OR ALTER TRIGGER [dbo].[ACT_ELIM_EMP] ON SUCURSAL1.dbo.EMPLEADOS
AFTER UPDATE, DELETE, INSERT
AS
	declare @idEmpleado int;
	if exists(select * from inserted) and exists (SELECT * from deleted)
	begin
		select @idEmpleado = i.idEmpleado from inserted i;
		if exists (select idEmpleado from SUCURSAL1.dbo.EMP_ING_ACT_ELI where idEmpleado = @idEmpleado)
		begin
			update SUCURSAL1.dbo.EMP_ING_ACT_ELI set tipo = 'A' where idEmpleado = @idEmpleado;
		end
		else
		begin
			insert into SUCURSAL1.dbo.EMP_ING_ACT_ELI values (@idEmpleado, 'A');
		end
	end
	if exists(select * from deleted) and not exists(Select * from inserted)
	begin
		select @idEmpleado = i.idEmpleado from deleted i;
		if exists (select idEmpleado from SUCURSAL1.dbo.EMP_ING_ACT_ELI where idEmpleado = @idEmpleado)
		begin
			update SUCURSAL1.dbo.EMP_ING_ACT_ELI set tipo = 'D' where idEmpleado = @idEmpleado;
		end
		else
		begin
			insert into SUCURSAL1.dbo.EMP_ING_ACT_ELI values (@idEmpleado, 'D');
		end
	end
	if exists (select * from inserted) and not exists(select * from deleted)
	begin
		select @idEmpleado = i.idEmpleado from inserted i;
		insert into SUCURSAL1.dbo.EMP_ING_ACT_ELI values (@idEmpleado, 'I');
	end
GO

CREATE OR ALTER TRIGGER [dbo].[ACT_ELIM_EMP_CO] ON SUCURSAL1.dbo.EMPLEADOS_CORREOS
AFTER  DELETE, INSERT
AS
	declare @idEmpleado int,
			@correo varchar(50);
	if exists(select * from deleted) and not exists(Select * from inserted)
	begin
		select @idEmpleado = i.idEmpleado, @correo = i.correo from deleted i;
		if exists (select idEmpleado from SUCURSAL1.dbo.EMP_CORREO_ING_ACT_ELI where idEmpleado = @idEmpleado and correo = @correo)
		begin
			update SUCURSAL1.dbo.EMP_CORREO_ING_ACT_ELI set tipo = 'D' where idEmpleado = @idEmpleado and correo = @correo;
		end
		else
		begin
			insert into SUCURSAL1.dbo.EMP_CORREO_ING_ACT_ELI values (@idEmpleado, @correo, 'D');
		end
	end
	if exists (select * from inserted) and not exists(select * from deleted)
	begin
		select @idEmpleado = i.idEmpleado, @correo = i.correo from inserted i;
		insert into SUCURSAL1.dbo.EMP_CORREO_ING_ACT_ELI values (@idEmpleado, @correo, 'I');
	end
GO

CREATE OR ALTER TRIGGER [dbo].[ACT_ELIM_EMP_TEL] ON SUCURSAL1.dbo.EMPLEADOS_TELEFONOS
AFTER DELETE, INSERT
AS
	declare @idEmpleado int,
			@telefono varchar(20);
	if exists(select * from deleted) and not exists(Select * from inserted)
	begin
		select @idEmpleado = i.idEmpleado, @telefono = i.telefono from deleted i;
		if exists (select idEmpleado from SUCURSAL1.dbo.EMP_TEL_ING_ACT_ELI where idEmpleado = @idEmpleado and telefono = @telefono)
		begin
			update SUCURSAL1.dbo.EMP_TEL_ING_ACT_ELI set tipo = 'D' where idEmpleado = @idEmpleado and telefono = @telefono;
		end
		else
		begin
			insert into SUCURSAL1.dbo.EMP_TEL_ING_ACT_ELI values (@idEmpleado, @telefono, 'D');
		end
	end
	if exists (select * from inserted) and not exists(select * from deleted)
	begin
		select @idEmpleado = i.idEmpleado, @telefono = i.telefono from inserted i;
		insert into SUCURSAL1.dbo.EMP_TEL_ING_ACT_ELI values (@idEmpleado, @telefono, 'I');
	end
GO

CREATE OR ALTER TRIGGER [dbo].[ACT_ELIM_EMP_FAC] ON SUCURSAL1.dbo.FACTURAS
AFTER UPDATE, DELETE, INSERT
AS
	declare @idFactura int;
	if exists(select * from inserted) and exists (SELECT * from deleted)
	begin
		select @idFactura = i.idFactura from inserted i;
		if exists (select idFactura from SUCURSAL1.dbo.FACT_ING_ACT_ELI where idFactura = @idFactura)
		begin
			update SUCURSAL1.dbo.FACT_ING_ACT_ELI set tipo = 'A' where idFactura = @idFactura;
		end

		else
		begin
			insert into SUCURSAL1.dbo.FACT_ING_ACT_ELI values (@idFactura, 'A');
		end
	end
	if exists(select * from deleted) and not exists(Select * from inserted)
	begin
		select @idFactura = i.idFactura from deleted i;
		if exists (select idFactura from SUCURSAL1.dbo.FACT_ING_ACT_ELI where idFactura = @idFactura)
		begin
			update SUCURSAL1.dbo.FACT_ING_ACT_ELI set tipo = 'D' where idFactura = @idFactura;
		end
		else
		begin
			insert into SUCURSAL1.dbo.FACT_ING_ACT_ELI values (@idFactura, 'D');
		end
	end
	if exists (select * from inserted) and not exists(select * from deleted)
	begin
		select @idFactura = i.idFactura from inserted i;
		insert into SUCURSAL1.dbo.FACT_ING_ACT_ELI values (@idFactura, 'I');
	end
GO

CREATE OR ALTER TRIGGER [dbo].[ACT_ELIM_EMP_DET_FAC] ON SUCURSAL1.dbo.DETALLEFACTURA
AFTER UPDATE, DELETE, INSERT
AS
	declare @idFactura int,
			@idProducto int;
	if exists(select * from inserted) and exists (SELECT * from deleted)
	begin
		select @idFactura = i.idFactura, @idFactura = i.idProducto from inserted i;
		if exists (select idFactura from SUCURSAL1.dbo.DET_FACT_ING_ACT_ELI where idFactura = @idFactura and idProducto = @idProducto)
		begin
			update SUCURSAL1.dbo.DET_FACT_ING_ACT_ELI set tipo = 'D' where idFactura = @idFactura and idProducto = @idProducto;
		end
		else
		begin
			insert into SUCURSAL1.dbo.DET_FACT_ING_ACT_ELI values (@idFactura, @idProducto, 'A');
		end
	end
	if exists(select * from deleted) and not exists(Select * from inserted)
	begin
		select @idFactura = i.idFactura, @idProducto = i.idProducto from deleted i;
		if exists (select idFactura from SUCURSAL1.dbo.DET_FACT_ING_ACT_ELI where idFactura = @idFactura and idProducto = @idProducto)
		begin
			update SUCURSAL1.dbo.DET_FACT_ING_ACT_ELI set tipo = 'D' where idFactura = @idFactura and idProducto = @idProducto;
		end
		else
		begin
			insert into SUCURSAL1.dbo.DET_FACT_ING_ACT_ELI values (@idFactura, @idProducto, 'D');
		end
	end
	if exists (select * from inserted) and not exists(select * from deleted)
	begin
		select @idFactura = i.idFactura, @idProducto = i.idProducto from inserted i;
		insert into SUCURSAL1.dbo.DET_FACT_ING_ACT_ELI values (@idFactura, @idProducto, 'I');
	end
GO

CREATE OR ALTER TRIGGER EstadoInventario on SUCURSAL1.dbo.INVENTARIO
AFTER UPDATE
AS
BEGIN
	DECLARE @existencias int,
			@idProducto int,
			@estado char(1);

	SELECT @existencias = existencias, @idProducto = idProducto, @estado = estado from inserted;

	IF @existencias = 0 and @estado = 'A'
	BEGIN
		UPDATE SUCURSAL1.dbo.INVENTARIO SET estado = 'I' where idProducto = @idProducto;
		UPDATE ROBERT.CENTRAL.dbo.INVENTARIO SET estado = 'I' where idProducto = @idProducto;
	END

	ELSE IF @estado > 0 and @estado = 'I'
	BEGIN
		UPDATE SUCURSAL1.dbo.INVENTARIO SET estado = 'A' where idProducto = @idProducto;
		UPDATE ROBERT.CENTRAL.dbo.INVENTARIO SET estado = 'A' where idProducto = @idProducto;
	END
END
GO