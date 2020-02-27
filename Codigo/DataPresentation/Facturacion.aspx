<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Facturacion.aspx.cs" Inherits="DataPresentation.Facturacion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <h2>Facturación</h2>
    <table>
        <tr>
            <td>
                <asp:Label ID="Label1" runat="server" Text="Fecha:"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tbFecha" runat="server" ReadOnly="true" Width="175px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label14" runat="server" Text="Empleado:" Width="150px"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="empleadoDDL" runat="server" Height="25px" Width="175px"> </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label4" runat="server" Text="Tipo pago:" Width="150px"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="tipoDDL" runat="server" Height="25px" Width="175px"> </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label3" runat="server" Text="Correo de cliente:" ></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tbCorreo" runat="server" Width="175px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label2" runat="server" Text="Descuento:"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lbDescuento" runat="server" Text="0%"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label6" runat="server" Text="IVA:"></asp:Label>
            </td>
            <td>
                <asp:Label ID="Label5" runat="server" Text="13%"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label7" runat="server" Text="IV:"></asp:Label>
            </td>
            <td>
                <asp:Label ID="Label10" runat="server" Text="2%"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label12" runat="server" Text="Monto Total:"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lbMontoTotal" runat="server" Text="0"></asp:Label>
            </td>
        </tr>
    </table>
    <br />
    <h2>Productos</h2>
    <table>
        <tr>
            <td>
                <asp:Label ID="Label8" runat="server" Text="Producto:"></asp:Label>
                <asp:DropDownList ID="productosDDL" runat="server" Height="25px" Width="175px" AutoPostBack="true"
                    OnSelectedIndexChanged="productosDDL_SelectedIndexChanged"></asp:DropDownList>
                <asp:Label ID="Label11" runat="server" Text="Precio:"></asp:Label>
                <asp:TextBox ID="tbPrecio" runat="server" Width="175px" ReadOnly="true"></asp:TextBox>
                <asp:Label ID="Label9" runat="server" Text="Cantidad:"></asp:Label>
                <asp:TextBox ID="tbCantidad" runat="server" Width="175px"></asp:TextBox>
                <asp:Button ID="btnAgregar" runat="server" Text="Agregar" OnClick="btnAgregar_Click"/>
            </td>
        </tr>
    </table>
    <br />
    <asp:GridView ID="gvProductos" runat="server" AutoGenerateColumns="False" OnRowDeleting="gvProductos_RowDeleting">
        <Columns>
            <asp:BoundField DataField="idProducto" HeaderText="Código Producto"></asp:BoundField>
            <asp:BoundField DataField="nombreProducto" HeaderText="Nombre producto"></asp:BoundField>
            <asp:BoundField DataField="precio" HeaderText="Precio"></asp:BoundField>
            <asp:BoundField DataField="cantidad" HeaderText="Cantidad"></asp:BoundField>
            <asp:BoundField DataField="subtotal" HeaderText="Subtotal"></asp:BoundField>
            <asp:CommandField ShowDeleteButton="true" />
        </Columns>
    </asp:GridView>
    <br />
    <table>
        <tr>
            <td>
                <asp:Button ID="btnFacturar" runat="server" Text="Facturar" OnClick="btnFacturar_Click"/>
                <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar" OnClick="btnLimpiar_Click"/>
            </td>
        </tr>
    </table>
</asp:Content>
