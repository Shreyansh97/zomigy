using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
        protected void Page_Load(object sender, EventArgs e)
        {
            CommentList = new List<CommentEntry>();

            // TODO: Populate CommentList from DB

            CommentList.Add(new CommentEntry("Dheeraj", 5, "This was great!"));
            CommentList.Add(new CommentEntry("Shreyansh", 4, "This was good."));

            commentsGrid.DataSource = CommentList;
            commentsGrid.DataBind();
        }
    }
}