using System;
using System.Collections.Generic;
using System.Configuration;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Windows.Forms;
using Entidades;
using Markit.BLL;
using Markit.Utils;

namespace Markit
{
    public partial class Form_Markit : Form
    {
        // Define variáveis de controle

        int execucoes = 0;
        bool horarioValido;

        DateTime ultimaLimpezaMetadados = DateTime.Now;
        int tempoLimpezaMetadados = int.Parse(ConfigurationManager.AppSettings["tempo_limpeza"]);

        TimeSpan tempoProcessamento;
        int qtd_linhas;

        string entrada = ConfigurationManager.AppSettings["caminho_pasta_xml_markit"];
        string processando = ConfigurationManager.AppSettings["caminho_pasta_xml_markit_processando"];
        string processados = ConfigurationManager.AppSettings["caminho_pasta_xml_markit_processados"];
        string erros = ConfigurationManager.AppSettings["caminho_pasta_xml_markit_erro"];

        string tipo = "Robo_Markit";
        string tarefa = "Importacao_Dados_Markit";
        string itfc = "Importacao_Markit";
        string mercado = "OFF";

        string caminhoTags = ConfigurationManager.AppSettings["caminho_para_arquivo_texto_xml_tags"];

        String dirLog = ConfigurationManager.AppSettings["diretorioMetadados"];
        int diasCorte = int.Parse(ConfigurationManager.AppSettings["diasCorte"]);
        String sufixo = "\\Log_Metadados - ";


        // Inicializa Instâncias Business

        AgendamentoBusiness agendamentoBusiness = new AgendamentoBusiness();
        InterfaceBusiness interfaceBusiness = new InterfaceBusiness();
        LeitorBusiness leitorBusiness = new LeitorBusiness();
        VerificarMapeamentoBusiness verificarMapeamentoBusiness = new VerificarMapeamentoBusiness();
        EnviaEmailNovasTagsBusiness enviaEmailNovasTagsBusiness = new EnviaEmailNovasTagsBusiness();
        ConversorBusiness conversorBusiness = new ConversorBusiness();
        LinearizaDadosXMLBusiness linearizaDadosXMLBusiness = new LinearizaDadosXMLBusiness();
        InsereImportacaoBusiness insereImportacaoBusiness = new InsereImportacaoBusiness();
        BulkInsertBusiness bulkInsertBusiness = new BulkInsertBusiness();
        ProcessaExecucoesBusiness processaDadosBusiness = new ProcessaExecucoesBusiness();
        LogErroBusiness logErroBusiness = new LogErroBusiness();


        // Constructor do Forms

        public Form_Markit()
        {
            InitializeComponent();


            // Adiciona os campos ao data grid de Exportacoes

            dataGrid.Rows.Add("Markit", "", "", "");
        }


        // Loop principal
        private void timerGatilho_Tick(object sender, EventArgs e)
        {
            try
            {
                /* Ações iniciais de cada execução */

                // Marca hora da próxima execução (horário local da máquina)
                textProxExec.Text = DateTime.Now.AddSeconds(double.Parse(textTemporizador.Text)).ToString("HH:mm:ss");


                // Verifica se a hora atual está entre a hora inicial e final
                horarioValido = ValidaHorario();
                if (!horarioValido) { return; }


                // Define data incício -- muda as variáveis para "executando"

                DateTime inicioProcessamento = DateTime.Now;

                labelStatus.Text = "Executando";
                labelStatus.ForeColor = Color.Red;
                panel1.BackColor = Color.Red;


                // Atualizar o log local (iniciar)
                EscreveLogLocal("-------------------- Iniciado processamento --------------------", false);


                /* ---------------------------------------- Passos lógicos ---------------------------------------- */

                // Declaração de variáveis

                List<string> tarefasAgendadas;
                Interface itfcObj;
                List<string> xmlTexts;
                List<string> novasTags;
                List<SWML> xmlObjects;
                int codInstcIpc;
                List<XMLDadosLinearizados> xmlDadosLista;


                // 1 - Verifica se há agendamento e retorna parâmetros da interface
                EscreveLogLocal("(1): " + "Verificando agendamentos.", false);
                tarefasAgendadas = agendamentoBusiness.VerificaAgendamentos(tipo, tarefa);
                if (tarefasAgendadas.Count > 0)
                {
                    EscreveLogLocal("(1.1): " + tarefasAgendadas.Count.ToString() + " Agendamentos encontrados.", false);
                }
                else
                {
                    EscreveLogLocal("(1.1): " + "Nenhum agendamento encontrado.", false);
                    return;
                }

                // Verifica Interface
                itfcObj = interfaceBusiness.VerificaImportacaoInterfaceComAgendamento(itfc, tarefa, tipo, mercado);
                if(itfcObj.codInstc == 0)
                {
                    EscreveLogLocal("(1.2): Interface não encontrada.", false);
                    return;
                }

                // Atualiza as execuções (incremento)
                execucoes++;
                textExecs.Text = execucoes.ToString();


                // 2 - Movendo da pasta de Entrada para a pasta de Processando
                EscreveLogLocal("(2): " + " Movendo arquivos para a pasta de processando.", false);
                List<string> listaArquivosEntrada = Directory.EnumerateFiles(entrada).ToList();
                if (listaArquivosEntrada.Count > 0)
                {
                    EscreveLogLocal("(2.1): " + listaArquivosEntrada.Count.ToString() + " Arquivos encontrados na pasta de entrada.", false);
                }
                else
                {
                    EscreveLogLocal("(2.1): " + "Nenhum arquivo encontrado na pasta de entrada.", false);

                    // Marca a interface com erro e passa a descricao do erro
                    interfaceBusiness.FinalizaInterface(itfcObj.codInstc, true, "Nenhum arquivo encontrado na pasta de entrada.");
                    
                    return;
                }
                MoveArquivos.MoveArquivo(entrada, processando);


                // 3 - Ler arquivos no diretório                
                xmlTexts = leitorBusiness.LerArquivo();
                                
                if (xmlTexts.Count > 0)
                {
                    EscreveLogLocal("(3): " + xmlTexts.Count.ToString() + " Arquivos XML lidos.", false);
                }
                else
                {
                    EscreveLogLocal("(3): " + "Nenhum arquivo XML lido.", false);

                    // Marca a interface com erro e passa a descricao do erro
                    interfaceBusiness.FinalizaInterface(itfcObj.codInstc, true, "Nenhum arquivo XML lido.");
                    
                    return;
                }



                /* Será descomentado quando validarmos o funcionamento desta etapa de validação de Tags */

                // 4 - Verificar se há tags não mapeadas em todos os xmlTexts
                novasTags = verificarMapeamentoBusiness.VerificaTagAdicional(xmlTexts, caminhoTags);
                
                if (novasTags.Count > 0)
                {
                    EscreveLogLocal("(4): " + novasTags.Count.ToString() + " Tags encontradas nos arquivos XML.", false);
                
                    // Enviar email avisando que há novas Tags;
                    enviaEmailNovasTagsBusiness.EnviaEmail(novasTags);
                }
                else
                {
                    EscreveLogLocal("(4): " + "Não há novas Tags nos arquivos XML.", false);
                }



                // 5 - Transformar os xmlTexts em Objetos
                List<string> xmlTextsComErro = new List<string>();
                EscreveLogLocal("(5): " + "Parseando XML para objeto.", false);
                xmlObjects = conversorBusiness.ConverterXmlParaObjeto(xmlTexts, xmlTextsComErro);
                if (xmlObjects.Count > 0)
                {
                    EscreveLogLocal("(5.1): " + xmlObjects.Count.ToString() + " Objetos XML criados.", false);
                }
                else
                {
                    EscreveLogLocal("(5.1): " + "Erro ao parsear o XML.", false);

                    // Marca a interface com erro e passa a descricao do erro
                    interfaceBusiness.FinalizaInterface(itfcObj.codInstc, true, "Erro ao parsear o XML.");

                    return;
                }


                // 6 - Filtrar, dos xmlObjects, uma lista de dados úteis para a aplicação em si
                EscreveLogLocal("(6): " + "Convertendo dados num objeto linear.", false);
                xmlDadosLista = linearizaDadosXMLBusiness.LinearizaDadosXML(xmlObjects);


                // 7 - Inserir importações e recuperar as instâncias da tabela -- Proc no bd
                EscreveLogLocal("(7): " + "Inserindo a importação.", false);
                codInstcIpc = insereImportacaoBusiness.InsereImportacao(xmlDadosLista.Count);
                if (xmlDadosLista.Count > 0)
                {
                    EscreveLogLocal("(7.1): " + "Importação registrada. ID: " + codInstcIpc.ToString() + ".", false);
                }
                else
                {
                    EscreveLogLocal("(7.1): " + "Falha no registro da importação.", false);

                    // Marca a interface com erro e passa a descricao do erro
                    interfaceBusiness.FinalizaInterface(itfcObj.codInstc, true, "Falha no registro da importação.");

                    return;
                }
                

                // 7 - Bulk Insert dos xmlDadosLista com os respectivos codInstcIpc
                EscreveLogLocal("(8): " + "Inserindo dados na tabela temporária.", false);
                bulkInsertBusiness.BulkInsert(codInstcIpc, xmlDadosLista);


                // 8 - Enriquecimento de dados para a tabela final -- Proc no bd
                EscreveLogLocal("(9): " + "Processando os dados.", false);
                processaDadosBusiness.ProcessaExecucoes(codInstcIpc);


                // 9 - Movendo arquivos da processando para a processados
                EscreveLogLocal("(10): " + "Movendo arquivos para a pasta de processados.", false);
                MoveArquivos.MoveArquivo(processando, processados);


                // 10 - Marca a interface como executada
                EscreveLogLocal("(11): " + "Marcando interface como executada.", false);
                interfaceBusiness.FinalizaInterface(itfcObj.codInstc, false, "");


                /* ---------------------------------------- Fim dos Passos lógicos ---------------------------------------- */



                // Edita o Data Grid

                tempoProcessamento = DateTime.Now.Subtract(inicioProcessamento);
                qtd_linhas = xmlDadosLista.Count;
                EditaDataGrid(qtd_linhas.ToString(), tempoProcessamento.ToString("ss\\.ff"));
            }
            catch(Exception ex)
            {
                // Escreve o erro no log local
                EscreveLogLocal("Exception: " + ex.Message, false);
                EscreveLogLocal("InnerException: " + ex.InnerException.Message, false);


                // Move arquivos do Processando para o Erros
                MoveArquivos.MoveArquivo(processando, erros);


                // Insere o erro no log
                logErroBusiness.InsereLogErro(ex.Message);

                EscreveLogLocal("-------------------- Finalizado processamento --------------------", false);
            }
            finally
            {
                EscreveLogLocal("-------------------- Finalizado processamento --------------------", false);

                SalvaLimpaMetadados();

                LimpadorLog.LimpaPastaLog(dirLog, diasCorte, DateTime.Now, sufixo);

                timerGatilho.Interval = 1000 * Convert.ToInt32(textTemporizador.Text);              
                timerGatilho.Enabled = true;
                
                horarioValido = ValidaHorario();
                if(horarioValido)
                {
                    labelStatus.Text = "Aguardando";
                    labelStatus.ForeColor = Color.Green;
                    panel1.BackColor = Color.Green;
                }
                else
                {
                    labelStatus.Text = DateTime.Now.ToString("HH:mm") + " - Fora da Janela";
                    labelStatus.ForeColor = Color.Black;
                    panel1.BackColor = Color.Green;
                }
            }
        }

        // Inicia o processamento
        private void buttonIniciar_Click(object sender, EventArgs e)
        {
            if (buttonIniciar.Text == "Iniciar")
            {
                // Habilita temporizador -- Muda as variaveis da interface para "aguardando" -- Desabilita componentes interativos da interface

                timerGatilho.Interval = 1;              // Intervalo de tempo (ms) -- Reduzido para que o timer inicialize no momento do click em "iniciar"
                timerGatilho.Enabled = true;

                labelStatus.Text = "Aguardando";
                labelStatus.ForeColor = Color.Red;
                buttonIniciar.Text = "Parar";

                textTemporizador.Enabled = false;
                textHoraInicio.Enabled = false;
                textHoraFim.Enabled = false;
                dataGrid.Enabled = false;
            }
            else
            {
                // Desabilita temporizador -- Muda as variaveis da interface para "parado" -- Habilita componentes interativos da interface

                timerGatilho.Enabled = false;

                buttonIniciar.Text = "Iniciar";
                labelStatus.Text = "Parado";
                labelStatus.ForeColor = Color.Blue;
                panel1.BackColor = Color.Silver;
                textProxExec.Text = "";

                textTemporizador.Enabled = true;
                textHoraInicio.Enabled = true;
                textHoraFim.Enabled = true;
                dataGrid.Enabled = true;
            }
        }

        // Insere texto no log local
        private void EscreveLogLocal(string texto, bool inicio)
        {
            if (inicio == true)
            {
                textLog.Text = textLog.Text + System.Environment.NewLine + "-----------------------------------------------------------------------" + execucoes + System.Environment.NewLine;
            }
            textLog.Text = textLog.Text + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + " - " + texto + System.Environment.NewLine;
            textLog.SelectionStart = textLog.Text.Length;
            textLog.ScrollToCaret();
        }


        // Verifica se o horário de execução é válido
        private bool ValidaHorario()
        {
            TimeSpan horaAtual = DateTime.Now.TimeOfDay;
            DateTime horaInicio = DateTime.ParseExact(textHoraInicio.Text, "HH:mm", CultureInfo.InvariantCulture);
            DateTime horaFim = DateTime.ParseExact(textHoraFim.Text, "HH:mm", CultureInfo.InvariantCulture);

            int spanInicio = TimeSpan.Compare(horaInicio.TimeOfDay, horaAtual);
            int spanFim = TimeSpan.Compare(horaFim.TimeOfDay, horaAtual);


            // Verifica se o a hora final eh maior que a inicial

            if (TimeSpan.Compare(horaInicio.TimeOfDay, horaFim.TimeOfDay) >= 0) 
                throw new System.Exception("Hora final não pode ser menor que a hora inicial");

            // Se a hora atual for maior que a hora inicio e menor que a hora fim, retorna true

            if (spanInicio <= 0 && spanFim >= 0) 
                return true;
            else 
                return false;
        }


        // Salva os metadados em um log local e limpa a janela
        void SalvaLimpaMetadados()
        {
            TimeSpan span = DateTime.Now.Subtract(ultimaLimpezaMetadados);

            if (span.TotalMinutes > tempoLimpezaMetadados)
            {
                String metadado = "";

                metadado = textLog.Text;

                InsereLogArquivo.InsereLogMetadados(metadado);

                textLog.Text = "";

                ultimaLimpezaMetadados = DateTime.Now;
            }
        }


        // Edita o grid de interfaces, carimbando os dados na interface selecionada
        void EditaDataGrid(String qtdLinhas, String tempo)
        {
            int ind = dataGrid.RowCount;
            int index = 0;
            foreach (DataGridViewRow row in dataGrid.Rows)
            {
                dataGrid.Rows[index].Cells["columnUtilExe"].Value = DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss");
                dataGrid.Rows[index].Cells["Num_lins"].Value = qtdLinhas;
                dataGrid.Rows[index].Cells["columnTempo"].Value = tempo;
                   
                index++;
            }
        }
    }
}