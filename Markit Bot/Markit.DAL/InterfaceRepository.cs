using Entidades;
using System;
using System.Data;
using System.Data.SqlClient;

namespace Markit.DAL
{
    public class InterfaceRepository : Conexao
    {
        // Verifica Interface de Importação com Agendamento
        public Interface VerificaImportacaoInterfaceComAgendamento(String itfc, String tarefa, String tipo, string mercado)
        {
            try
            {
                // Conecção com o servidor

                AbreConexao();
                

                // Define a proc a ser executada

                cmd = new SqlCommand("bd_106_bbmfront..UP_Verifica_Importacao_Interface_Com_Agendamento", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 180;   // Aumenta timeout para consultas mais demoradas


                // Adicona os paramentros de busca da tarefa

                cmd.Parameters.AddWithValue("@Interface", itfc);
                cmd.Parameters.AddWithValue("@Tarefa", tarefa);
                cmd.Parameters.AddWithValue("@Tipo", tipo);
                cmd.Parameters.AddWithValue("@Mercado", mercado);
                cmd.Parameters.Add("@CodInstcItfc", SqlDbType.Int).Direction = ParameterDirection.Output;
                cmd.Parameters.Add("@Data", SqlDbType.Date).Direction = ParameterDirection.Output;
                cmd.Parameters.Add("@DataDefasagemArquivo", SqlDbType.Date).Direction = ParameterDirection.Output;


                // Executa a proc e recupera o dado do agendamento

                cmd.ExecuteNonQuery();

                Interface itfcRetorno = new Interface();
                
                if (cmd.Parameters["@CodInstcItfc"].Value is not DBNull)
                {
                    itfcRetorno.codInstc = Convert.ToInt32(cmd.Parameters["@CodInstcItfc"].Value);
                }
                if (cmd.Parameters["@Data"].Value is not DBNull)
                {
                    itfcRetorno.data = Convert.ToDateTime(cmd.Parameters["@Data"].Value);
                }
                if (cmd.Parameters["@DataDefasagemArquivo"].Value is not DBNull)
                {
                    itfcRetorno.dataDefasagemDias = Convert.ToDateTime(cmd.Parameters["@DataDefasagemArquivo"].Value);
                }

                return itfcRetorno;
            }
            catch (Exception e)
            {
                throw new System.Exception(e.Message);
            }
            finally
            {
                FechaConexao();
            }
        }


        public Boolean FinalizaInterface(int codigoInstanciaInterfaceControle, string stt, Boolean erro = false, String descErr = null)
        {
            try
            {
                // Conecção com o servidor

                AbreConexao();


                // Define a proc a ser executada

                cmd = new SqlCommand("bd_106_bbmfront..[UP_Atualiza_Status_Interface]", con);
                cmd.CommandType = CommandType.StoredProcedure;


                // Adicona os paramentros de Input

                SqlParameter codigoInstanciaInterfaceControleParametro = new SqlParameter("@cod_instc_itfc", codigoInstanciaInterfaceControle);
                codigoInstanciaInterfaceControleParametro.Direction = ParameterDirection.Input;
                cmd.Parameters.Add(codigoInstanciaInterfaceControleParametro);

                SqlParameter bitErroParametro = new SqlParameter("@erro", erro);
                bitErroParametro.Direction = ParameterDirection.Input;
                cmd.Parameters.Add(bitErroParametro);

                SqlParameter situacaoParametro = new SqlParameter("@stt", stt);
                situacaoParametro.Direction = ParameterDirection.Input;
                cmd.Parameters.Add(situacaoParametro);

                if (!String.IsNullOrEmpty(descErr))
                {
                    SqlParameter descricaoErroParametro = new SqlParameter("@desc_err", descErr);
                    descricaoErroParametro.Direction = ParameterDirection.Input;
                    cmd.Parameters.Add(descricaoErroParametro);
                }

                // Executa a proc

                cmd.ExecuteNonQuery();
            }
            catch (Exception e)
            {
                throw new Exception("Erro ao finalizar a interface - " + e.Message);
            }

            if (erro)
            {
                return false;
            }
            return true;
        }
    }
}
