using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Markit.DAL
{
    public class LogErroRepository : Conexao
    {
        //Insere no bd o log de erro
        public void InsereLogErro(String erro)
        {
            String usr = Environment.UserDomainName + "/" + Environment.UserName;
            String maq = Environment.MachineName;
            String orig = "Robo_Markit";
            String cls = "Form_Markit.cs";
            String mtdo = "Timer_Gatilho_Tick";
            String msg = erro;

            try
            {
                //Conecção com o servidor
                AbreConexao();

                //Define a proc a ser executada
                cmd = new SqlCommand("bd_108_bbmcorp..UP_Insere_Log", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 180;   // Aumentar o timeout para consultas mais demoradas

                //Adicona os paramentros de busca da tarefa
                cmd.Parameters.AddWithValue("@usr", usr);
                cmd.Parameters.AddWithValue("@maq", maq);
                cmd.Parameters.AddWithValue("@orig", orig);
                cmd.Parameters.AddWithValue("@cls", cls);
                cmd.Parameters.AddWithValue("@mtdo", mtdo);
                cmd.Parameters.AddWithValue("@msg", msg);

                //Executa a proc e recupera o dado do agendamento
                cmd.ExecuteNonQuery();
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                FechaConexao();
            }
        }
    }
}
