<%@ Page Title="Restaurant" Language="C#" MasterPageFile="~/Zomigy.Master" AutoEventWireup="True" CodeBehind="Restaurant.aspx.cs" Inherits="zomigy.Restaurant" Theme="Dark" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <form runat="server">
        <asp:Label ID="restaurantNameLabel" runat="server" Text="Name"/>
        <%--<asp:Label ID="ratingLabel" runat="server" Text="Rating Here" />--%>
    
        <asp:Repeater ID="commentsGrid" runat="server" >
            <ItemTemplate>
                <table>
                    <%--<tr><td><asp:TextBox ID="custName" Text='<%# Eval("Name") %>' Visible="true" runat="server"/></td>--%>
                    <td><asp:TextBox ID="rating" Text='<%# Eval("Rating") %>' Visible="true" runat="server"/></td>
                    <td><asp:TextBox ID="comment" Text='<%# Eval("Comment") %>' Visible="true" runat="server"/></td></tr>
                </table>
            </ItemTemplate>
        </asp:Repeater>
    </form>
    <%--  --%>
</asp:Content>