/*
	CREACI�N DE USUARIO ADMINISTRADOR DEL CENTRAL DE FARMACIAS.
*/
USE [master]
GO
CREATE LOGIN [CENTRAL] WITH PASSWORD=N'ucr2019', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [CENTRAL]
GO

/*
	CREACI�N DE LA BASE DE DATOS CENTRAL.
*/

CREATE DATABASE [CENTRAL]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CENTRAL', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\CENTRAL.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CENTRAL_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\CENTRAL_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [CENTRAL] SET COMPATIBILITY_LEVEL = 140
GO
ALTER DATABASE [CENTRAL] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CENTRAL] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CENTRAL] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CENTRAL] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CENTRAL] SET ARITHABORT OFF 
GO
ALTER DATABASE [CENTRAL] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CENTRAL] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CENTRAL] SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF)
GO
ALTER DATABASE [CENTRAL] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CENTRAL] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CENTRAL] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CENTRAL] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CENTRAL] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CENTRAL] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CENTRAL] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CENTRAL] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CENTRAL] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CENTRAL] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CENTRAL] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CENTRAL] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CENTRAL] SET  READ_WRITE 
GO
ALTER DATABASE [CENTRAL] SET RECOVERY FULL 
GO
ALTER DATABASE [CENTRAL] SET  MULTI_USER 
GO
ALTER DATABASE [CENTRAL] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CENTRAL] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CENTRAL] SET DELAYED_DURABILITY = DISABLED 
GO
USE [CENTRAL]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = On;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = Primary;
GO
USE [CENTRAL]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [CENTRAL] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO

/*
	CREACI�N DE TABLAS DE LA BASE DE DATOS CENTRAL.
*/
USE [CENTRAL]
GO

/*
	PARA HACER REFERENCIA A LA FARMACIA #1, SE HACE A TRAV�S DEL C�DIGO DE FARMACIA 1, EN LA BASE DE DATOS CENTRAL.
	PARA HACER REFERENCIA A LA FARMACIA #2, SE HACE A TRAV�S DEL C�DIGO DE FARMACIA 2, EN LA BASE DE DATOS CENTRAL.
*/

CREATE TABLE SUCURSAL
(idFarmacia int,
nombre varchar(20),
PRIMARY KEY (idFarmacia))
GO

CREATE TABLE EMPLEADOS
(idEmpleado int,
nombre varchar(50),
direccion varchar(100),
salario decimal(10,2),
rol varchar(10),
idFarmacia int,
PRIMARY KEY (idEmpleado, idFarmacia),
FOREIGN KEY(idFarmacia) REFERENCES SUCURSAL(idFarmacia))
GO

CREATE TABLE EMPLEADOS_TELEFONOS
(idEmpleado int,
telefono varchar(20),
idFarmacia int,
PRIMARY KEY (idEmpleado, telefono, idFarmacia),
FOREIGN KEY (idEmpleado, idFarmacia) REFERENCES EMPLEADOS(idEmpleado, idFarmacia),
FOREIGN KEY(idFarmacia) REFERENCES SUCURSAL(idFarmacia))
GO

CREATE TABLE EMPLEADOS_CORREOS
(idEmpleado int,
correo varchar(50),
idFarmacia int,
PRIMARY KEY (idEmpleado, correo, idFarmacia),
FOREIGN KEY (idEmpleado, idFarmacia) REFERENCES EMPLEADOS(idEmpleado, idFarmacia),
FOREIGN KEY(idFarmacia) REFERENCES SUCURSAL(idFarmacia))
GO

CREATE TABLE CATEGORIAS
(idCategoria int,
nombre varchar(20),
PRIMARY KEY(idCategoria))
GO

CREATE TABLE PROVEEDORES
(idProveedor int,
nombre varchar(50),
direccion varchar(100),
descripcion varchar(50),
PRIMARY KEY (idProveedor))
GO

CREATE TABLE PROVEEDORES_TELEFONOS
(idProveedor int,
telefono varchar(20),
PRIMARY KEY (idProveedor, telefono),
FOREIGN KEY (idProveedor) REFERENCES PROVEEDORES(idProveedor))
GO

CREATE TABLE PROVEEDORES_CORREOS
(idProveedor int,
correo varchar(50),
PRIMARY KEY (idProveedor, correo),
FOREIGN KEY (idProveedor) REFERENCES PROVEEDORES(idProveedor))
GO

CREATE TABLE INVENTARIO
(idProducto int,
idCategoria int,
nombre varchar(20),
medida varchar(10),
precioVenta decimal(10,2),
precioCompra decimal(10,2),
descripcion varchar(50),
existencias int,
estado char(1),
imagen varchar(200),
PRIMARY KEY (idProducto),
FOREIGN KEY (idCategoria) REFERENCES CATEGORIAS(idCategoria))
GO

CREATE TABLE DETALLEINVENTARIO
(idProducto int,
idProveedor int,
PRIMARY KEY(idProducto, idProveedor),
FOREIGN KEY (idProducto) REFERENCES INVENTARIO(idProducto),
FOREIGN KEY (idProveedor) REFERENCES PROVEEDORES(idProveedor))
GO

CREATE TABLE TIPOPAGO
(idTipoPago int,
descripcion varchar(10)
PRIMARY KEY(idTipoPago))
GO

CREATE TABLE FACTURAS
(idFactura int,
fecha datetime,
montoTotal decimal(10,2),
idEmpleado int,
idFarmacia int,
tipoPago int,
correo varchar(100),
descuento int,
IVA int,
IV int,
PRIMARY KEY (idFactura, idFarmacia),
FOREIGN KEY(idEmpleado, idFarmacia) REFERENCES EMPLEADOS(idEmpleado, idFarmacia),
FOREIGN KEY(tipoPago) REFERENCES TIPOPAGO(idTipoPago),
FOREIGN KEY(idFarmacia) REFERENCES SUCURSAL(idFarmacia))
GO

CREATE TABLE DETALLEFACTURA
(idFactura int,
idProducto int,
costo decimal(10,2),
cantidad int,
subtotal decimal(10,2),
idFarmacia int,
PRIMARY KEY(idFactura, idProducto, idFarmacia),
FOREIGN KEY(idFactura, idFarmacia) REFERENCES FACTURAS(idFactura, idFarmacia),
FOREIGN KEY(idProducto) REFERENCES INVENTARIO(idProducto),
FOREIGN KEY(idFarmacia) REFERENCES SUCURSAL(idFarmacia))
GO

CREATE TABLE USUARIOS
(usuario varchar(20),
contrasena varchar(20),
rol varchar(20)
PRIMARY KEY(usuario));
GO

CREATE TABLE CATEG_TEMP
(idCategoria int,
tipo char(1))
GO

CREATE TABLE INVENT_TEMP
(idProducto int,
tipo char(1))
GO

CREATE TABLE DET_INV_TEMP
(idProducto int,
idProveedor int,
tipo char(1))
GO

CREATE TABLE TIPOPAGO_TEMP
(idTipoPago int,
tipo char(1))
GO

CREATE TABLE PROV_TEMP
(idProveedor int,
tipo char(1))
GO

CREATE TABLE PROV_CORREO_TEMP
(idProveedor int,
correo varchar(50),
tipo char(1))
GO

CREATE TABLE PROV_TELEF_TEMP
(idProveedor int,
telefono varchar(20),
tipo char(1))
GO

drop table CATEGORIAS;
drop table DETALLEFACTURA;
drop table DETALLEINVENTARIO;
drop table EMPLEADOS_CORREOS;
drop table INVENTARIO;
drop table EMPLEADOS_TELEFONOS;
drop table EMPLEADOS;
drop table FACTURAS;
drop table PROVEEDORES_CORREOS;
drop table PROVEEDORES_TELEFONOS;
drop table PROVEEDORES;
drop table TIPOPAGO;
drop table SUCURSAL;
GO