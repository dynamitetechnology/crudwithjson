using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CrudUsingAjax
{
    public partial class _Default : Page
    {

        static SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {

        }


        [WebMethod]
        public static string savecontacts(string name, string email, string phone)
        {
            Dictionary<string, string> names = new Dictionary<string, string>();
            try
            {
                con.Open();
                string sql = "insert into contact (name, email, phone) values ('" + name + "','" + email + "','" + phone + "')";
                SqlCommand cmd = new SqlCommand(sql, con);

                int status = cmd.ExecuteNonQuery();
              
                if (status > 0)
                {
                    names.Add("status", "200");
                    names.Add("message", "success");
                    return JsonConvert.SerializeObject(names);
                }
                else
                {
                    names.Add("status", "400");
                    names.Add("message", "fail");
                    return JsonConvert.SerializeObject(names);
                }
            }
            catch (Exception ex)
            {
                names.Add("status", "400");
                names.Add("message", ex.Message);
                return JsonConvert.SerializeObject(names);
            }
            finally
            {
                con.Close();
            }
        }

        [WebMethod]
        public static string displaycontacts()
        {
            Dictionary<string, string> names = new Dictionary<string, string>();
            try
            {
                con.Open();
                string sql = " select id, name, email, phone from contact ";
                SqlCommand cmd = new SqlCommand(sql, con);
                SqlDataReader sda = cmd.ExecuteReader();
                List<Contacts> contactList = new List<Contacts>();

                while (sda.Read())
                {
                    Contacts contact = new Contacts();
                    contact.id = Convert.ToInt32(sda["id"]);
                    contact.name = sda["name"].ToString();
                    contact.email = sda["email"].ToString();
                    contact.phone = sda["phone"].ToString();
                    contactList.Add(contact);
                }



                return JsonConvert.SerializeObject(contactList);
            }
            catch (Exception ex)
            {
                names.Add("status", "400");
                names.Add("message", ex.Message);
                return JsonConvert.SerializeObject(names);
            }
            finally
            {
                con.Close();
            }

        }
    }
}