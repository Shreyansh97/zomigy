using System;
using System.Collections.Generic;
using System.Web.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace zomigy
{
    public partial class Restaurant : System.Web.UI.Page
    {
        public class CommentEntry
        {
            public string Name { get; set; }
            public int Rating { get; set; }
            public string Comment { get; set; }

            public CommentEntry()
            {

            }

            public CommentEntry(string _name, int _rating, string _comment)
            {
                Name = _name;
                Rating = _rating;
                Comment = _comment;
            }
        }
        protected List<CommentEntry> CommentList;
        static string cs;
        public int resId;
        public Restaurant() 
        {
            CommentList = new List<CommentEntry>();
            cs = WebConfigurationManager.ConnectionStrings["localdb"].ConnectionString;
        }

        void Load_List()
        {
            SqlConnection con;
            SqlCommand cmd;
            SqlDataReader rd;

            int total = 0, nrows = 0;

            string cmdText = "SELECT [Users].[name] as name, rating, text, status FROM COMMENTS INNER JOIN [Users] on [Users].[id]=Comments.[User] where Comments.restaurant=@restaurant";
            using (con = new SqlConnection(cs))
            {
                using (cmd = new SqlCommand(cmdText, con))
                {
                    cmd.Parameters.AddWithValue("@restaurant", resId);
                    con.Open();
                    rd = cmd.ExecuteReader();

                    while (rd.Read())
                    {
                        if (rd["status"].ToString() == "Approved")
                        {
                            nrows++;
                            total += int.Parse(rd["rating"].ToString());

                            if (String.IsNullOrEmpty(rd["text"].ToString())) continue;

                            CommentList.Add(new CommentEntry(rd["name"].ToString(),
                                int.Parse(rd["rating"].ToString()),
                                rd["text"].ToString()));

                        }
                    }
                    con.Close();
                }
            }
            commentsGrid.DataSource = CommentList;
            commentsGrid.DataBind();

            if (nrows == 0)
                ratingLabel.Text = "No Ratings Yet";
            else
                ratingLabel.Text = String.Format("{0:0.00}", 1.0 * total / nrows);
        }

        void Update_View_Count()
        {
            SqlConnection con;
            SqlCommand cmd;

            string cmdText = "UPDATE Restaurants SET Views = Views + 1 WHERE id=@resId";

            using (con = new SqlConnection(cs))
            {
                using (cmd = new SqlCommand(cmdText, con))
                {
                    cmd.Parameters.AddWithValue("@resId", resId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["restaurant"] == null)
            {
                Response.Redirect("Home.aspx");
                return;
            }
            if (IsPostBack) return;

            Check_Restaurant_Exists();
            Update_View_Count();
            Load_List();
            this.DataBind();
        }

        protected void Check_Restaurant_Exists()
        {
            string restaurant = Request.QueryString["restaurant"];
            if (String.IsNullOrEmpty(restaurant))
                throw new HttpException(404, "Restaurant not found");

            resId = int.Parse(restaurant);
            SqlConnection con;
            SqlCommand cmd;
            SqlDataReader rd;
            string cmdText = "SELECT * FROM Restaurants WHERE id=@restaurant";

            using (con = new SqlConnection(cs))
            {
                using (cmd = new SqlCommand(cmdText, con))
                {
                    con.Open();
                    cmd.Parameters.AddWithValue("@restaurant", resId);
                    rd = cmd.ExecuteReader();

                    if (!rd.Read())
                    {
                        throw new HttpException(404, "Restaurant not found");
                    }
                    
                    restaurantNameLabel.Text = rd["name"].ToString();
                    locLabel.Text = rd["location"].ToString();
                    viewLabel.Text = rd["views"].ToString();
                    cuisineLabel.Text = rd["cuisine"].ToString();

                }
            }
        }

        protected void reviewSubmit_Click(object sender, EventArgs e)
        {
            Check_Restaurant_Exists();
            int rating = int.Parse(ratingChoice.SelectedValue);
            string review = reviewText.Text;

            if (CommentList == null)
                CommentList = new List<CommentEntry>();

            SqlConnection con;
            SqlCommand cmd;

            string cmdText = "INSERT INTO Comments (Restaurant, [User], Rating, Text, Status) Values(@res, @user, @rating, @text, @status)";

            using (con = new SqlConnection(cs))
            {
                using(cmd = new SqlCommand(cmdText, con))
                {
                    cmd.Parameters.AddWithValue("@res", resId);
                    cmd.Parameters.AddWithValue("@user", Master.CurrentUser.Id);
                    cmd.Parameters.AddWithValue("@rating", rating);
                    cmd.Parameters.AddWithValue("@text", review);
                    cmd.Parameters.AddWithValue("@status", "Pending");
                    //cmd.Parameters.AddWithValue("@status", "Approved");

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            Load_List();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            using(var con = new SqlConnection(WebConfigurationManager.ConnectionStrings["localdb"].ConnectionString))
            {
                using(var cmd = new SqlCommand("DELETE FROM Restaurants WHERE Id=@id", con))
                {
                    cmd.Parameters.AddWithValue("@id", Request.QueryString["restaurant"]);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            Response.Redirect("Home.aspx");
        }
    }
}