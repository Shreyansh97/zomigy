using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Data.SqlClient;

namespace zomigy
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSignup_Click(object sender, EventArgs e)
        {
            using (var connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["localdb"].ConnectionString))
            {
                using(var cmd = new SqlCommand("INSERT INTO Users(name, email, password) Values(@name, @email, @password)", connection))
                {
                    cmd.Parameters.AddWithValue("@name", txtSignupName.Text);
                    cmd.Parameters.AddWithValue("@email", txtSignupEmail.Text);
                    cmd.Parameters.AddWithValue("@password", txtSignupPass.Text);
                    connection.Open();
                    try
                    {
                        int result = cmd.ExecuteNonQuery();
                        connection.Close();

                        if (result == 1)
                        {
                            Response.Redirect("Index.aspx");
                        }
                        else
                        {
                            lblMsg.Text = "An account with that email already exists";
                        }
                    }
                    catch(SqlException) 
                    {
                        lblMsg.Text = "An account with that email already exists";
                    }
                }
            }

        }
    }
}