<%@ Page Title="" Language="C#" MasterPageFile="~/Zomigy.Master" AutoEventWireup="True" CodeBehind="Home.aspx.cs" Inherits="zomigy.RestaurantList" %>

<%@ MasterType VirtualPath="~/Zomigy.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <asp:SqlDataSource ID="Restaurants" runat="server" ConnectionString="<%$ ConnectionStrings:localdb %>" ProviderName="System.Data.SqlClient" SelectCommand="SELECT * FROM [Restaurants]"></asp:SqlDataSource>
    <% if (Master.CurrentUser.Admin)
       {%>
        <a href="RestaurantEdit.aspx">Add new restaurant</a>
    <% } %>
    <br />
    <br />
    <asp:Repeater DataSourceID="Restaurants" runat="server">
        <ItemTemplate>
            <a href="Restaurant.aspx?restaurant=<%# Eval("Id") %>">
                <div class="card">
                    <b><%# Eval("name") %></b><br />
                    Rating:<%# Eval("rating") %><br />
                    Views:<%# Eval("views") %><br />
                    Location: <%# Eval("location") %><br />
                    Cuisine: <%# Eval("cuisine") %><br />
                </div>
            </a>
        </ItemTemplate>
        <SeparatorTemplate>
            <br />
            <hr />
            <br />
        </SeparatorTemplate>
    </asp:Repeater>
</asp:Content>
