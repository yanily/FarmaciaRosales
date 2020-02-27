<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Catalogo.aspx.cs" Inherits="DataPresentation.Catalogo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <br />


    <div>
     <Center>
           <h2> <asp:Label ID="Label1" runat="server" ForeColor="HotTrack" Text ="Label">Catalogo </asp:Label> </h2>
        <br />
        <asp:DataList ID="dlInventario" runat="server" RepeatColumns="3" OnItemCommand="dlInventario_ItemCommand"> 

            <ItemTemplate>
                    <div>
                      <div class="card" style="width: 18rem;">
                         <img  src='<%#Eval("imagen")%>' class="card-img-top" alt="Medicamentos">
                      <div class="card-body">
                          <h5 class="card-title"><%#Eval("nombre")%></h5>
                          <p class="card-text">Descripcion: <%#Eval("descripcion")%>                         </p>
                          
                          <p class="card-text">           Existencias: <%#Eval("existencias")%>       </p>
                            <p class="card-text">           Precio Venta: <%#Eval("precioVenta")%>        </p>
                            <p class="card-text">           Precio Compra: <%#Eval("precioCompra")%>      </p>
             
                        </div>
                       </div>
                     </div>
                </ItemTemplate>

        </asp:DataList>
     </Center>
    </div>

</asp:Content>
