<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="DataPresentation.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

     <center>
        <br />
        <h1>Login</h1>
        <asp:Login ID="LoginNTier" runat="server" UserNameLabelText="Usuario: " PasswordLabelText="Contraseña: "
            RememberMeText="Recordarme la próxima vez" TitleText="Inicio de sesión" LoginButtonText="Inicio"
            OnAuthenticate="LoginNTier_Authenticate">
        </asp:Login>
    </center>


</asp:Content>
