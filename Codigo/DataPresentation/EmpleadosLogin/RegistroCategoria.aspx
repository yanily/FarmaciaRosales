<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RegistroCategoria.aspx.cs" Inherits="DataPresentation.RegistroCategoria" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <center>
    <div class="Panel col-lg-5 col-md-5 col-sm-5 mt-4">
        <div class="card">
             <div class="card-header bg-info">
                 <h4 class="TextoContenido">Registro Categorias</h4>
             </div>
            <div class="card-body">

                  <div class="form-group">  
                    <div class="row">        
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <asp:Label Text="Identificador de Categoria: " runat="server" />
                        </div>

                         <div class ="col-lg-8 col-md-8 col-sm-8">
                             <asp:TextBox ID="tbCategoria" runat="server" CssClass="form-control"  />                          
                         </div>                        
                    </div>
                </div>
                 
                <div class="form-group">  
                    <div class="row">        
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <asp:Label Text="Nombre " runat="server" />
                        </div>

                         <div class ="col-lg-8 col-md-8 col-sm-8">
                             <asp:TextBox ID="tbNombre" runat="server" CssClass="form-control"  />                             
                         </div>                        
                    </div>
                </div>

               
                
                </div>
                <div class="form-group">

                    <div class="row">

                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <asp:Button Text="Agregar" runat="server" OnClick="btnAgregarCategoria_Click" CssClass="btn btn-outline-info"  ID="btnAgregarCategoria"/>
                        </div>
                    </div>
                </div>


        </div>

    </div>
        </center>
</asp:Content>
