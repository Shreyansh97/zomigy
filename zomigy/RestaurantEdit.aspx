<%@ Page Title="" Language="C#" MasterPageFile="~/Zomigy.Master" AutoEventWireup="true" CodeBehind="RestaurantEdit.aspx.cs" Inherits="zomigy.RestaurantEdit" %>

<%@ MasterType VirtualPath="~/Zomigy.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <form runat="server">
        <label>Name:</label>
        <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
        <br />
        <label>Location:</label>
        <asp:TextBox ID="txtLocation" runat="server"></asp:TextBox>
        <br />
        <label>Cuisine:</label>
        <asp:TextBox ID="txtCuisine" runat="server"></asp:TextBox>
        <br />
        <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" CausesValidation="true" />
        <asp:RequiredFieldValidator ControlToValidate="txtName" ErrorMessage="Name cannot be blank" runat="server"></asp:RequiredFieldValidator><br />
        <asp:RequiredFieldValidator ControlToValidate="txtLocation" ErrorMessage="Location cannot be blank" runat="server"></asp:RequiredFieldValidator><br />
        <asp:RequiredFieldValidator ControlToValidate="txtCuisine" ErrorMessage="Cuisine cannot be blank" runat="server"></asp:RequiredFieldValidator>
        <asp:Label ID="msg" runat="server"></asp:Label>
    </form>
</asp:Content>
