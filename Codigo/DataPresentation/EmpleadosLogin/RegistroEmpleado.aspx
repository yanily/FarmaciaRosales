<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RegistroEmpleado.aspx.cs" Inherits="DataPresentation.RegistroEmpleado" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <center>
    <div class="Panel col-lg-5 col-md-5 col-sm-5 mt-4"> 
     
        <div class="card">
             <div class="card-header bg-info">
                 <h4 class="TextoContenido">Registro Empleados</h4>
             </div>
            <div class="card-body">
                <div class="form-group">
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <asp:Label Text="Cedula Fisica" runat="server" />
                        </div>
                         <div class ="col-lg-8 col-md-8 col-sm-8">
                             <asp:TextBox ID="tbIDEmpleado" runat="server" CssClass="form-control" 
                                 placeholder="112341234" />
                         </div>
                    </div>
                </div>

               <div class="form-group">
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <asp:Label Text="Nombre" runat="server" />
                        </div>
                         <div class ="col-lg-8 col-md-8 col-sm-8">
                             <asp:TextBox ID="tbNombre" runat="server" CssClass="form-control" />
                         </div>
                    </div>
                </div>
              <div class="form-group">
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <asp:Label Text="Direccion" runat="server" />
                        </div>
                         <div class ="col-lg-8 col-md-8 col-sm-8">
                             <asp:TextBox ID="tbDireccion" runat="server" CssClass="form-control" />
                         </div>
                    </div>
                </div>

                 <div class="form-group">
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <asp:Label Text="Salario" runat="server" />
                        </div>
                         <div class ="col-lg-8 col-md-8 col-sm-8">
                             <asp:TextBox ID="tbSalario" runat="server" CssClass="form-control" 
                                  />
                         </div>
                    </div>
                </div>
                 <div class="form-group">
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <asp:Label Text="Correo" runat="server" />
                        </div>
                         <div class ="col-lg-8 col-md-8 col-sm-8">
                             <asp:TextBox ID="tbCorreo" runat="server" CssClass="form-control" />
                         </div>
                    </div>
                </div>
                 <div class="form-group">
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <asp:Label Text="Telefono" runat="server" />
                        </div>
                         <div class ="col-lg-8 col-md-8 col-sm-8">
                             <asp:TextBox ID="tbTelefono" runat="server" CssClass="form-control" />
                         </div>
                    </div>
                </div>

                   <div class="form-group">                   
                    <div class="row">  
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <asp:Label Text="Rol: " runat="server" />
                        </div>
                         <div class ="col-lg-8 col-md-8 col-sm-8">
                            <asp:DropDownList ID="DDLRol" runat="server" CssClass="form-control" >
                            </asp:DropDownList>
                             
                         </div>                                                   
                    </div>
                </div>

                 <div class="form-group">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <asp:Button Text="Agregar" runat="server" Onclick="btnAgregarEmpleado_Click" CssClass="btn btn-outline-info" ID="btnAgregarEmpleado" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </center>
</asp:Content>
