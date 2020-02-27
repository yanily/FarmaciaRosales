<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ConsultarProducto.aspx.cs" Inherits="DataPresentation.ConsultarProducto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <center>
    <div class="Panel col-lg-5 col-md-5 col-sm-5 mt-4"> 
     
        <div class="card">
             <div class="card-header bg-info">
                 <h4 class="TextoContenido">Consulta Producto</h4>
             </div>

             <div class="card-body">
                  <div class="form-group">
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <asp:Label Text="Producto" runat="server" />
                        </div>
                         <div class ="col-lg-8 col-md-8 col-sm-8">
                      <asp:DropDownList ID="DDLProducto" runat="server" AutoPostBack="true"  OnSelectedIndexChanged="DDLProducto_SelectedIndexChanged"></asp:DropDownList>
                         </div>
                    </div>
                </div>

                 <div class="form-group">
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <asp:Label Text="Tabla de Consulta" runat="server" />
                        </div>
                         <div class ="col-lg-8 col-md-8 col-sm-8">
                        <asp:GridView ID="gvConsultaProducto" runat="server"  AutoGenerateColumns="False">
                          <Columns>
                               <asp:BoundField DataField="nombreCategoria" HeaderText="Nombre Categoria"></asp:BoundField>
                               <asp:BoundField DataField="nombre" HeaderText="NombreProducto"></asp:BoundField>
                               <asp:BoundField DataField="medida" HeaderText="Medida"></asp:BoundField>
                              <asp:BoundField DataField="precioVenta" HeaderText="PrecioVenta"></asp:BoundField>
                              <asp:BoundField DataField="precioCompra" HeaderText="PrecioCompra"></asp:BoundField>
                              <asp:BoundField DataField="descripcion" HeaderText="Descripción"></asp:BoundField>
                              <asp:BoundField DataField="existencias" HeaderText="Existencias"></asp:BoundField>
                          </Columns>
                    </asp:GridView>
                         </div>
                    </div>
                </div>

             </div>

            
        </div>
    </div>
    </center>
</asp:Content>
