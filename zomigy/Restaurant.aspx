<%@ Page Title="Restaurant" Language="C#" MasterPageFile="~/Zomigy.Master" AutoEventWireup="True" CodeBehind="Restaurant.aspx.cs" Inherits="zomigy.Restaurant" Theme="Dark" %>

<%@ MasterType VirtualPath="~/Zomigy.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <form runat="server">
        <% if (Master.CurrentUser.Admin)
            {%>
        <a href="RestaurantEdit.aspx?id=<%# resId.ToString() %>">Edit</a>
        <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" />
        <% } %>
        <div>
            Name:<asp:Label ID="restaurantNameLabel" runat="server" Text="Name Here" />
            <br />
            Rating:<asp:Label ID="ratingLabel" runat="server" Text="Rating Here" />
            <br />
            Cuisine:<asp:Label ID="cuisineLabel" runat="server" Text="Cuisine Here" />
            <br />
            Location:<asp:Label ID="locLabel" runat="server" Text="Location Here" />
            <br />
            Views:<asp:Label ID="viewLabel" runat="server" Text="Views Here" />
        </div>
        <br />
        <div>
            <asp:Label ID="ratingChoiceLabel" runat="server" Text="Your Rating:" />
            <asp:RadioButtonList ID="ratingChoice" runat="server" RepeatDirection="Horizontal">
                <asp:ListItem>1</asp:ListItem>
                <asp:ListItem>2</asp:ListItem>
                <asp:ListItem>3</asp:ListItem>
                <asp:ListItem>4</asp:ListItem>
                <asp:ListItem>5</asp:ListItem>
            </asp:RadioButtonList>

            <asp:RequiredFieldValidator ID="ratingReq" ControlToValidate="ratingChoice" Display="Dynamic" ErrorMessage="Rating can't be blank" runat="server"/>

            <br />

            <asp:Label ID="reviewHeadingLabel" runat="server" Text="Your Comment:" />
            <br />
            <asp:TextBox ID="reviewText" runat="server" placeholder="Type Here" TextMode="MultiLine" />

            <br />

            <asp:Button ID="reviewSubmit" Text="Submit" OnClick="reviewSubmit_Click" runat="server" CausesValidation="true"/>

        </div>
        <br />
        <asp:Repeater ID="commentsGrid" runat="server">
            <ItemTemplate>
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="custName" Text='<%# Eval("Name") %>' Visible="true" runat="server" /></td>
                        <td>
                            <asp:Label ID="rating" Text='<%# Eval("Rating") %>' Visible="true" runat="server" /></td>
                        <td>
                            <asp:Label ID="comment" Text='<%# Eval("Comment") %>' Visible="true" runat="server" /></td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:Repeater>
    </form>
</asp:Content>
