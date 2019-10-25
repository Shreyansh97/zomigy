<%@ Page Title="" Language="C#" MasterPageFile="~/Zomigy.Master" AutoEventWireup="true" CodeBehind="Comments.aspx.cs" Inherits="zomigy.Comments" %>
<%@ MasterType VirtualPath="~/Zomigy.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <div>
        <form runat="server">
            <asp:GridView ID="commentsGrid" runat="server"
                AutoGenerateColumns="false" OnRowCancelingEdit="commentsGrid_RowCancelingEdit" 
                OnRowEditing="commentsGrid_RowEditing" OnRowDataBound="commentsGrid_RowDataBound"
                OnRowUpdating="commentsGrid_RowUpdating" AllowPaging="true" PageSize="25" 
                OnPageIndexChanging="commentsGrid_PageIndexChanging" AllowSorting="true">
                <Columns>
                    <asp:TemplateField HeaderText="ID">
                        <ItemTemplate>
                            <asp:Label ID="Label0" runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Restaurant">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("Restaurant") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="User">
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("User") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Rating">
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("Rating") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Comment">
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Eval("Text") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Timestamp">
                        <ItemTemplate>
                            <asp:Label ID="Label41" runat="server" Text='<%# Eval("Timestamp") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Status">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddl_status" runat="server"></asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ShowHeader="false">
                        <EditItemTemplate>
                            <asp:LinkButton ID="btn1" runat="server" CausesValidation="True"
                                CommandName="Update" Text="Update"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="btn2" runat="server" CausesValidation="false"
                                CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:LinkButton ID="btn3" runat="server" CausesValidation="false"
                                CommandName="Edit" Text="Edit"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </form>
    </div>
</asp:Content>
