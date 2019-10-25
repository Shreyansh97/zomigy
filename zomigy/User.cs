using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace zomigy
{
    public class User
    {
        public string Name;
        public string Email;
        public int Id;
        public bool Admin;

        public User(string id)
        {
            var constr = WebConfigurationManager.ConnectionStrings["localdb"].ConnectionString;
            using (var conn = new SqlConnection(constr))
            {
                using (var cmd = new SqlCommand("SELECT * FROM Users WHERE Id=@id", conn))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    conn.Open();
                    using(var reader = cmd.ExecuteReader())
                    {
                        if(reader.Read())
                        {
                            Name = reader["name"].ToString();
                            Email = reader["email"].ToString();
                            Id = Convert.ToInt32(id);
                            Admin = reader["admin"].ToString().Equals("True");
                        }
                        else
                        {
                            throw new Exception("User not found");
                        }
                        conn.Close();
                    }
                }
            }
        }

        public User()
        {

        }
    }
}