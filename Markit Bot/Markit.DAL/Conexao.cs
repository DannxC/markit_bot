using System.Data.SqlClient;
using System.Configuration;
using System;

namespace Markit.DAL
{
    public class Conexao
    {
        protected SqlConnection con;
        protected SqlCommand cmd;
        protected SqlDataReader dr;


        protected string conStr;


        public void AbreConexao()
        {
            try
            {
                if (ConfigurationManager.AppSettings["bd"] == "dsv")
                {
                    conStr = ConfigurationManager.ConnectionStrings["bd_dsv"].ConnectionString;
                }
                else if (ConfigurationManager.AppSettings["bd"] == "prd")
                {
                    conStr = ConfigurationManager.ConnectionStrings["bd_prd"].ConnectionString;
                }


                con = new SqlConnection(conStr);
                con.Open();
            }
            catch (Exception e)
            {
                // Util.InsereLogArquivo("Conexão SQL SERVER", "Conexao", "AbreConexao()", "Erro na conexão : ", e.Message);
                throw new System.Exception("Erro na conexão com o banco de dados - " + e.Message);
            }
        }


        protected void FechaConexao()
        {
            if (con != null)
            {
                con.Close();
            }
        }


        public string GetConnectionString()
        {
            return this.conStr;
        }


        public SqlConnection GetConnection()
        {
            return con;
        }
    }
}
