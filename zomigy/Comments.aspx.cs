using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Web.Configuration;

namespace zomigy
{
    public partial class Comments : System.Web.UI.Page
    {
        static string cs;
        public Comments()
        {
            cs = WebConfigurationManager.ConnectionStrings["localdb"].ConnectionString;
        }

        void commentsGrid_RowDataBound()
        {
            SqlConnection con;

            string cmd = "select Comments.Id as Id, [Users].[name] as [User], Restaurants.name as Restaurant, Comments.Rating as Rating, Comments.Text as Text, Comments.Timestamp as Timestamp, Comments.Status as Status from Comments JOIN [Users] on Comments.[User] = [Users].Id JOIN Restaurants ON Restaurants.Id = Comments.Restaurant";
            using (con = new SqlConnection(cs))
            {
                SqlDataAdapter dap = new SqlDataAdapter(cmd, con);
                DataSet ds = new DataSet();
                dap.Fill(ds);
                commentsGrid.DataSource = ds.Tables[0];
                commentsGrid.DataBind();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            if (!Master.CurrentUser.Admin)
            {
                //Response.Redirect("Home.aspx");
            }
            commentsGrid_RowDataBound();
        }

        protected void commentsGrid_RowEditing(object sender, GridViewEditEventArgs e)
        {
            commentsGrid.EditIndex = e.NewEditIndex;
            commentsGrid_RowDataBound();
        }

        protected void commentsGrid_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            commentsGrid.EditIndex = -1;
            commentsGrid_RowDataBound();
        }

        protected void commentsGrid_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if ((e.Row.RowState & DataControlRowState.Edit) > 0)
                {
                    DropDownList ddList = (DropDownList)e.Row.FindControl("ddl_status");
                    ddList.Items.Add("Approved");
                    ddList.Items.Add("Rejected");
                    ddList.Items.Add("Pending");
                    ddList.DataTextField = "status_Name";
                    ddList.DataValueField = "status_Id";

                    DataRowView dr = e.Row.DataItem as DataRowView;
                    ddList.SelectedValue = dr["Status"].ToString();
                }
            }
        }

        protected void commentsGrid_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            
            string newStatus = (((DropDownList)commentsGrid.Rows[e.RowIndex].FindControl("ddl_status")).SelectedValue).ToString();
            int id = int.Parse(((Label)commentsGrid.Rows[e.RowIndex].FindControl("Label0")).Text);

            string cmdText = "UPDATE Comments Set Status=@newStatus where Id=@id";

            SqlConnection con;
            SqlCommand cmd;
            using (con = new SqlConnection(cs))
            {
                using(cmd = new SqlCommand(cmdText, con))
                {
                    cmd.Parameters.AddWithValue("@newStatus", newStatus);
                    cmd.Parameters.AddWithValue("@id", id);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            commentsGrid.EditIndex = -1;
            commentsGrid_RowDataBound();
        }

        protected void commentsGrid_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            commentsGrid.PageIndex = e.NewPageIndex;
            commentsGrid_RowDataBound();
        }
    }
}