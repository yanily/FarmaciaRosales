/*
	El siguiente procedimiento almacenado se encargará de la sincronización de los datos de las tablas pertenecientes a la base de datos central hacia las bases de datos
	locales, que son sucursales.
	Para poder hacerlo, simplemente se realizan cursores en las tablas temporales de los datos; estas tablas almacenan información relevante para identificar los registros
	nuevos recien ingresados, que han sido actualizados o eliminado.

	Para el almacenamiento de datos en las tablas temporales (el cual va a contener operaciones DML realizadas a la base de datos), se utilizan triggers.
*/
USE [CENTRAL]
GO

CREATE OR ALTER PROCEDURE [dbo].[Sync_Data_Sucursal1]
AS

BEGIN
	declare cur_categoria cursor for
		select * from CENTRAL.dbo.CATEG_TEMP;

	declare cur_inventario cursor for
		select * from CENTRAL.dbo.INVENT_TEMP;

	declare cur_inventarioDetalle cursor for
		select * from CENTRAL.dbo.DET_INV_TEMP;

	declare cur_tipoPago cursor for
		select * from CENTRAL.dbo.TIPOPAGO_TEMP;

	declare cur_proveedores cursor for
		select * from CENTRAL.dbo.PROV_TEMP;

	declare cur_proveedoresCorreo cursor for
		select * from CENTRAL.dbo.PROV_CORREO_TEMP;

	declare cur_proveedoresTelefono cursor for
		select * from CENTRAL.dbo.PROV_TELEF_TEMP;

	declare @idCategoria int,
			@nombre varchar(20),
			@tipo char(1);

	declare @idProducto int,
			@medida varchar(20),
			@precioVenta decimal(10,2),
			@precioCompra decimal(10,2),
			@descripcion varchar(50),
			@existencias int,
			@idTipoPago int,
			@estado char(1),
			@imagen varchar(200);

	declare @idProveedor int,
			@direccion varchar(100);

	declare @correo varchar(50),
			@telefono varchar(20);


	open cur_categoria;
	fetch next from cur_categoria into @idCategoria, @tipo;

	while @@fetch_status = 0
	begin
		if @tipo = 'I' 
		begin
			select @nombre = nombre from CENTRAL.dbo.CATEGORIAS where idCategoria = @idCategoria;
			insert into YANILY.SUCURSAL2.dbo.CATEGORIAS values (@idCategoria, @nombre);
			insert into YUVANNIA.SUCURSAL1.dbo.CATEGORIAS values (@idCategoria, @nombre);
		end

		else if @tipo = 'A'
		begin
			select @nombre = nombre from CENTRAL.dbo.CATEGORIAS where idCategoria = @idCategoria;

			if not exists(select idCategoria from YANILY.SUCURSAL2.dbo.CATEGORIAS where idCategoria = @idCategoria)
			begin
				insert into YANILY.SUCURSAL2.dbo.CATEGORIAS values (@idCategoria, @nombre);
			end

			else
			begin
				update YANILY.SUCURSAL2.dbo.CATEGORIAS set nombre = @nombre where idCategoria = @idCategoria;
			end

			if not exists(select idCategoria from YUVANNIA.SUCURSAL1.dbo.CATEGORIAS where idCategoria = @idCategoria)
			begin
				insert into YUVANNIA.SUCURSAL1.dbo.CATEGORIAS values (@idCategoria, @nombre);
			end

			else
			begin
				update YUVANNIA.SUCURSAL1.dbo.CATEGORIAS set nombre = @nombre where idCategoria = @idCategoria;
			end

		end

		else
		begin
			delete from YANILY.SUCURSAL2.dbo.CATEGORIAS where idCategoria = @idCategoria;
			delete from YUVANNIA.SUCURSAL1.dbo.CATEGORIAS where idCategoria = @idCategoria;
		end

		fetch next from cur_categoria into @idCategoria, @tipo;
	end

	close cur_categoria;
	deallocate cur_categoria;

	open cur_inventario;
	fetch next from cur_inventario into @idProducto, @tipo;

	while @@fetch_status = 0
	begin
		if @tipo = 'I'
		begin
			select @idCategoria = idCategoria, @nombre = nombre, @medida = medida, @precioVenta = precioVenta, @precioCompra = precioCompra, 
				@descripcion = descripcion, @existencias = existencias, @estado = estado, @imagen = imagen from CENTRAL.dbo.INVENTARIO where idProducto = @idProducto;
			insert into YANILY.SUCURSAL2.dbo.INVENTARIO values (@idProducto, @idCategoria, @nombre, @medida, @precioVenta, @precioCompra, @descripcion, 
				@existencias, @estado, @imagen);
			insert into YUVANNIA.SUCURSAL1.dbo.INVENTARIO values (@idProducto, @idCategoria, @nombre, @medida, @precioVenta, @precioCompra, @descripcion, 
				@existencias, @estado, @imagen);
		end

		else if @tipo = 'A'
		begin
			select @idCategoria = idCategoria, @nombre = nombre, @medida = medida, @precioVenta = precioVenta, @precioCompra = precioCompra, 
				@descripcion = descripcion, @existencias = existencias, @estado = estado, @imagen = imagen from CENTRAL.dbo.INVENTARIO where idProducto = @idProducto;
			if not exists(select idProducto from YANILY.SUCURSAL2.dbo.INVENTARIO where idProducto = @idProducto)
			begin
				insert into YANILY.SUCURSAL2.dbo.INVENTARIO values (@idProducto, @idCategoria, @nombre, @medida, @precioVenta, @precioCompra, @descripcion,
					@existencias, @estado, @imagen);
			end

			else
			begin
				update YANILY.SUCURSAL2.dbo.INVENTARIO set idCategoria = @idCategoria, nombre = @nombre, medida = @medida, precioVenta = @precioVenta,
					precioCompra = @precioCompra, descripcion = @descripcion, existencias = @existencias, estado = @estado, imagen = @imagen
					where idProducto = @idProducto;
			end

			if not exists(select idProducto from YUVANNIA.SUCURSAL1.dbo.INVENTARIO where idProducto = @idProducto)
			begin
				insert into YUVANNIA.SUCURSAL1.dbo.INVENTARIO values (@idProducto, @idCategoria, @nombre, @medida, @precioVenta, @precioCompra, @descripcion,
					@existencias, @estado, @imagen);
			end

			else
			begin
				update YUVANNIA.SUCURSAL1.dbo.INVENTARIO set idCategoria = @idCategoria, nombre = @nombre, medida = @medida, precioVenta = @precioVenta,
					precioCompra = @precioCompra, descripcion = @descripcion, existencias = @existencias, estado = @estado, imagen = @imagen
					where idProducto = @idProducto;
			end
		end

		else
		begin
			delete from YANILY.SUCURSAL2.dbo.INVENTARIO where idProducto = @idProducto;
			delete from YUVANNIA.SUCURSAL1.dbo.INVENTARIO where idProducto = @idProducto;
		end

		fetch next from cur_inventario into @idProducto, @tipo;
	end
	
	close cur_inventario;
	deallocate cur_inventario;

	open cur_inventarioDetalle;
	fetch next from cur_inventarioDetalle into @idProducto, @idProveedor, @tipo;

	while @@fetch_status = 0
	begin
		if @tipo = 'I'
		begin
			insert into YANILY.SUCURSAL2.dbo.DETALLEINVENTARIO values (@idProducto, @idProveedor);
			insert into YUVANNIA.SUCURSAL1.dbo.DETALLEINVENTARIO values (@idProducto, @idProveedor);
		end

		else
		begin
			delete from YANILY.SUCURSAL2.dbo.DETALLEINVENTARIO where idProducto = @idProducto and idProveedor = @idProveedor;
			delete from YUVANNIA.SUCURSAL1.dbo.DETALLEINVENTARIO where idProducto = @idProducto and idProveedor = @idProveedor;
		end

		fetch next from cur_inventarioDetalle into @idProducto, @idProveedor, @tipo;
	end
	
	close cur_inventarioDetalle;
	deallocate cur_inventarioDetalle;

	open cur_tipoPago;
	fetch next from cur_tipoPago into @idTipoPago, @tipo;

	while @@fetch_status = 0
	begin
		if @tipo = 'I'
		begin
			select @descripcion = descripcion from CENTRAL.dbo.TIPOPAGO where idTipoPago = @idTipoPago;
			insert into YANILY.SUCURSAL2.dbo.TIPOPAGO values (@idTipoPago, @descripcion);
			insert into YUVANNIA.SUCURSAL1.dbo.TIPOPAGO values (@idTipoPago, @descripcion);
		end

		else if @tipo = 'A'
		begin
			select @descripcion = descripcion from CENTRAL.dbo.TIPOPAGO where idTipoPago = @idTipoPago;
			if not exists(select idTipoPago from YANILY.SUCURSAL2.dbo.TIPOPAGO where idTipoPago = @idTipoPago)
			begin
				insert into YANILY.SUCURSAL2.dbo.TIPOPAGO values (@idTipoPago, @descripcion);
			end

			else
			begin
				update YANILY.SUCURSAL2.dbo.TIPOPAGO set descripcion = @descripcion where idTipoPago = @idTipoPago;
			end

			if not exists(select idTipoPago from YUVANNIA.SUCURSAL1.dbo.TIPOPAGO where idTipoPago = @idTipoPago)
			begin
				insert into YUVANNIA.SUCURSAL1.dbo.TIPOPAGO values (@idTipoPago, @descripcion);
			end

			else
			begin
				update YUVANNIA.SUCURSAL1.dbo.TIPOPAGO set descripcion = @descripcion where idTipoPago = @idTipoPago;
			end

		end

		else
		begin
			delete from YANILY.SUCURSAL2.dbo.TIPOPAGO where idTipoPago = @idTipoPago;
			delete from YUVANNIA.SUCURSAL1.dbo.TIPOPAGO where idTipoPago = @idTipoPago;
		end

		fetch next from cur_tipoPago into @idTipoPago, @tipo;
	end
	
	close cur_tipoPago;
	deallocate cur_tipoPago;

	open cur_proveedores;
	fetch next from cur_proveedores into @idProveedor, @tipo;

	while @@fetch_status = 0
	begin
		if @tipo = 'I'
		begin
			select @nombre = nombre, @direccion = direccion, @descripcion = descripcion from CENTRAL.dbo.PROVEEDORES where idProveedor = @idProveedor;
			insert into YANILY.SUCURSAL2.dbo.PROVEEDORES values (@idProveedor, @nombre, @direccion, @descripcion);
			insert into YUVANNIA.SUCURSAL1.dbo.PROVEEDORES values (@idProveedor, @nombre, @direccion, @descripcion);
		end

		else if @tipo = 'A'
		begin
			select @nombre = nombre, @direccion = direccion, @descripcion = descripcion from CENTRAL.dbo.PROVEEDORES where idProveedor = @idProveedor;
			if not exists(select idProveedor from YANILY.SUCURSAL2.dbo.PROVEEDORES where idProveedor = @idProveedor)
			begin
				insert into YANILY.SUCURSAL2.dbo.PROVEEDORES values (@idProveedor, @nombre, @direccion, @descripcion);
			end

			else
			begin
				update YANILY.SUCURSAL2.dbo.PROVEEDORES set nombre = @nombre, direccion = @direccion, descripcion = @descripcion where idProveedor = @idProveedor;
			end

			if not exists(select idProveedor from YUVANNIA.SUCURSAL1.dbo.PROVEEDORES where idProveedor = @idProveedor)
			begin
				insert into YUVANNIA.SUCURSAL1.dbo.PROVEEDORES values (@idProveedor, @nombre, @direccion, @descripcion);
			end

			else
			begin
				update YUVANNIA.SUCURSAL1.dbo.PROVEEDORES set nombre = @nombre, direccion = @direccion, descripcion = @descripcion where idProveedor = @idProveedor;
			end
		end

		else
		begin
			delete from YANILY.SUCURSAL2.dbo.PROVEEDORES where idProveedor = @idProveedor;
			delete from YUVANNIA.SUCURSAL1.dbo.PROVEEDORES where idProveedor = @idProveedor;
		end

		fetch next from cur_proveedores into @idProveedor, @tipo;
	end
	
	close cur_proveedores;
	deallocate cur_proveedores;

	open cur_proveedoresCorreo;
	fetch next from cur_proveedoresCorreo into @idProveedor, @correo, @tipo;

	while @@fetch_status = 0
	begin
		if @tipo = 'I'
		begin
			insert into YANILY.SUCURSAL2.dbo.PROVEEDORES_CORREOS values (@idProveedor, @correo);
			insert into YUVANNIA.SUCURSAL1.dbo.PROVEEDORES_CORREOS values (@idProveedor, @correo);
		end

		else
		begin
			delete from YANILY.SUCURSAL2.dbo.PROVEEDORES_CORREOS where idProveedor = @idProveedor and correo = @correo;
			delete from YUVANNIA.SUCURSAL1.dbo.PROVEEDORES_CORREOS where idProveedor = @idProveedor and correo = @correo;
		end

		fetch next from cur_proveedoresCorreo into @idProveedor, @correo, @tipo;
	end
	
	close cur_proveedoresCorreo;
	deallocate cur_proveedoresCorreo;
	
	open cur_proveedoresTelefono;
	fetch next from cur_proveedoresTelefono into @idProveedor, @telefono, @tipo;

	while @@fetch_status = 0
	begin
		if @tipo = 'I'
		begin
			insert into YANILY.SUCURSAL2.dbo.PROVEEDORES_TELEFONOS values (@idProveedor, @telefono);
			insert into YUVANNIA.SUCURSAL1.dbo.PROVEEDORES_TELEFONOS values (@idProveedor, @telefono);
		end

		else
		begin
			delete from YANILY.SUCURSAL2.dbo.PROVEEDORES_TELEFONOS where idProveedor = @idProveedor and telefono = @telefono;
			delete from YUVANNIA.SUCURSAL1.dbo.PROVEEDORES_TELEFONOS where idProveedor = @idProveedor and telefono = @telefono;
		end

		fetch next from cur_proveedoresTelefono into @idProveedor, @telefono, @tipo;
	end
	
	close cur_proveedoresTelefono;
	deallocate cur_proveedoresTelefono;

	delete from CENTRAL.dbo.CATEG_TEMP;
	delete from CENTRAL.dbo.INVENT_TEMP;
	delete from CENTRAL.dbo.DET_INV_TEMP;
	delete from CENTRAL.dbo.TIPOPAGO_TEMP;
	delete from CENTRAL.dbo.PROV_TEMP;
	delete from CENTRAL.dbo.PROV_CORREO_TEMP;
	delete from CENTRAL.dbo.PROV_TELEF_TEMP;

END
GO

exec Sync_Data_Sucursal1;

insert into usuarios values ('robert', '123', 'Admin');

insert into sucursal values (1, 'Sucursal1');
insert into sucursal values (2, 'Sucursal2');

insert into proveedores values (1, 'Robert Arias', 'Puntarenas', 'Big Pharma');
insert into proveedores_correos values (1, 'robert@arias.com');
insert into proveedores_telefonos values (1, '+506 8320-8691');
insert into proveedores_telefonos values (1, '+506 8588-6397');

update proveedores set direccion = 'Alajuela' where idProveedor = 1;
delete from proveedores_telefonos where idProveedor = 1 and telefono = '+506 8588-6397';

insert into categorias values (1, 'Tabletas');
insert into categorias values (2, 'Inyectable');
insert into inventario values (1, 1, 'Acetaminophen', '50 mg', 300, 220, 'Alivia dolor cabeza', 100, 'A', NULL);
insert into inventario values (2, 2, 'Insulina', '50 mg', 300, 220, 'Alivia dolor cabeza', 100, 'A', NULL);
insert into detalleinventario values (1, 1);
insert into detalleinventario values (2, 1);

insert into tipopago values (1, 'Efectivo');
insert into tipopago values (2, 'Tarjeta');
insert into tipopago values (3, 'Cheque');

select * from empleados;
select * from empleados_telefonos;
select * from empleados_correos;

select * from facturas;
select * from detallefactura;

go;

select * from prov_temp;

insert into sucursal values (1, 'Sucursal1');
insert into sucursal values (2, 'Sucursal2');

select * from empleados;
insert into tipopago values(1, 'Cheque');
insert into tipopago values(2, 'Efectivo');
insert into tipopago values (3, 'Tarjeta');

select * from facturas;
select * from detallefactura;
delete from facturas;

select * from detallefactura;