using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace zomigy
{
    public partial class RestaurantEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Master.CurrentUser.Admin)
            {
                Response.Redirect("Index.aspx");
            }
            if(!IsPostBack && Request.QueryString["id"] != null)
            {
                using (var con = new SqlConnection(WebConfigurationManager.ConnectionStrings["localdb"].ConnectionString))
                {
                    using (var cmd = new SqlCommand("SELECT * FROM Restaurants WHERE Id=@id", con))
                    {
                        cmd.Parameters.AddWithValue("@id", Request.QueryString["id"]);
                        con.Open();
                        using(var reader = cmd.ExecuteReader())
                        {
                            if(reader.Read())
                            {
                                txtName.Text = reader["name"].ToString();
                                txtLocation.Text = reader["location"].ToString();
                                txtCuisine.Text = reader["cuisine"].ToString();
                            }
                            else
                            {
                                Request.QueryString["id"] = null;
                            }
                        }
                    }
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            using (var con = new SqlConnection(WebConfigurationManager.ConnectionStrings["localdb"].ConnectionString))
            {
                using(var cmd = new SqlCommand())
                {
                    cmd.Connection = con;
                    if(Request.QueryString["id"] != null)
                    {
                        cmd.CommandText = "UPDATE Restaurants SET name=@name, location=@loc, cuisine=@cuisine WHERE id=@id";
                        cmd.Parameters.AddWithValue("@id", Request.QueryString["id"]);
                    } 
                    else
                    {
                        cmd.CommandText = "INSERT INTO Restaurants(name, location, cuisine, rating, views) Values(@name, @loc, @cuisine, 0, 0)";
                    }
                    cmd.Parameters.AddWithValue("@name", txtName.Text);
                    cmd.Parameters.AddWithValue("@loc", txtLocation.Text);
                    cmd.Parameters.AddWithValue("@cuisine", txtCuisine.Text);
                    con.Open();
                    int res = cmd.ExecuteNonQuery();
                    con.Close();
                    if(res==1)
                    {
                        msg.Text = "Operation successful";
                    }
                    else
                    {
                        msg.Text = "Some error occurred";
                    }
                }
            }
        }
    }
}