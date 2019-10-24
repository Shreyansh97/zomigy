using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Web.Security;
using System.Data.Sql;
using System.Data;
using System.Data.SqlClient;

namespace zomigy
{
    public partial class Index : System.Web.UI.Page
    {
        private string connectionString = WebConfigurationManager.ConnectionStrings["localdb"].ToString();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string id = null;
            string admin = null;
            using (var connection = new SqlConnection(connectionString))
            {
                using(var command = new SqlCommand("SELECT * FROM Users WHERE email=@email AND password=@pass", connection))
                {
                    command.Parameters.AddWithValue("@email", txtLoginEmail.Text);
                    command.Parameters.AddWithValue("@pass", txtLoginPass.Text);
                    connection.Open();
                    var reader = command.ExecuteReader();
                    using (reader)
                    {
                        if (reader.Read())
                        {
                            id = reader["Id"].ToString();
                            admin = reader["admin"].ToString();
                            connection.Close();
                        }
                    }      
                }
            }
            if (id != null)
            {
                var role = "user";
                if (admin == "True")
                {
                    role = "admin";
                }
                var ticket = new FormsAuthenticationTicket(
                    1,
                    id,
                    DateTime.Now,
                    DateTime.Now.AddDays(30),
                    true,
                    role,
                    FormsAuthentication.FormsCookiePath);

                string encTicket = FormsAuthentication.Encrypt(ticket);

                Response.Cookies.Add(new HttpCookie(FormsAuthentication.FormsCookieName, encTicket));

                Response.Redirect("Home.aspx");
            }
            else
            {
                lblLoginMsg.Text = "Invalid credentials. Please check the entered values";
            }
        }
    }
}