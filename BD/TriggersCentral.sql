USE [CENTRAL]
GO

CREATE OR ALTER TRIGGER [dbo].[CATEG_TRIG] ON CENTRAL.dbo.CATEGORIAS
AFTER UPDATE, DELETE, INSERT
AS
	declare @idCategoria int;
	if exists(select * from inserted) and exists (SELECT * from deleted)
	begin
		select @idCategoria = i.idCategoria from inserted i;
		if exists (select idCategoria from CENTRAL.dbo.CATEG_TEMP where idCategoria = @idCategoria)
		begin
			update CENTRAL.dbo.CATEG_TEMP set tipo = 'A' where idCategoria = @idCategoria;
		end
		else
		begin
			insert into CENTRAL.dbo.CATEG_TEMP values (@idCategoria, 'A');
		end
	end
	if exists(select * from deleted) and not exists(Select * from inserted)
	begin
		select @idCategoria = i.idCategoria from deleted i;
		if exists (select idCategoria from CENTRAL.dbo.CATEG_TEMP where idCategoria = @idCategoria)
		begin
			update CENTRAL.dbo.CATEG_TEMP set tipo = 'D' where idCategoria = @idCategoria;
		end
		else
		begin
			insert into CENTRAL.dbo.CATEG_TEMP values (@idCategoria, 'D');
		end
	end
	if exists (select * from inserted) and not exists(select * from deleted)
	begin
		select @idCategoria = i.idCategoria from inserted i;
		insert into CENTRAL.dbo.CATEG_TEMP values (@idCategoria, 'I');
	end
GO

CREATE OR ALTER TRIGGER [dbo].[INVENT_TRIG] ON CENTRAL.dbo.INVENTARIO
AFTER UPDATE, DELETE, INSERT
AS
	declare @idProducto int;
	if exists(select * from inserted) and exists (SELECT * from deleted)
	begin
		select @idProducto = i.idProducto from inserted i;
		if exists (select idProducto from CENTRAL.dbo.INVENT_TEMP where idProducto = @idProducto)
		begin
			update CENTRAL.dbo.INVENT_TEMP set tipo = 'A' where idProducto = @idProducto;
		end
		else
		begin
			insert into CENTRAL.dbo.INVENT_TEMP values (@idProducto, 'A');
		end
	end
	if exists(select * from deleted) and not exists(Select * from inserted)
	begin
		select @idProducto = i.idProducto from deleted i;
		if exists (select idProducto from CENTRAL.dbo.INVENT_TEMP where idProducto = @idProducto)
		begin
			update CENTRAL.dbo.INVENT_TEMP set tipo = 'D' where idProducto = @idProducto;
		end
		else
		begin
			insert into CENTRAL.dbo.INVENT_TEMP values (@idProducto, 'D');
		end
	end
	if exists (select * from inserted) and not exists(select * from deleted)
	begin
		select @idProducto = i.idProducto from inserted i;
		insert into CENTRAL.dbo.INVENT_TEMP values (@idProducto, 'I');
	end
GO

CREATE OR ALTER TRIGGER [dbo].[DET_INT_TRIGGER] ON CENTRAL.dbo.DETALLEINVENTARIO
AFTER DELETE, INSERT
AS
	declare @idProducto int,
			@idProveedor int;
	if exists(select * from deleted) and not exists(Select * from inserted)
	begin
		select @idProducto = i.idProducto, @idProveedor = i.idProveedor from deleted i;
		if exists (select idProducto from CENTRAL.dbo.DET_INV_TEMP where idProducto = @idProducto and idProveedor = @idProveedor)
		begin
			update CENTRAL.dbo.DET_INV_TEMP set tipo = 'D' where idProducto = @idProducto and idProveedor = @idProveedor;
		end
		else
		begin
			insert into CENTRAL.dbo.DET_INV_TEMP values (@idProducto, @idProveedor, 'D');
		end
	end
	if exists (select * from inserted) and not exists(select * from deleted)
	begin
		select @idProducto = i.idProducto, @idProveedor = i.idProveedor from inserted i;
		insert into CENTRAL.dbo.DET_INV_TEMP values (@idProducto, @idProveedor, 'I');
	end
GO

CREATE OR ALTER TRIGGER [dbo].[TIPOPAGO_TRIG] ON CENTRAL.dbo.TIPOPAGO
AFTER UPDATE, DELETE, INSERT
AS
	declare @idTipoPago int;
	if exists(select * from inserted) and exists (SELECT * from deleted)
	begin
		select @idTipoPago = i.idTipoPago from inserted i;
		if exists (select idTipoPago from CENTRAL.dbo.TIPOPAGO_TEMP where idTipoPago = @idTipoPago)
		begin
			update CENTRAL.dbo.TIPOPAGO_TEMP set tipo = 'A' where idTipoPago = @idTipoPago;
		end
		else
		begin
			insert into CENTRAL.dbo.TIPOPAGO_TEMP values (@idTipoPago, 'A');
		end
	end
	if exists(select * from deleted) and not exists(Select * from inserted)
	begin
		select @idTipoPago = i.idTipoPago from deleted i;
		if exists (select idTipoPago from CENTRAL.dbo.TIPOPAGO_TEMP where idTipoPago = @idTipoPago)
		begin
			update CENTRAL.dbo.TIPOPAGO_TEMP set tipo = 'D' where idTipoPago = @idTipoPago;
		end
		else
		begin
			insert into CENTRAL.dbo.TIPOPAGO_TEMP values (@idTipoPago, 'D');
		end
	end
	if exists (select * from inserted) and not exists(select * from deleted)
	begin
		select @idTipoPago = i.idTipoPago from inserted i;
		insert into CENTRAL.dbo.TIPOPAGO_TEMP values (@idTipoPago, 'I');
	end
GO

CREATE OR ALTER TRIGGER [dbo].[PROV_TRIG] ON CENTRAL.dbo.PROVEEDORES
AFTER UPDATE, DELETE, INSERT
AS
	declare @idProveedor int;
	if exists(select * from inserted) and exists (SELECT * from deleted)
	begin
		select @idProveedor = i.idProveedor from inserted i;
		if exists (select idProveedor from CENTRAL.dbo.PROV_TEMP where idProveedor = @idProveedor)
		begin
			update CENTRAL.dbo.PROV_TEMP set tipo = 'A' where idProveedor = @idProveedor;
		end
		else
		begin
			insert into CENTRAL.dbo.PROV_TEMP values (@idProveedor, 'A');
		end
	end
	if exists(select * from deleted) and not exists(Select * from inserted)
	begin
		select @idProveedor = i.idProveedor from deleted i;
		if exists (select idProveedor from CENTRAL.dbo.PROV_TEMP where idProveedor = @idProveedor)
		begin
			update CENTRAL.dbo.PROV_TEMP set tipo = 'D' where idProveedor = @idProveedor;
		end
		else
		begin
			insert into CENTRAL.dbo.PROV_TEMP values (@idProveedor, 'D');
		end
	end
	if exists (select * from inserted) and not exists(select * from deleted)
	begin
		select @idProveedor = i.idProveedor from inserted i;
		insert into CENTRAL.dbo.PROV_TEMP values (@idProveedor, 'I');
	end
GO

CREATE OR ALTER TRIGGER [dbo].[PROV_CORREOS_TRIGGER] ON CENTRAL.dbo.PROVEEDORES_CORREOS
AFTER DELETE, INSERT
AS
	declare @idProveedor int,
			@correo varchar(50);
	if exists(select * from deleted) and not exists(Select * from inserted)
	begin
		select @idProveedor = i.idProveedor, @correo = i.correo from deleted i;
		if exists (select idProveedor from CENTRAL.dbo.PROV_CORREO_TEMP where correo = @correo and idProveedor = @idProveedor)
		begin
			update CENTRAL.dbo.PROV_CORREO_TEMP set tipo = 'D' where correo = @correo and idProveedor = @idProveedor;
		end
		else
		begin
			insert into CENTRAL.dbo.PROV_CORREO_TEMP values (@idProveedor, @correo, 'D');
		end
	end
	if exists (select * from inserted) and not exists(select * from deleted)
	begin
		select @idProveedor = i.idProveedor, @correo = i.correo from inserted i;
		insert into CENTRAL.dbo.PROV_CORREO_TEMP values (@idProveedor, @correo, 'I');
	end
GO

CREATE OR ALTER TRIGGER [dbo].[PROV_TELEF_TRIGGER] ON CENTRAL.dbo.PROVEEDORES_TELEFONOS
AFTER DELETE, INSERT
AS
	declare @idProveedor int,
			@telefono varchar(20);
	if exists(select * from deleted) and not exists(Select * from inserted)
	begin
		select @idProveedor = i.idProveedor, @telefono = i.telefono from deleted i;
		if exists (select idProveedor from CENTRAL.dbo.PROV_TELEF_TEMP where telefono = @telefono and idProveedor = @idProveedor)
		begin
			update CENTRAL.dbo.PROV_TELEF_TEMP set tipo = 'D' where telefono = @telefono and idProveedor = @idProveedor;
		end
		else
		begin
			insert into CENTRAL.dbo.PROV_TELEF_TEMP values (@idProveedor, @telefono, 'D');
		end
	end
	if exists (select * from inserted) and not exists(select * from deleted)
	begin
		select @idProveedor = i.idProveedor, @telefono = i.telefono from inserted i;
		insert into CENTRAL.dbo.PROV_TELEF_TEMP values (@idProveedor, @telefono, 'I');
	end
GO

CREATE OR ALTER TRIGGER ActualizaInventarioSucursales on Central.dbo.Inventario
AFTER UPDATE
AS
BEGIN
	DECLARE @existencias int,
			@idProducto int,
			@estado char(1);

	SELECT @existencias = existencias, @idProducto = idProducto, @estado = estado from inserted;

	IF @existencias = 0 and @estado = 'A'
	BEGIN
		UPDATE CENTRAL.dbo.INVENTARIO SET estado = 'I' where idProducto = @idProducto;
		UPDATE YANILY.SUCURSAL2.dbo.INVENTARIO SET estado = 'I' where idProducto = @idProducto;
		UPDATE YUVANNIA.SUCURSAL1.dbo.INVENTARIO SET estado = 'I' where idProducto = @idProducto;
	END

	ELSE IF @estado > 0 and @estado = 'I'
	BEGIN
		UPDATE CENTRAL.dbo.INVENTARIO SET estado = 'A' where idProducto = @idProducto;
		UPDATE YANILY.SUCURSAL2.dbo.INVENTARIO SET estado = 'A' where idProducto = @idProducto;
		UPDATE YUVANNIA.SUCURSAL1.dbo.INVENTARIO SET estado = 'A' where idProducto = @idProducto;
	END

END
GO