USE [bd_106_bbmfront]
GO
/****** Object:  StoredProcedure [dbo].[UP_Processa_Interface]    Script Date: 24/01/2023 10:19:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




ALTER procedure [dbo].[UP_Processa_Interface]	(
													@cod_instc_itfc		int
													,@cod_instc_ctpt	int = NULL
													,@status			varchar(20)
													,@Resultado			varchar(1000) 	output
												)

as


Set @Resultado = ''

Declare @dat_itfc date
Declare @desc_itfc varchar(100)
Declare @area int
Declare @HorarioAgendamento datetime

Select 
		@desc_itfc	= desc_itfc_0038
		,@dat_itfc	= dat_itfc_0038
		,@area		= cod_Instc_area_0038
From 
		itfc_ctrl_0038 
Where 
		cod_Instc_0038 = @cod_instc_itfc


/**********************************************************************************************
Executando interface de divisão BMF
**********************************************************************************************/
If @desc_itfc = 'Divisao_BMF' and @status = 'LIBERADA'
Begin

	SET @HorarioAgendamento = GETDATE()
	Execute bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'BACKGROUND' , @Tarefa = 'Divisao_BMF' , @Horario = @HorarioAgendamento

End

/**********************************************************************************************
Executando interface de divisão BOV
**********************************************************************************************/
If @desc_itfc IN ('Divisao_BOV', 'Divisao_BOV_Selecao') and @status = 'LIBERADA'
Begin
	SET @HorarioAgendamento = GETDATE()
	Execute bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'BACKGROUND' , @Tarefa = 'Divisao_BOV' , @Horario = @HorarioAgendamento

End


/**********************************************************************************************
Executando interface de divisão OFF
**********************************************************************************************/
If @desc_itfc IN ('Divisao_OFF', 'Divisao_OFF_Selecao') and @status = 'LIBERADA'
Begin
	SET @HorarioAgendamento = GETDATE()
	Execute bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'BACKGROUND' , @Tarefa = 'Divisao_OFF' , @Horario = @HorarioAgendamento

End


/**********************************************************************************************
Executando insercao de Corretoras a serem processadas da na tabela pcst_cor_0091
**********************************************************************************************/
If @desc_itfc = 'Especifica_BOV' and @status = 'LIBERADA'
Begin
	INSERT INTO
			pcst_cor_0091
			(
				cod_instc_cor_0091
				,dat_itfc_0091
				,pcst_0091
				,ind_sit_0091
				,dat_cdm_0091
				,usr_cdm_0091
			)
	SELECT DISTINCT
			Cod_instc_ctpt_0010
			,@dat_itfc
			,0
			,1
			,GETDATE()
			,SUSER_NAME() 
	FROM
			ord_bbm_0010
	WHERE
			grp_mpa_0010 = 'BOV'
			AND dat_trd_0010 = @dat_itfc 
End


/**********************************************************************************************
Executando insercao de Corretoras a serem processadas da na tabela pcst_cor_0091
**********************************************************************************************/
If @desc_itfc = 'FUTUROS_POSICAO' and @status = 'LIBERADA'
Begin
	
				Execute [dbo].[UP_Processa_Posicao_Futuros]
																										  @data                              = @dat_itfc
																										  ,@atualiza                         = 1
																										
							
				-- Marcando a interface como EXECUTADA                                                                                         
				Execute UP_Finaliza_Aprovacao_Interface
														@cod_instc_itfc = @cod_instc_itfc
	
End


If @desc_itfc = 'CALCULO_CORRETAGEM_BOV' and @status = 'LIBERADA'
Begin
	
				Execute [dbo].[UP_Calcula_Corretagem_BOV]
																										  @data                              = @dat_itfc
																										 
																										
							
				-- Marcando a interface como EXECUTADA                                                                                         
				Execute UP_Finaliza_Aprovacao_Interface
														@cod_instc_itfc = @cod_instc_itfc
	
End


If @desc_itfc = 'CALCULO_CORRETAGEM_OFF' and @status = 'LIBERADA'
Begin
	
				Execute [dbo].[UP_Calcula_Corretagem_OFF]
																										  @data                              = @dat_itfc
																										 
																										
							
				-- Marcando a interface como EXECUTADA                                                                                         
				Execute UP_Finaliza_Aprovacao_Interface
														@cod_instc_itfc = @cod_instc_itfc
	
End

/**********************
Importações do robô
**********************/

DECLARE @dataAgendamento DATE
SET @dataAgendamento = DATEADD(DAY, -30 , @dat_itfc) 

If @desc_itfc ='Custos Operacionais - SAG' and @status = 'LIBERADA'
BEGIN 
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo Itau' , @Tarefa = 'capturaCustosOperacionaisBMF' , @Horario = @dataAgendamento
END


If @desc_itfc ='Garantias Depositadas - SAG' and @status = 'LIBERADA'
BEGIN 
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo Itau' , @Tarefa = 'obtemGarantiasDepositadas' , @Horario = @dataAgendamento
END 


If @desc_itfc ='Garantias Depositadas - Bradesco' and @status = 'LIBERADA'
BEGIN 
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo Bradesco' , @Tarefa = 'BRD_obtemGarantiasDepositadas' , @Horario = @dataAgendamento
END 


If @desc_itfc ='Custos Operacionais - Bradesco' and @status = 'LIBERADA'
BEGIN 
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo Bradesco' , @Tarefa = 'BRD_capturaCustosOperacionaisBMF' , @Horario = @dataAgendamento
END


If @desc_itfc ='Margem - Bradesco' and @status = 'LIBERADA'
BEGIN 
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo Bradesco' , @Tarefa = 'BRD_obtemMargem' , @Horario = @dataAgendamento
END

If @desc_itfc ='Posições Aluguel - Bradesco' and @status = 'LIBERADA'
BEGIN 
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo Bradesco' , @Tarefa = 'BRD_obtemAluguelPosicoes' , @Horario = @dataAgendamento
END

/****************
Processar Cotas
*****************/

If @desc_itfc = 'Processar Cotização' and @status = 'LIBERADA'
Begin
	
				Execute [dbo].[UP_Processa_Cotizacao_Ordens]
																 @data = @dat_itfc
																										 
																										
							
				-- Marcando a interface como EXECUTADA                                                                                         
				Execute UP_Finaliza_Aprovacao_Interface
														@cod_instc_itfc = @cod_instc_itfc

	
End

/**********************************************************************************************
Cálculo do Caixa Online
**********************************************************************************************/

If @desc_itfc = 'Calculo_Caixa_Online' and @status = 'LIBERADA'
Begin
	
	SET @HorarioAgendamento = GETDATE()
	Execute bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'BACKGROUND' , @Tarefa = 'Calculo_Caixa_Online' , @Horario = @HorarioAgendamento


End


/**********************************************************************************************
Processamento Execuções Genéricas (Janela)
**********************************************************************************************/

If @desc_itfc = 'Processamento Execuções Genéricas' and @status = 'LIBERADA'
Begin
	
	SET @HorarioAgendamento = GETDATE()
	Execute bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'BACKGROUND' , @Tarefa = 'Processamento Execuções Genéricas' , @Horario = @HorarioAgendamento


End

/**********************************************************************************************
Cálculo da Matriz de Risco
**********************************************************************************************/

If @desc_itfc = 'Ajuste_Matriz_Risco' and @status = 'LIBERADA'
Begin
		
	Execute [bd_108_bbmcorp].[dbo].[UP_Executa_Ajuste_Matriz_Risco]
																@dat = @dat_itfc


	-- Marcando a interface como EXECUTADA
	Execute UP_Finaliza_Aprovacao_Interface
											@cod_instc_itfc = @cod_instc_itfc

End


/**********************************************************************************************
Cálculo do Ajuste BMF
**********************************************************************************************/

If @desc_itfc = 'Calcula_Ajuste_BMF' and @status = 'LIBERADA'
Begin


	Execute [bd_120_bbmback].[dbo].[UP_Calcula_Ajuste_BMF]
																@data = @dat_itfc


	-- Marcando a interface como EXECUTADA
	Execute UP_Finaliza_Aprovacao_Interface
											@cod_instc_itfc = @cod_instc_itfc

END

IF @desc_itfc = 'CALCULO_PERMANENCIA_BMF' AND @status = 'LIBERADA'
BEGIN
	EXECUTE bd_106_bbmfront..UP_Calcula_Permanencia_BMF
															@data = @dat_itfc

	-- Marcando a interface como EXECUTADA
	Execute UP_Finaliza_Aprovacao_Interface
											@cod_instc_itfc = @cod_instc_itfc
END



/************************************************************
	Robô Web Service Itau
************************************************************/
-- Interface de renda variável
If @desc_itfc ='Envia Boleta RV - WS Itau' and @status = 'LIBERADA'
BEGIN 
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo Web Service Itau' , @Tarefa = 'EnvioBoletaRV' , @Horario = @dataAgendamento
END

-- Interface de futuros
If @desc_itfc ='Envia Boleta BMF - WS Itau' and @status = 'LIBERADA'
BEGIN 
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo Web Service Itau' , @Tarefa = 'EnvioBoletaBMF' , @Horario = @dataAgendamento
END

-- Interface de RF compra de Tit Publico
If @desc_itfc ='WS Itau - TPUB Compra' and @status = 'LIBERADA'
BEGIN 
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo Web Service Itau' , @Tarefa = 'EnvioBoletaRfCompraTitPub' , @Horario = @dataAgendamento
END

-- Interface de RF compra de Tit Privado
If @desc_itfc ='Envia Boleta Termo RV - WS Itau' and @status = 'LIBERADA'
BEGIN 
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo Web Service Itau' , @Tarefa = 'EnvioBoletaRfCompraTitPrvd' , @Horario = @dataAgendamento
END


-- Interface de RF venda
If @desc_itfc ='WS Itau - TPUB Venda' and @status = 'LIBERADA'
BEGIN 
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo Web Service Itau' , @Tarefa = 'EnvioBoletaRfVenda' , @Horario = @dataAgendamento
END

-- Interface de Cotas ON
If @desc_itfc ='WS Itau - Envia Boleta COTAS ON' and @status = 'LIBERADA'
BEGIN 
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo Web Service Itau' , @Tarefa = 'EnvioBoletaCotasON' , @Horario = @dataAgendamento
END

-- Interface de Cotas OFF
If @desc_itfc ='WS Itau - Envia Boleta COTAS OFF' and @status = 'LIBERADA'
BEGIN 
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo Web Service Itau' , @Tarefa = 'EnvioBoletaCotasOFF' , @Horario = @dataAgendamento
END


-- Interface de Venda de Termo Sem Estoque
If @desc_itfc ='WS Itau - TPUB Venda Termo Sem Estoque' and @status = 'LIBERADA'
BEGIN 
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo Web Service Itau' , @Tarefa = 'EnvioBoletaRfTermoSemEstoque' , @Horario = @dataAgendamento
END

-- Interface de Compra com Revenda
If @desc_itfc ='WS Itau - CMPS CR' and @status = 'LIBERADA'
BEGIN 
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo Web Service Itau' , @Tarefa = 'EnvioBoletaRfCompraComRevenda' , @Horario = @dataAgendamento
END

-- Interface de Antecipacao Compromissada
If @desc_itfc ='WS Itau - CMPS Antecipacao' and @status = 'LIBERADA'
BEGIN 
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo Web Service Itau' , @Tarefa = 'EnvioBoletaRfAntecipacaoCompromissada' , @Horario = @dataAgendamento
END

-- Interface de Vencimento Compromissada
If @desc_itfc ='WS Itau - CMPS Vencimento' and @status = 'LIBERADA'
BEGIN 
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo Web Service Itau' , @Tarefa = 'EnvioBoletaRfVencimentoCompromissada' , @Horario = @dataAgendamento
END

-- Interface de Cambio FX
If @desc_itfc ='WS Itau - Cambio FX' and @status = 'LIBERADA'
BEGIN 
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo Web Service Itau' , @Tarefa = 'EnvioBoletaCambioFX' , @Horario = @dataAgendamento
END


-- Interface Importacao Saldo Online - WS Itau
If @desc_itfc ='Importacao Saldo Online - WS Itau' and @status = 'LIBERADA'
BEGIN 
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo Web Service Itau' , @Tarefa = 'ImportacaoSaldoOnline' , @Horario = @dataAgendamento
END

-- Interface Importacao Caixa Online - WS Itau
If @desc_itfc ='Importacao Caixa Online - WS Itau' and @status = 'LIBERADA'
BEGIN 
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo Web Service Itau' , @Tarefa = 'ImportacaoCaixaOnline' , @Horario = @dataAgendamento
END

-- Interface Importacao Conta Aplicacao - WS Itau
If @desc_itfc ='Importacao Conta Aplicacao - WS Itau' and @status = 'LIBERADA'
BEGIN 
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo Web Service Itau' , @Tarefa = 'ImportacaoContaAplicacao' , @Horario = @dataAgendamento
END

-- Interface Importacao Movimentos Dia - WS Itau
If @desc_itfc ='Importacao Movimentos Dia - WS Itau' and @status = 'LIBERADA'
BEGIN 
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo Web Service Itau' , @Tarefa = 'ImportacaoMovimentosDia' , @Horario = @dataAgendamento
END

/************************************************************
	Robô API Itau
************************************************************/
-- Interface de Posições Cotistas
If @desc_itfc ='Importacao Posicoes Cotistas - WS Itau' and @status = 'LIBERADA'
BEGIN 
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo Web Service Itau' , @Tarefa = 'ImpotacaoPosicoesCotistas' , @Horario = @dataAgendamento
END


/**********************************************************************************************
Executando interface de Movimento Manual - Passivo
**********************************************************************************************/
IF @desc_itfc = 'Movimento Manual - Passivo' and @status = 'LIBERADA'
BEGIN
	DECLARE @Agendamento DATETIME = GETDATE()
	Execute bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'BACKGROUND' , @Tarefa = 'Executa_Processa_Movimento_Manual_Passivo' , @Horario = @Agendamento
END

/**********************************************************************************************
Executando Interface Importação Carteira MUFG
**********************************************************************************************/
IF @desc_itfc = 'MUFG_Carteira' and @status = 'LIBERADA'
BEGIN
	DECLARE @data_carteira DATETIME = GETDATE()
	Execute bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo Interfaces Externas' , @Tarefa = 'ImportaCarteiraMUFG_Job' , @Horario = @data_carteira
END


/**********************************************************************************************
Executando Interface Importação Preços MUFG
**********************************************************************************************/
IF @desc_itfc = 'MUFG_Precos' and @status = 'LIBERADA'
BEGIN
	DECLARE @data_precos DATETIME = GETDATE()
	Execute bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo Interfaces Externas' , @Tarefa = 'ImportaPrecosMUFG' , @Horario = @data_precos
END


/**********************************************************************************************
Executando Interface Importação Previa Produtos Estruturados
**********************************************************************************************/
IF @desc_itfc = 'Abertura_Produtos_Estruturados' AND @status = 'LIBERADA'
BEGIN

	SET @HorarioAgendamento = GETDATE()
	Execute bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'BACKGROUND' , @Tarefa = 'Abertura_Produtos_Estruturados' , @Horario = @HorarioAgendamento

END

/**********************************************************************************************
Agendamento Backgroud da Interface de posicao Automatica
**********************************************************************************************/
IF @desc_itfc = 'Importacao_Automatica_Posicao' and @status = 'LIBERADA'
BEGIN 
	SET @HorarioAgendamento = GETDATE()
	Execute bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'BACKGROUND' , @Tarefa = 'ImportacaoAutomaticaPosicao' , @Horario = @HorarioAgendamento
END 

/**********************************************************************************************
Cálculo de Taxa Adm
**********************************************************************************************/

If @desc_itfc = 'TaxAdm_CPR_Bahia' and @status = 'LIBERADA'
Begin

	SET @HorarioAgendamento = GETDATE()
	Execute bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'BACKGROUND' , @Tarefa = 'TaxAdm_CPR_Bahia' , @Horario = @HorarioAgendamento


END

/**********************************************************************************************
Cálculo de Taxa de Custódia
**********************************************************************************************/

If @desc_itfc = 'TaxCstd_CPR_Bahia' and @status = 'LIBERADA'
Begin

	SET @HorarioAgendamento = GETDATE()
	Execute bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'BACKGROUND' , @Tarefa = 'TaxCstd_CPR_Bahia' , @Horario = @HorarioAgendamento


END

/**********************************************************************************************
Cálculo de Proventos
**********************************************************************************************/

If @desc_itfc = 'Prov_CPR_Bahia' and @status = 'LIBERADA'
Begin

	SET @HorarioAgendamento = GETDATE()
	Execute bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'BACKGROUND' , @Tarefa = 'Prov_CPR_Bahia' , @Horario = @HorarioAgendamento


End


/**********************************************************************************************
NAV Bahia
**********************************************************************************************/

If @desc_itfc = 'Calculo_NAV_Bahia' and @status = 'LIBERADA'
Begin

	SET @HorarioAgendamento = GETDATE()
	Execute bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'BACKGROUND' , @Tarefa = 'Calculo_NAV_Bahia' , @Horario = @HorarioAgendamento


END

/************************************************************
	ETL IMBARQxxx
************************************************************/
-- Interface de Importacao_IMBARQ
If @desc_itfc ='Importacao_IMBARQ001' and @status = 'LIBERADA'
BEGIN 
	SET @HorarioAgendamento = GETDATE()
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'ETL' , @Tarefa = 'Importacao_IMBARQ001' , @Horario = @HorarioAgendamento
END

If @desc_itfc ='Importacao_IMBARQ002' and @status = 'LIBERADA'
BEGIN 
	SET @HorarioAgendamento = GETDATE()
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'ETL' , @Tarefa = 'Importacao_IMBARQ002' , @Horario = @HorarioAgendamento
END

If @desc_itfc ='Importacao_IMBARQ004' and @status = 'LIBERADA'
BEGIN 
	SET @HorarioAgendamento = GETDATE()
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'ETL' , @Tarefa = 'Importacao_IMBARQ004' , @Horario = @HorarioAgendamento
END

If @desc_itfc ='Importacao_IMBARQ005' and @status = 'LIBERADA'
BEGIN 
	SET @HorarioAgendamento = GETDATE()
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'ETL' , @Tarefa = 'Importacao_IMBARQ005' , @Horario = @HorarioAgendamento
END

If @desc_itfc ='Importacao_IMBARQ008' and @status = 'LIBERADA'
BEGIN 
	SET @HorarioAgendamento = GETDATE()
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'ETL' , @Tarefa = 'Importacao_IMBARQ008' , @Horario = @HorarioAgendamento
END

If @desc_itfc ='Importacao_IMBARQ009' and @status = 'LIBERADA'
BEGIN 
	SET @HorarioAgendamento = GETDATE()
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'ETL' , @Tarefa = 'Importacao_IMBARQ009' , @Horario = @HorarioAgendamento
END

If @desc_itfc ='Bradesco_Evol_Cotas' and @status = 'LIBERADA'
BEGIN 
	SET @HorarioAgendamento = GETDATE()
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'ETL' , @Tarefa = 'Importacao_Evolucao_Cotas_BRD' , @Horario = @HorarioAgendamento
END

If @desc_itfc ='Performance_CPR_Bahia' and @status = 'LIBERADA'
BEGIN 
	SET @HorarioAgendamento = GETDATE()
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'BACKGROUND' , @Tarefa = 'Performance_CPR_Bahia' , @Horario = @HorarioAgendamento
END

If @desc_itfc ='TaxAluguel_CPR_Bahia' and @status = 'LIBERADA'
BEGIN 
	SET @HorarioAgendamento = GETDATE()
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'BACKGROUND' , @Tarefa = 'TaxAluguel_CPR_Bahia' , @Horario = @HorarioAgendamento
END


-- A condição de SUSER_NAME ficará aqui enquanto houver possibilidade de haver paralelismo entre o PWC e o Bahia ETL. Quando o padrão migrar 100% para o ETL, esta condição pode ser removida
If @desc_itfc ='Bradesco_Estoque' and @status = 'LIBERADA' AND SUSER_NAME() = 'bbmi\adminsql' 
BEGIN 
	SET @HorarioAgendamento = GETDATE()
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'ETL' , @Tarefa = 'Importacao_Carteira_BRD' , @Horario = @HorarioAgendamento
END


IF @desc_itfc = 'Bradesco_Estoque_Automatico' and @status = 'LIBERADA'
BEGIN
	SET @HorarioAgendamento = GETDATE()
	Execute bd_108_bbmcorp..UP_Insere_Solicitacao_Libera_Interface_Rotina_Agendada @desc_itfc = 'Bradesco_Estoque', @data = @dat_itfc
	Execute bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo Interfaces Externas' , @Tarefa = 'ImportaBradescoEstoque_Job' , @Horario = @HorarioAgendamento
END


IF @desc_itfc = 'Bradesco_Evol_Cotas_Automatico' and @status = 'LIBERADA'
BEGIN
	SET @HorarioAgendamento = GETDATE()
	Execute bd_108_bbmcorp..UP_Insere_Solicitacao_Libera_Interface_Rotina_Agendada @desc_itfc = 'Bradesco_Evol_Cotas', @data = @dat_itfc
	Execute bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo Interfaces Externas' , @Tarefa = 'ImportaBradescoEvolCotas_Job' , @Horario = @HorarioAgendamento
END


/************************************************************
	Robô IMBARQxxx Azure
************************************************************/
-- Interface IMBARQ001 RV
If @desc_itfc ='IMBARQ001_RV_Automatico' and @status = 'LIBERADA'
BEGIN 
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo IMERCADO B3' , @Tarefa = 'IMBARQ001_RV' , @Horario = @dataAgendamento
END

-- Interface IMBARQ001 RF
If @desc_itfc ='IMBARQ001_RF_Automatico' and @status = 'LIBERADA'
BEGIN 
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo IMERCADO B3' , @Tarefa = 'IMBARQ001_RF' , @Horario = @dataAgendamento
END

/************************************************************
	Processamento de Posição de Aluguel
************************************************************/

IF @desc_itfc = 'Posicao_Aluguel_Abertura_Fechamento' and @status = 'LIBERADA'
BEGIN
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'BACKGROUND' , @Tarefa = 'Insere_Posicao_Abertura_Fechamento_Aluguel' , @Horario = @dataAgendamento
END

IF @desc_itfc = 'Posicao_Aluguel_Abertura_Fechamento_IMBARQ' and @status = 'LIBERADA'
BEGIN
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'BACKGROUND' , @Tarefa = 'Insere_Posicao_Abertura_Fechamento_Aluguel_IMBARQ' , @Horario = @dataAgendamento
END

/************************************************************
	Importação Arquivos SELIC
************************************************************/

If @desc_itfc ='Posicao_Selic_Itau' and @status = 'LIBERADA'
BEGIN 
	SET @HorarioAgendamento = GETDATE()
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'ETL' , @Tarefa = 'Importacao_Posicao_Selic_ITAU' , @Horario = @HorarioAgendamento
END

If @desc_itfc ='Movimentos_Selic_Itau' and @status = 'LIBERADA'
BEGIN 
	SET @HorarioAgendamento = GETDATE()
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'ETL' , @Tarefa = 'Importacao_Movimentos_Selic_ITAU' , @Horario = @HorarioAgendamento
END

If @desc_itfc ='Posicao_Selic_Bradesco' and @status = 'LIBERADA'
BEGIN 
	SET @HorarioAgendamento = GETDATE()
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'ETL' , @Tarefa = 'Importacao_Posicao_Selic_BRD' , @Horario = @HorarioAgendamento
END

If @desc_itfc ='Termo_Selic_Bradesco' and @status = 'LIBERADA'
BEGIN 
	SET @HorarioAgendamento = GETDATE()
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'ETL' , @Tarefa = 'Importacao_Termo_Selic_BRD' , @Horario = @HorarioAgendamento
END

If @desc_itfc ='Recompra_Selic_Bradesco' and @status = 'LIBERADA'
BEGIN 
	SET @HorarioAgendamento = GETDATE()
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'ETL' , @Tarefa = 'Importacao_Recompra_Selic_BRD' , @Horario = @HorarioAgendamento
END

If @desc_itfc ='Over_Selic_Itau' and @status = 'LIBERADA'
BEGIN 
	SET @HorarioAgendamento = GETDATE()
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'ETL' , @Tarefa = 'Importacao_Over_Selic_ITAU' , @Horario = @HorarioAgendamento
END

/************************************************************
	Importação Arquivo Demonstrativo SBLF
************************************************************/

If @desc_itfc ='Demonstrativo_SBLF_Bradesco' and @status = 'LIBERADA'
BEGIN 
	SET @HorarioAgendamento = GETDATE()
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'ETL' , @Tarefa = 'Importacao_Demonstrativo_SBLF_BRD' , @Horario = @HorarioAgendamento
END

/************************************************************
	Relatorio Performance
************************************************************/

IF @desc_itfc = 'Relatorio_Performance' and @status = 'LIBERADA'
BEGIN
	SET @HorarioAgendamento = GETDATE()
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'ETL' , @Tarefa = 'Exportacao_Relatorio_Performance' , @Horario = @HorarioAgendamento
END


/************************************************************
	Boletador Aluguel
************************************************************/

IF @desc_itfc = 'Divisao_Aluguel' and @status = 'LIBERADA'
BEGIN
	SET @HorarioAgendamento = GETDATE()
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Background', @Tarefa = 'Divisao_Aluguel', @Horario = @HorarioAgendamento
END

IF @desc_itfc = 'Quebra_Ordens_Aluguel' and @status = 'LIBERADA'
BEGIN
	SET @HorarioAgendamento = GETDATE()
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Background', @Tarefa = 'Quebra_Ordens_Aluguel', @Horario = @HorarioAgendamento
END

IF @desc_itfc = 'TradeFiles_Aluguel_Corretoras' and @status = 'LIBERADA'
BEGIN
	SET @HorarioAgendamento = GETDATE()
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'ETL', @Tarefa = 'Exportacao_TradeFiles_Aluguel_Corretoras', @Horario = @HorarioAgendamento
END

IF @desc_itfc = 'TradeFiles_Aluguel_Itau' and @status = 'LIBERADA'
BEGIN
	SET @HorarioAgendamento = GETDATE()
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'ETL', @Tarefa = 'Exportacao_TradeFiles_Aluguel_Itau_Administrador', @Horario = @HorarioAgendamento
END

IF @desc_itfc = 'TradeFiles_Aluguel_Bradesco' and @status = 'LIBERADA'
BEGIN
	SET @HorarioAgendamento = GETDATE()
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'ETL', @Tarefa = 'Exportacao_TradeFiles_Aluguel_Bradesco_Adm', @Horario = @HorarioAgendamento
END


/************************************************************
	Dados Markit
************************************************************/
IF @desc_itfc = 'Importacao_Markit' and @status = 'LIBERADA'			
BEGIN
	SET @HorarioAgendamento = GETDATE()
	EXECUTE bd_108_bbmcorp..UP_Insere_Agendamento_Tarefa @Tipo = 'Robo_Markit', @Tarefa = 'Importacao_Dados_Markit', @Horario = @HorarioAgendamento
END