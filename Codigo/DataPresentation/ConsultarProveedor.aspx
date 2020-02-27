<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ConsultarProveedor.aspx.cs" Inherits="DataPresentation.ConsultarProveedor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <center>
    <div class="Panel col-lg-5 col-md-5 col-sm-5 mt-4"> 
     
        <div class="card">
             <div class="card-header bg-info">
                 <h4 class="TextoContenido">Consulta Proveedor</h4>
             </div>

             <div class="card-body">
                  <div class="form-group">
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <asp:Label Text="Proveedor" runat="server" />
                        </div>
                         <div class ="col-lg-8 col-md-8 col-sm-8">
                      <asp:DropDownList ID="DDLProveedor" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DDLProveedor_SelectedIndexChanged"></asp:DropDownList>
                         </div>
                    </div>
                </div>

                 <div class="form-group">
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <asp:Label Text="Tabla de Consulta" runat="server" />
                        </div>
                         <div class ="col-lg-8 col-md-8 col-sm-8">
                      <asp:GridView ID="gvConsultaProveedor" runat="server"  AutoGenerateColumns="False">
                          <Columns>
                               <asp:BoundField DataField="nombre" HeaderText="Nombre"></asp:BoundField>
                               <asp:BoundField DataField="direccion" HeaderText="Dirección"></asp:BoundField>
                               <asp:BoundField DataField="descripcion" HeaderText="Descripcion"></asp:BoundField>
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
