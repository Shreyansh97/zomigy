<%@ Page Title="" Language="C#" MasterPageFile="~/Zomigy.Master" AutoEventWireup="True" CodeBehind="Home.aspx.cs" Inherits="zomigy.RestaurantList" %>

<%@ MasterType VirtualPath="~/Zomigy.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <asp:SqlDataSource ID="Restaurants" runat="server" ConnectionString="<%$ ConnectionStrings:localdb %>" ProviderName="System.Data.SqlClient" SelectCommand="SELECT * FROM [Restaurants] WHERE (([rating] >= @rating) AND ([rating] <= @rating2) AND ([name] LIKE '%' + @name + '%') AND ([cuisine] LIKE '%' + @cuisine + '%') AND ([location] LIKE '%' + @location + '%'))">
        <SelectParameters>
            <asp:ControlParameter ControlID="MinRating" PropertyName="SelectedValue" Name="rating" Type="Double" DefaultValue="0"></asp:ControlParameter>
            <asp:ControlParameter ControlID="MaxRating" PropertyName="SelectedValue" Name="rating2" Type="Double" DefaultValue="5"></asp:ControlParameter>
            <asp:ControlParameter ControlID="Name" PropertyName="Text" Name="name" Type="String" DefaultValue="_"></asp:ControlParameter>
            <asp:ControlParameter ControlID="Cuisine" PropertyName="Text" DefaultValue="_" Name="cuisine" Type="String"></asp:ControlParameter>
            <asp:ControlParameter ControlID="Location" PropertyName="Text" DefaultValue="_" Name="location" Type="String"></asp:ControlParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <% if (Master.CurrentUser.Admin)
       {%>
        <a href="RestaurantEdit.aspx">Add new restaurant</a>
    <% } %>
    <br />
    <br />
    <form runat="server">
        <asp:TextBox ID="Name" runat="server" placeholder="Name"></asp:TextBox>
        <asp:TextBox ID="Location" runat="server" placeholder="Location"></asp:TextBox>
        <asp:TextBox ID="Cuisine" runat="server" placeholder="Cuisine"></asp:TextBox>
        Min Rating:<asp:DropDownList ID="MinRating" runat="server">
            <asp:ListItem Text="0" Value="0" Selected="True"></asp:ListItem>
            <asp:ListItem Text="1" Value="1"></asp:ListItem>
            <asp:ListItem Text="2" Value="2"></asp:ListItem>
            <asp:ListItem Text="3" Value="3"></asp:ListItem>
            <asp:ListItem Text="4" Value="4"></asp:ListItem>
            <asp:ListItem Text="5" Value="5"></asp:ListItem>
        </asp:DropDownList>
        Max Rating:<asp:DropDownList ID="MaxRating" runat="server">
            <asp:ListItem Text="0" Value="0"></asp:ListItem>
            <asp:ListItem Text="1" Value="1"></asp:ListItem>
            <asp:ListItem Text="2" Value="2"></asp:ListItem>
            <asp:ListItem Text="3" Value="3"></asp:ListItem>
            <asp:ListItem Text="4" Value="4"></asp:ListItem>
            <asp:ListItem Text="5" Value="5" Selected="True"></asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="Search" runat="server" Text="Filter" />
    </form>
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
            <br />
        </SeparatorTemplate>
    </asp:Repeater>
</asp:Content>
