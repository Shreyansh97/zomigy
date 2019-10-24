<%@ Page Title="" Language="C#" MasterPageFile="~/Zomigy.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="zomigy.Register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    
    <div id="signup">
        <form runat="server">
            <h2>Signup:</h2>
            <label>Name:</label>
            <asp:TextBox ID="txtSignupName" runat="server"></asp:TextBox>
            <br />
            <label>Email:</label>
            <asp:TextBox ID="txtSignupEmail" runat="server"></asp:TextBox>
            <br />
            <label>Password:</label>
            <asp:TextBox ID="txtSignupPass" runat="server" TextMode="Password"></asp:TextBox>
            <br />
            <asp:Button ID="btnSignup" runat="server" Text="Signup" OnClick="btnSignup_Click" />
        </form>
        <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
    </div>

</asp:Content>
