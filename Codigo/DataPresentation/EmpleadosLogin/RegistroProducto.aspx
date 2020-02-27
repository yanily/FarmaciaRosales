<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RegistroProducto.aspx.cs" Inherits="DataPresentation.RegistroProducto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <center>
    <div class="Panel col-lg-5 col-md-5 col-sm-5 mt-4">
        <div class="card">
             <div class="card-header bg-info">
                 <h4 class="TextoContenido">Registro de Productos</h4>
             </div>
            <div class="card-body">
               
                <div class="form-group">  
                    <div class="row">        
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <asp:Label Text="Identificador del Producto: " runat="server" />
                        </div>

                         <div class ="col-lg-8 col-md-8 col-sm-8">
                             <asp:TextBox ID="tbProducto" runat="server" CssClass="form-control"  />                             
                         </div>                        
                    </div>
                </div>

                <div class="form-group">  
                    <div class="row">        
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <asp:Label Text="Categoria: " runat="server" />
                        </div>

                         <div class ="col-lg-8 col-md-8 col-sm-8">
                             <asp:DropDownList ID="DDLCategoria" runat="server"  CssClass="form-control"  AutoPostBack="false"/>                             
                         </div>                        
                    </div>
                </div>

                  <div class="form-group">  
                    <div class="row">        
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <asp:Label Text="Nombre: " runat="server" />
                        </div>

                         <div class ="col-lg-8 col-md-8 col-sm-8">
                           <asp:TextBox ID="tbNombre" runat="server" CssClass="form-control"  />                         
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
                            <asp:Label Text="Proveedor: " runat="server" />
                        </div>

                         <div class ="col-lg-8 col-md-8 col-sm-8">
                             <asp:DropDownList ID="DDLProveedor" runat="server" CssClass="form-control" 
                                 />  
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
                            <asp:Label Text="existencias: " runat="server" />
                        </div>

                         <div class ="col-lg-8 col-md-8 col-sm-8">
                             <asp:TextBox ID="tbExistencias" runat="server" CssClass="form-control" 
                                 />                             
                         </div>                        
                    </div>
                </div>

                <div class="form-group">  
                    <div class="row">        
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <asp:Label Text="Estado: " runat="server" />
                        </div>

                         <div class ="col-lg-8 col-md-8 col-sm-8">
                             <asp:DropDownList ID="DDLEstado" runat="server" CssClass="form-control" 
                                 />  
                         </div>                        
                    </div>
                </div>

              

                <div class="form-group">  
                    <div class="row">        
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <asp:Label Text="Seleccione una imagen: " runat="server" />
                        </div>
              
                        <asp:FileUpload ID="FileUpload1" accept="image/png, image/jpeg" name="avatar" runat="server"></asp:FileUpload>
                                                             
                         </div>                        
                    </div>
                



                
               
             


       <asp:Button ID="Button1" runat="server" CssClass="btn btn-outline-info" OnClick="btnAgregar_Click" Text="Agregar"></asp:Button>
    </div>
        </div>

    </div>
        </center>
</asp:Content>
