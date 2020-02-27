<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ActualizarProducto.aspx.cs" Inherits="DataPresentation.ActualizarProducto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<center>
    <div class="Panel col-lg-5 col-md-5 col-sm-5 mt-4">
        <div class="card">
             <div class="card-header bg-info">
                 <h4 class="TextoContenido">Actualización de Productos</h4>
             </div>
            <div class="card-body">

                 
                 
                 <div class="form-group">  
                    <div class="row">        
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <asp:Label Text="Producto: " runat="server" />
                        </div>

                         <div class ="col-lg-8 col-md-8 col-sm-8">
                             <asp:DropDownList ID="DDLProducto"  runat="server" CssClass="form-control" OnSelectedIndexChanged="DDLProducto_SelectedIndexChanged" AutoPostBack="true"
                                 />  
                         </div>                        
                    </div>
                </div>

              
                <div class="form-group">  
                    <div class="row">        
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <asp:Label Text="Medida: " runat="server" />
                        </div>

                         <div class ="col-lg-8 col-md-8 col-sm-8">
                              <asp:TextBox ID="tbMedida" runat="server" CssClass="form-control"  />
                                                     
                         </div>                        
                    </div>
                </div>

                <div class="form-group">  
                    <div class="row">        
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <asp:Label Text="Precio Venta: " runat="server" />
                        </div>

                         <div class ="col-lg-8 col-md-8 col-sm-8">
                              <asp:TextBox ID="tbPrecioVenta" runat="server" CssClass="form-control"  />
                         </div>                        
                    </div>
                </div>
                   
                <div class="form-group">  
                    <div class="row">        
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <asp:Label Text="Precio de Compra: " runat="server" />
                        </div>

                         <div class ="col-lg-8 col-md-8 col-sm-8">
                              <asp:TextBox ID="tbPrecioCompra" runat="server" CssClass="form-control"  />
                         </div>                        
                    </div>
                </div>

                <div class="form-group">  
                    <div class="row">        
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <asp:Label Text="Descripcion: " runat="server" />
                        </div>

                         <div class ="col-lg-8 col-md-8 col-sm-8">
                             <asp:TextBox ID="tbDescripcion" runat="server" CssClass="form-control"  />                      
                         </div>                        
                    </div>
                </div>


             

              <div class="form-group">  
                    <div class="row">        
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <asp:Label Text="Cantidad: " runat="server" />
                        </div>

                         <div class ="col-lg-8 col-md-8 col-sm-8">
                             <asp:TextBox ID="tbCantidad" runat="server" CssClass="form-control"  />                      
                         </div>                        
                    </div>
                </div>

               
                


       <asp:Button ID="btnActualizar" runat="server" CssClass="btn btn-outline-info" OnClick="btnActualizar_Click" Text="Actualizar"></asp:Button>
    </div>
        </div>

    </div>
        </center>
</asp:Content>
