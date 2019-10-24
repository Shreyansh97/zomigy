using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace zomigy
{
    public partial class Zomigy : System.Web.UI.MasterPage
    {
        public User CurrentUser { get; set; }
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            if(Page.User.Identity.IsAuthenticated)
            {
                CurrentUser = new User(Page.User.Identity.Name);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}