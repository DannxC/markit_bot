using System;
using System.Collections.Generic;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;        // nuGet

namespace Markit.DAL
{
    public class AgendamentoRepository : Conexao
    {
        // Inserir importação e recuperar a instância da tabela
        public List<string> VerificaAgendamentos(string tipo, string tarefa)
        {
            List<string> tarefasAgendadas = new List<string>();

            try
            {
                // Abre conecção com o servidor

                AbreConexao();


                // Define a proc a ser executada

                cmd = new SqlCommand("bd_106_bbmfront..UP_Verifica_Agendamentos_Tarefas", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 180;   // Aumentar o timeout para consultas mais demoradas


                // Define o código da importação (cod_instc_ipc) como parâmetro de output

                cmd.Parameters.AddWithValue("@Tipo", tipo);
                cmd.Parameters.AddWithValue("@Tarefa", tarefa);


                // Executa a proc e captura os dados do agendamento

                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    if(!(dr["Tarefa"] is DBNull))
                    {
                        tarefasAgendadas.Add(Convert.ToString(dr["Tarefa"]));
                    }
                }

                return tarefasAgendadas;
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
