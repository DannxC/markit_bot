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
    public class ProcessaDadosRepository : Conexao
    {
        // Inserir importação e recuperar a instância da tabela
        public void ProcessaExecucoes(int codInstcIpc)
        {
            try
            {
                // Abre conecção com o servidor

                AbreConexao();


                // Define a proc a ser executada

                cmd = new SqlCommand("UP_Processa_Execucoes_Markit_IRS", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 180;   // Aumentar o timeout para consultas mais demoradas


                // Define o código da importação (cod_instc_ipc) como parâmetro de input

                cmd.Parameters.AddWithValue("@cod_instc_ipc", codInstcIpc);


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
