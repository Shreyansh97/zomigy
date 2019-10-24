<%@ Page Title="Zomigy" Language="C#" MasterPageFile="~/Zomigy.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="zomigy.Index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <div id="login">
        <form runat="server">
            <h2>Login to continue:</h2>
            <label>Email:</label>
            <asp:TextBox ID="txtLoginEmail" runat="server"></asp:TextBox>
            <br />
            <label>Password:</label>
            <asp:TextBox ID="txtLoginPass" runat="server" TextMode="Password"></asp:TextBox>
            <br />
            <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />
        </form>
        <asp:Label ID="lblLoginMsg" runat="server" ForeColor="Red"></asp:Label>
    </div>
</asp:Content>
<%--  --%>