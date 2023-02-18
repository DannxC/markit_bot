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
    public class InsereImportacaoRepository : Conexao
    {
        // Inserir importação e recuperar a instância da tabela
        public int InsereImportacao(int numImportacoes)
        {
            try
            {
                // Abre conecção com o servidor

                AbreConexao();


                // Define a proc a ser executada

                cmd = new SqlCommand("UP_Insere_Importacao_Execucoes_Markit_IRS", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 180;   // Aumentar o timeout para consultas mais demoradas


                // Define o código da importação (cod_instc_ipc) como parâmetro de output

                SqlParameter cod_instc_ipc_param = new SqlParameter();
                cod_instc_ipc_param.ParameterName = "@cod_instc_ipc";
                cod_instc_ipc_param.DbType = DbType.Int32;
                cod_instc_ipc_param.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(cod_instc_ipc_param);


                // Executa a proc e captura o parâmetro de retorno

                int codInstcIpc;
                cmd.ExecuteNonQuery();
                codInstcIpc = (int)cmd.Parameters["@cod_instc_ipc"].Value;

                return codInstcIpc;
            }
            catch (Exception e)
            {
                //TextoResultado.InsereTexto("Erro ao inserir importacao");

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
