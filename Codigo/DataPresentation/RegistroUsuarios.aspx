<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RegistroUsuarios.aspx.cs" Inherits="DataPresentation.RegistroUsuarios" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <center>
    <div class="Panel col-lg-5 col-md-5 col-sm-5 mt-4">
         
         
        <div class="card">
             <div class="card-header bg-info">
                 <h2 class="TextoContenido"> 
                       Registro Usuario
                 </h2>
             </div>

            <div class="card-body">
                <div class="form-group">
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <asp:Label Text="Usuario" runat="server" />
                        </div>
                         <div class ="col-lg-8 col-md-8 col-sm-8">
                             <asp:TextBox ID="tbUsuario" runat="server" CssClass="form-control" 
                                  />
                         </div>
                    </div>
                </div>
            
               
                <div class="form-group">                   
                    <div class="row">  
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <asp:Label Text="Empleado: " runat="server" />
                        </div>
                         <div class ="col-lg-8 col-md-8 col-sm-8">
                            <asp:DropDownList ID="DDLEmpleadol" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="DDLEmpleadol_SelectedIndexChanged" >
                            </asp:DropDownList>
                             
                         </div>                                                   
                    </div>
                </div>

                <div class="form-group">
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <asp:Label Text="Rol" runat="server" />
                        </div>
                         <div class ="col-lg-8 col-md-8 col-sm-8">
                             <asp:TextBox ID="tbRol" runat="server" CssClass="form-control" ReadOnly="true"
                                  />
                         </div>
                    </div>
                </div>
                 <div class="form-group">
                    <div class="row">
                       <div class="col-lg-4 col-md-4 col-sm-4">
                          <asp:Label Text="Contraseña" runat="server" />
                       </div>

                       <div class ="col-lg-8 col-md-8 col-sm-8">
                          <asp:TextBox ID="tbPassword" runat="server" TextMode="Password" CssClass="form-control" 
                                />
                       </div>
                    </div>
                </div>

                

                <div class="form-group">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <asp:Button ID="btnAgregarUsuario" runat="server" Text="Agregar" OnClick="btnAgregarUsuario_Click" ></asp:Button>
                        </div>
                    </div>
                </div>
        </div>
   
   </div>
        </center>
</asp:Content>
