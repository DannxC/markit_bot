using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Configuration;
using Entidades;
using Markit.Utils;
using System.Data.SqlTypes;
using System.Data.SqlClient;        // nuGet

namespace Markit.DAL
{
    public class EnviaEmailNovasTagsRepository : Conexao
    {
        // Inserir importação e recuperar a instância da tabela
        public void EnviaEmail(List<string> novasTags)
        {
            try
            {
                // Abre conecção com o servidor

                AbreConexao();


                // Define a proc a ser executada

                cmd = new SqlCommand("bd_108_bbmcorp..UP_Envia_Email", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 180;   // Aumentar o timeout para consultas mais demoradas


                // Define o código da importação (cod_instc_ipc) como parâmetro de input

                cmd.Parameters.AddWithValue("@nome_da_rotina_executora", "ALERTA_VERIFICA_MAPEAMENTO_DE_TAGS_MARKIT");      // precisa disso? é uma rotina, mas sei la.....
                cmd.Parameters.AddWithValue("@profile_name", "Monitoramento");                                              // idem
                cmd.Parameters.AddWithValue("@recipients", ConfigurationManager.AppSettings["email_novas_tags"]);
                cmd.Parameters.AddWithValue("@subject", "Alerta: Novas Tags nos arquivos de XML - Markit");
                cmd.Parameters.AddWithValue("@body", "As seguintes Tags foram encontradas na última importação realizada pelo robô do Markit:\n\n\t" + String.Join(";\n\t", novasTags) + ";");


                // Executa a proc

                cmd.ExecuteNonQuery();
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                // Fecha conexão com o servidor

                FechaConexao();
            }
        }
    }
}
