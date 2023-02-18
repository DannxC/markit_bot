USE bd_106_bbmfront
GO


/****** Object:  StoredProcedure [dbo].[UP_Processa_Dados_Markit]    Script Date: 19/01/2023 13:24:00 ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- obs: caso queira alterar a proc, basta trocar CREATE por ALTER

alter PROCEDURE [dbo].[UP_Processa_Execucoes_Markit_IRS] (

	@cod_instc_ipc		int		-- parâmetro de input da proc

)

AS

SET NOCOUNT ON



/************************************************************
       Verificando aprovação da interface
************************************************************/
Declare @tipo varchar(50)		= 'Importacao_Markit'
Declare @mercado varchar(10)	= 'OFF'
Declare @cod_instc_itfc int
Declare @dd_adc varchar(100)
Declare @data date

Execute bd_106_bbmfront..UP_Verifica_Aprovacao_Interface
                                                                   @mercado                 = @mercado
                                                                   ,@desc_itfc              = @tipo
                                                                   ,@cod_instc_itfc			= @cod_instc_itfc		output
                                                                   ,@dd_adc                 = @dd_adc               output
                                                                   ,@data                   = @data                 output
                                                      

-- Se algum campo for nulo, termina
If (@data is null) or (@cod_instc_itfc is null)
BEGIN
       return
END


/************************************************************
	Capturando a data da importação
************************************************************/
update
	dbo.ctrl_ipc_mrkit_0962
SET
	dat_ipc_0962 = @data
WHERE 
	cod_instc_0962 = @cod_instc_ipc



/************************************************************
	Cria tabelas de problemas dos dados Markit
************************************************************/
Create Table #Problemas_Validacao_Markit (descErro varchar(8000))
Create Table #Importações_Com_Problemas_Markit (ID_Com_Problema int)


/************************************************************
	Validando se há datas apenas iguais às da interface
************************************************************/
DECLARE @data_markit date
SELECT distinct
	@data_markit = mrkit_header_Trade_Date_0963 
FROM
	dbo.dd_mrkit_irs_temp_0963 AS temp
WHERE
		temp.ind_sit_0963			= 1
	AND temp.cod_instc_ipc_0963		= @cod_instc_ipc


IF(DATEDIFF(DAY, @data_markit, @data) <> 0)
BEGIN
	INSERT INTO #Problemas_Validacao_Markit
	SELECT DISTINCT 
		  'Trade ID: '
		+ ISNULL(CAST(mrkit_header_Trade_ID_0963 AS VARCHAR(20)), '')
		+ '    -    Data do arquivo "' + ISNULL(CONVERT(varchar(10), @data_markit, 103), '(nula)') + '" diferente da data da interface "' + ISNULL(CONVERT(varchar(10), @data, 103), '(nula)')  + '"'
	FROM 
		dd_mrkit_irs_temp_0963
	WHERE 
		cod_instc_ipc_0963 = @cod_instc_ipc
	
	
	INSERT INTO #Importações_Com_Problemas_Markit
	SELECT 
		cod_instc_0963
	FROM 
		dd_mrkit_irs_temp_0963
	WHERE 
		cod_instc_ipc_0963 = @cod_instc_ipc 
END


/************************************************************
	Validando a unicidade das datas
************************************************************/
DECLARE @QtdDiferentesDatas INT
SELECT 
	@QtdDiferentesDatas = COUNT(distinct mrkit_header_Trade_Date_0963) 
FROM
	dbo.dd_mrkit_irs_temp_0963 AS temp
WHERE
		temp.ind_sit_0963			= 1
	AND temp.cod_instc_ipc_0963		= @cod_instc_ipc


IF(ISNULL(@QtdDiferentesDatas, 0) <> 1)
BEGIN
	INSERT INTO #Problemas_Validacao_Markit
	SELECT DISTINCT 
		  'Trade ID: '
		+ ISNULL(CAST(mrkit_header_Trade_ID_0963 AS VARCHAR(20)), '')
		+ '    -    Múltiplas datas na importação: ' + ISNULL(CONVERT(varchar(10), mrkit_header_Trade_Date_0963, 103), '(nula)') 
	FROM 
		dd_mrkit_irs_temp_0963
	WHERE 
		cod_instc_ipc_0963 = @cod_instc_ipc
	
	
	INSERT INTO #Importações_Com_Problemas_Markit
	SELECT 
		cod_instc_0963
	FROM 
		dd_mrkit_irs_temp_0963
	WHERE 
		cod_instc_ipc_0963 = @cod_instc_ipc 
END



/************************************************************
	Valindando duplicidade das linhas
************************************************************/
SELECT
	 mrkit_header_Trade_ID_0963		AS trade_id
	,COUNT(*)					AS qtd
INTO
	#Chaves_Duplicadas
FROM	
	dbo.dd_mrkit_irs_temp_0963
WHERE
        ind_sit_0963 = 1
    AND cod_instc_ipc_0963 = @cod_instc_ipc
GROUP BY
	mrkit_header_Trade_ID_0963
HAVING
	COUNT(*) > 1


INSERT INTO
    #Problemas_Validacao_Markit
SELECT DISTINCT
	'Linha duplicada: Trade_ID - ' 
	+ CAST(mrkit_header_Trade_ID_0963 AS VARCHAR(100)) + '. Trade Version - ' 
	+ CAST(mrkit_header_Trade_Version_0963 AS VARCHAR(100))
FROM	
	dbo.dd_mrkit_irs_temp_0963
	INNER JOIN
	#Chaves_Duplicadas ON mrkit_header_Trade_ID_0963  = trade_id
WHERE
        ind_sit_0963 = 1
    AND cod_instc_ipc_0963 = @cod_instc_ipc


INSERT INTO
    #Importações_Com_Problemas_Markit
SELECT DISTINCT
    cod_instc_0963
FROM	
	dbo.dd_mrkit_irs_temp_0963
	INNER JOIN
	#Chaves_Duplicadas ON mrkit_header_Trade_ID_0963  = trade_id
WHERE
        ind_sit_0963 = 1
    AND cod_instc_ipc_0963 = @cod_instc_ipc



/************************************************************
	Enrriquece Código de Instância da Contraparte
************************************************************/
UPDATE
	dbo.dd_mrkit_irs_temp_0963
SET
	cod_instc_ctpt_0963 = cod_instc_0030
FROM
	dbo.dd_mrkit_irs_temp_0963
	INNER JOIN
	bd_108_bbmcorp.dbo.cod_ext_0443 ON (cod_ext_0443 = mrkit_header_Party_A_0963 OR cod_ext_0443 = mrkit_header_Party_B_0963)	-- Um será o Bahia, logo n terá código da contraparte...
	INNER JOIN
	bd_108_bbmcorp.dbo.itmd_0030 ON cod_instc_0030 = cod_instc_int_0443
WHERE
        ind_sit_0963 = 1
    AND ind_sit_0030 = 1
    AND ind_sit_0443 = 1
    AND tip_0443 = 'Executing Broker'
    AND fte_0443 = 'Markit'
    AND cod_instc_ipc_0963 = @cod_instc_ipc


INSERT INTO
    #Problemas_Validacao_Markit
SELECT DISTINCT
	  'Trade ID: '
	+ ISNULL(CAST(mrkit_header_Trade_ID_0963 AS VARCHAR(20)), '')
	+ '    -    Contraparte inválida: ' 
	+ 'Party A: ' + ISNULL(CAST(mrkit_header_Party_A_0963 AS VARCHAR(20)), '')
	+ ' - Party B: ' + ISNULL(CAST(mrkit_header_Party_B_0963 AS VARCHAR(20)), '')
FROM
    dbo.dd_mrkit_irs_temp_0963
WHERE
		ind_sit_0963 = 1
    AND cod_instc_ctpt_0963 IS NULL
    AND cod_instc_ipc_0963 = @cod_instc_ipc


INSERT INTO
    #Importações_Com_Problemas_Markit
SELECT
    cod_instc_0963
FROM
    dbo.dd_mrkit_irs_temp_0963
WHERE
		ind_sit_0963 = 1
    AND cod_instc_ctpt_0963 IS NULL
    AND cod_instc_ipc_0963 = @cod_instc_ipc



/************************************************************
	Enrriquece Código de Instância da Moeda (Fixed Leg)
************************************************************/
UPDATE
	dbo.dd_mrkit_irs_temp_0963
SET
	cod_instc_moe_pta_fix_0963 = cod_instc_0042
FROM
	dbo.dd_mrkit_irs_temp_0963
	INNER JOIN
	bd_108_bbmcorp.dbo.v_moe_0042 ON cod_bbm_0042 = mrkit_fixedLeg_Notional_Amount_Currency_0963
WHERE
		ind_sit_0963 = 1
    AND cod_instc_moe_pta_fix_0963 IS NULL
    AND cod_instc_ipc_0963 = @cod_instc_ipc


INSERT INTO
	#Problemas_Validacao_Markit
SELECT DISTINCT
	  'Trade ID: '
	+ ISNULL(CAST(mrkit_header_Trade_ID_0963 AS VARCHAR(20)), '')
	+ '    -    Moeda da ponta fixa inválida: ' 
	+ ISNULL(CAST(mrkit_fixedLeg_Notional_Amount_Currency_0963 AS VARCHAR(20)), '')
FROM
	dbo.dd_mrkit_irs_temp_0963
WHERE
		ind_sit_0963 = 1
    AND cod_instc_moe_pta_fix_0963 IS NULL
    AND cod_instc_ipc_0963 = @cod_instc_ipc


INSERT INTO
	#Importações_Com_Problemas_Markit
SELECT
	cod_instc_0963
FROM
	dbo.dd_mrkit_irs_temp_0963
WHERE
		ind_sit_0963 = 1
    AND cod_instc_moe_pta_fix_0963 IS NULL
    AND cod_instc_ipc_0963 = @cod_instc_ipc



/*************************************************************
	Enrriquece Código de Instância da Moeda (Floating Leg)
*************************************************************/
UPDATE
	dbo.dd_mrkit_irs_temp_0963
SET
	cod_instc_moe_pta_flu_0963 = cod_instc_0042
FROM
	dbo.dd_mrkit_irs_temp_0963
	INNER JOIN
	bd_108_bbmcorp.dbo.v_moe_0042 ON cod_bbm_0042 = mrkit_floatingLeg_Notional_Amount_Currency_0963
WHERE
		ind_sit_0963 = 1
    AND cod_instc_moe_pta_flu_0963 IS NULL
    AND cod_instc_ipc_0963 = @cod_instc_ipc


INSERT INTO
	#Problemas_Validacao_Markit
SELECT DISTINCT
	  'Trade ID: '
	+ ISNULL(CAST(mrkit_header_Trade_ID_0963 AS VARCHAR(20)), '')
	+ '    -    Moeda da ponta flutuante inválida: ' 
	+ ISNULL(CAST(mrkit_floatingLeg_Notional_Amount_Currency_0963 AS VARCHAR(20)), '')
FROM
	dbo.dd_mrkit_irs_temp_0963
WHERE
		ind_sit_0963 = 1
    AND cod_instc_moe_pta_flu_0963 IS NULL
    AND cod_instc_ipc_0963 = @cod_instc_ipc


INSERT INTO
	#Importações_Com_Problemas_Markit
SELECT
	cod_instc_0963
FROM
	dbo.dd_mrkit_irs_temp_0963
WHERE
		ind_sit_0963 = 1
    AND cod_instc_moe_pta_flu_0963 IS NULL
    AND cod_instc_ipc_0963 = @cod_instc_ipc



/**************************************************************
	Enrriquece Código de Instância do Índice (Floating Leg)
**************************************************************/
UPDATE
	dbo.dd_mrkit_irs_temp_0963
SET
	cod_instc_indx_0963 = cod_instc_0174
FROM
	dbo.dd_mrkit_irs_temp_0963
	INNER JOIN
	bd_108_bbmcorp.dbo.cod_ext_0443 ON (
							cod_ext_0443 =	(
												ISNULL(mrkit_floatingLeg_floatingRateCalculation_Index_0963, '') 
												+ ISNULL(CAST(mrkit_floatingLeg_floatingRateCalculation_Index_Frequency_Multiplier_0963 as varchar(100)), '') 
												+ ISNULL(mrkit_floatingLeg_floatingRateCalculation_Index_Frequency_Period_0963, '')
											)
							OR
							cod_ext_0443 =	(
												ISNULL(mrkit_floatingLeg_inflationRateCalculation_Index_0963, '') 
												+ ISNULL(CAST(mrkit_floatingLeg_inflationRateCalculation_Index_Frequency_Multiplier_0963 as varchar(100)), '') 
												+ ISNULL(mrkit_floatingLeg_inflationRateCalculation_Index_Frequency_Period_0963, '')
											)
						)
	INNER JOIN
	bd_108_bbmcorp.dbo.indx_0174 ON cod_instc_0174 = cod_instc_int_0443
WHERE
        ind_sit_0963 = 1
    AND ind_sit_0443 = 1
    AND ind_sit_0174 = 1
    AND tip_0443 = 'Indexador'
    AND fte_0443 = 'Markit'
    AND cod_instc_ipc_0963 = @cod_instc_ipc
	

INSERT INTO
	#Problemas_Validacao_Markit
SELECT DISTINCT
	  'Trade ID: '
	+ ISNULL(CAST(mrkit_header_Trade_ID_0963 AS VARCHAR(20)), '')
	+ '    -    Índice da ponta ativa inválido: ' 
	-- Se a primeira tentativa não for nula, a segunda será.
	+ ISNULL(mrkit_floatingLeg_floatingRateCalculation_Index_0963, '') 
	+ ISNULL(CAST(mrkit_floatingLeg_floatingRateCalculation_Index_Frequency_Multiplier_0963 as varchar(100)), '') 
	+ ISNULL(mrkit_floatingLeg_floatingRateCalculation_Index_Frequency_Period_0963, '')
	-- Se a primeira tentativa for nula, a segunda não será.
	+ ISNULL(mrkit_floatingLeg_inflationRateCalculation_Index_0963, '') 
	+ ISNULL(CAST(mrkit_floatingLeg_inflationRateCalculation_Index_Frequency_Multiplier_0963 as varchar(100)), '') 
	+ ISNULL(mrkit_floatingLeg_inflationRateCalculation_Index_Frequency_Period_0963, '')
FROM
	dbo.dd_mrkit_irs_temp_0963
WHERE
		ind_sit_0963 = 1
    AND cod_instc_indx_0963 IS NULL
    AND cod_instc_ipc_0963 = @cod_instc_ipc


INSERT INTO
	#Importações_Com_Problemas_Markit
SELECT
	cod_instc_0963
FROM
	dbo.dd_mrkit_irs_temp_0963
WHERE
		ind_sit_0963 = 1
    AND cod_instc_indx_0963 IS NULL
    AND cod_instc_ipc_0963 = @cod_instc_ipc



/*****************************************************************
	Enrriquece Código de Instância da Moeda Upfront (Payment)										
*****************************************************************/
UPDATE
	dbo.dd_mrkit_irs_temp_0963
SET
	cod_instc_moe_upfront_0963 = cod_instc_0042
FROM
	dbo.dd_mrkit_irs_temp_0963
	INNER JOIN
	bd_108_bbmcorp.dbo.v_moe_0042 ON cod_bbm_0042 = mrkit_payment_Payment_Currency_0963
WHERE
		ind_sit_0963 = 1
    AND cod_instc_moe_upfront_0963 IS NULL
    AND cod_instc_ipc_0963 = @cod_instc_ipc



/***********************************************************************************************************
	Invalidando as linhas com problema                                      
***********************************************************************************************************/
UPDATE
	dd_mrkit_irs_temp_0963
SET
	ind_sit_0963 = 3
	,dat_sit_0963 = GETDATE()
	,usr_sit_0963 = SUSER_NAME()
FROM
	dd_mrkit_irs_temp_0963
	INNER JOIN
	#Importações_Com_Problemas_Markit ON ID_Com_Problema = cod_instc_0963
WHERE
		cod_instc_ipc_0963 = @cod_instc_ipc
	AND ind_sit_0963 = 1

/************************************************************
	 Capturando última importação vigente para comparar com a importação atual
************************************************************/
DECLARE @cod_instc_ipc_vigente int
SELECT	
	@cod_instc_ipc_vigente = cod_instc_0962
FROM	
	ctrl_ipc_mrkit_0962
WHERE	
		dat_ipc_0962 = @data
	and ind_sit_0962 = 1

/***********************************************************************************************************
	Atualizando linhas dos dados na tabela final do Markit
***********************************************************************************************************/
UPDATE
	dbo.dd_mrkit_irs_0964
SET
	-- Header
	 mrkit_header_Trade_ID_0964 = mrkit_header_Trade_ID_0963
	,mrkit_header_Trade_Version_0964 = mrkit_header_Trade_Version_0963
	,mrkit_header_Trade_Version_Timestamp_0964 = mrkit_header_Trade_Version_Timestamp_0963
	,mrkit_header_Trade_Date_0964 = mrkit_header_Trade_Date_0963
	,mrkit_header_Trade_Status_0964 = mrkit_header_Trade_Status_0963
	,mrkit_header_Master_Agreement_Type_0964 = mrkit_header_Master_Agreement_Type_0963
	,mrkit_header_Contractual_Definitions_0964 = mrkit_header_Contractual_Definitions_0963
	,mrkit_header_Party_A_0964 = mrkit_header_Party_A_0963
	,mrkit_header_Party_B_0964 = mrkit_header_Party_B_0963
	,mrkit_header_Product_Type_0964 = mrkit_header_Product_Type_0963
	,mrkit_header_Template_Name_0964 = mrkit_header_Template_Name_0963

	-- Fixed Leg
	,mrkit_fixedLeg_Payer_0964 = mrkit_fixedLeg_Payer_0963
	,mrkit_fixedLeg_Receiver_0964 = mrkit_fixedLeg_Receiver_0963
	,mrkit_fixedLeg_Effective_Date_0964 = mrkit_fixedLeg_Effective_Date_0963
	,mrkit_fixedLeg_Effective_Date_Adjustments_0964 = mrkit_fixedLeg_Effective_Date_Adjustments_0963
	,mrkit_fixedLeg_Termination_Date_0964 = mrkit_fixedLeg_Termination_Date_0963
	,mrkit_fixedLeg_Termination_Date_Adjustments_0964 = mrkit_fixedLeg_Termination_Date_Adjustments_0963
	,mrkit_fixedLeg_Calculation_Period_Dates_Adjustments_0964 = mrkit_fixedLeg_Calculation_Period_Dates_Adjustments_0963
	,mrkit_fixedLeg_Calculation_Period_Frequency_Multiplier_0964 = mrkit_fixedLeg_Calculation_Period_Frequency_Multiplier_0963
	,mrkit_fixedLeg_Calculation_Period_Frequency_0964 = mrkit_fixedLeg_Calculation_Period_Frequency_0963
	,mrkit_fixedLeg_Calculation_Period_Frequency_Roll_Convention_0964 = mrkit_fixedLeg_Calculation_Period_Frequency_Roll_Convention_0963
	,mrkit_fixedLeg_Payment_Frequency_Period_Multiplier_0964 = mrkit_fixedLeg_Payment_Frequency_Period_Multiplier_0963
	,mrkit_fixedLeg_Payment_Frequency_Period_0964 = mrkit_fixedLeg_Payment_Frequency_Period_0963
	,mrkit_fixedLeg_Payment_Dates_PayRelativeTo_0964 = mrkit_fixedLeg_Payment_Dates_PayRelativeTo_0963
	,mrkit_fixedLeg_Payment_Dates_Business_Convention_0964 = mrkit_fixedLeg_Payment_Dates_Business_Convention_0963
	,mrkit_fixedLeg_Payment_Dates_Business_Convention_Business_Centers_0964 = mrkit_fixedLeg_Payment_Dates_Business_Convention_Business_Centers_0963
	,mrkit_fixedLeg_Payments_Day_Offset_Multiplier_0964 = mrkit_fixedLeg_Payments_Day_Offset_Multiplier_0963
	,mrkit_fixedLeg_Payments_Day_Offset_Period_0964 = mrkit_fixedLeg_Payments_Day_Offset_Period_0963
	,mrkit_fixedLeg_Payments_Day_Offset_Day_Type_0964 = mrkit_fixedLeg_Payments_Day_Offset_Day_Type_0963
	,mrkit_fixedLeg_Notional_Amount_0964 = mrkit_fixedLeg_Notional_Amount_0963
	,mrkit_fixedLeg_Notional_Amount_Currency_0964 = mrkit_fixedLeg_Notional_Amount_Currency_0963
	,mrkit_fixedLeg_Fixed_Rate_0964 = mrkit_fixedLeg_Fixed_Rate_0963
	,mrkit_fixedLeg_Fixed_Rate_Day_Count_Fraction_0964 = mrkit_fixedLeg_Fixed_Rate_Day_Count_Fraction_0963
	,mrkit_fixedLeg_CashFlows_Match_Parameters_0964 = mrkit_fixedLeg_CashFlows_Match_Parameters_0963
	,mrkit_fixedLeg_CashFlows_Payment_Unadjusted_Payment_Date_0964 = mrkit_fixedLeg_CashFlows_Payment_Unadjusted_Payment_Date_0963
	,mrkit_fixedLeg_CashFlows_Payment_Fixed_Payment_Amount_0964 = mrkit_fixedLeg_CashFlows_Payment_Fixed_Payment_Amount_0963

	-- Floating Leg
	,mrkit_floatingLeg_Payer_0964 = mrkit_floatingLeg_Payer_0963
	,mrkit_floatingLeg_Receiver_0964 = mrkit_floatingLeg_Receiver_0963
	,mrkit_floatingLeg_Effective_Date_0964 = mrkit_floatingLeg_Effective_Date_0963
	,mrkit_floatingLeg_Effective_Date_Adjustments_0964 = mrkit_floatingLeg_Effective_Date_Adjustments_0963
	,mrkit_floatingLeg_Termination_Date_0964 = mrkit_floatingLeg_Termination_Date_0963
	,mrkit_floatingLeg_Termination_Date_Adjustments_0964 = mrkit_floatingLeg_Termination_Date_Adjustments_0963
	,mrkit_floatingLeg_Calculation_Period_Dates_Adjustments_0964 = mrkit_floatingLeg_Calculation_Period_Dates_Adjustments_0963
	,mrkit_floatingLeg_Calculation_Period_Frequency_Multiplier_0964 = mrkit_floatingLeg_Calculation_Period_Frequency_Multiplier_0963
	,mrkit_floatingLeg_Calculation_Period_Frequency_0964 = mrkit_floatingLeg_Calculation_Period_Frequency_0963
	,mrkit_floatingLeg_Calculation_Period_Frequency_Roll_Convention_0964 = mrkit_floatingLeg_Calculation_Period_Frequency_Roll_Convention_0963
	,mrkit_floatingLeg_Payment_Frequency_Period_Multiplier_0964 = mrkit_floatingLeg_Payment_Frequency_Period_Multiplier_0963
	,mrkit_floatingLeg_Payment_Frequency_Period_0964 = mrkit_floatingLeg_Payment_Frequency_Period_0963
	,mrkit_floatingLeg_Payment_Dates_PayRelativeTo_0964 = mrkit_floatingLeg_Payment_Dates_PayRelativeTo_0963
	,mrkit_floatingLeg_Payment_Dates_Business_Convention_0964	= mrkit_floatingLeg_Payment_Dates_Business_Convention_0963										
	,mrkit_floatingLeg_Payment_Dates_Business_Convention_Business_Centers_0964 = mrkit_floatingLeg_Payment_Dates_Business_Convention_Business_Centers_0963
	,mrkit_floatingLeg_Payments_Day_Offset_Multiplier_0964 = mrkit_floatingLeg_Payments_Day_Offset_Multiplier_0963
	,mrkit_floatingLeg_Payments_Day_Offset_Period_0964 = mrkit_floatingLeg_Payments_Day_Offset_Period_0963
	,mrkit_floatingLeg_Payments_Day_Offset_Day_Type_0964 = mrkit_floatingLeg_Payments_Day_Offset_Day_Type_0963
	,mrkit_floatingLeg_Fixing_Reset_Related_To_0964 = mrkit_floatingLeg_Fixing_Reset_Related_To_0963
	,mrkit_floatingLeg_Fixing_Dates_Multiplier_0964 = mrkit_floatingLeg_Fixing_Dates_Multiplier_0963
	,mrkit_floatingLeg_Fixing_Dates_Period_0964 = mrkit_floatingLeg_Fixing_Dates_Period_0963
	,mrkit_floatingLeg_Fixing_Day_Convention_0964 = mrkit_floatingLeg_Fixing_Day_Convention_0963
	,mrkit_floatingLeg_Fixing_Day_Business_Center_0964 = mrkit_floatingLeg_Fixing_Day_Business_Center_0963
	,mrkit_floatingLeg_Reset_Frequency_Multiplier_0964 = mrkit_floatingLeg_Reset_Frequency_Multiplier_0963
	,mrkit_floatingLeg_Reset_Frequency_Period_0964 = mrkit_floatingLeg_Reset_Frequency_Period_0963
	,mrkit_floatingLeg_Reset_Date_Adjustment_0964 = mrkit_floatingLeg_Reset_Date_Adjustment_0963
	,mrkit_floatingLeg_Reset_Date_Business_Center_0964 = mrkit_floatingLeg_Reset_Date_Business_Center_0963
	,mrkit_floatingLeg_Notional_Amount_0964 = mrkit_floatingLeg_Notional_Amount_0963
	,mrkit_floatingLeg_Notional_Amount_Currency_0964 = mrkit_floatingLeg_Notional_Amount_Currency_0963

	-- tipo 1 - Produto = "SingleCurrencyInterestRateSwap" ou "OIS"
	,mrkit_floatingLeg_floatingRateCalculation_Index_0964 = mrkit_floatingLeg_floatingRateCalculation_Index_0963
	,mrkit_floatingLeg_floatingRateCalculation_Index_Frequency_Multiplier_0964 = mrkit_floatingLeg_floatingRateCalculation_Index_Frequency_Multiplier_0963
	,mrkit_floatingLeg_floatingRateCalculation_Index_Frequency_Period_0964 = mrkit_floatingLeg_floatingRateCalculation_Index_Frequency_Period_0963
	,mrkit_floatingLeg_floatingRateCalculation_Index_Source_0964 = mrkit_floatingLeg_floatingRateCalculation_Index_Source_0963
	,mrkit_floatingLeg_floatingRateCalculation_Inflation_Rate_Interpolation_Method_0964 = mrkit_floatingLeg_floatingRateCalculation_Inflation_Rate_Interpolation_Method_0963
	,mrkit_floatingLeg_floatingRateCalculation_Inflation_Rate_Level_0964 = mrkit_floatingLeg_floatingRateCalculation_Inflation_Rate_Level_0963
	,mrkit_floatingLeg_floatingRateCalculation_DayCountFraction_0964 = mrkit_floatingLeg_floatingRateCalculation_DayCountFraction_0963
	,mrkit_floatingLeg_floatingRateCalculation_Spread_0964 = mrkit_floatingLeg_floatingRateCalculation_Spread_0963

	-- tipo 2 - Produto = "ZC Inflation"
	,mrkit_floatingLeg_inflationRateCalculation_Index_0964 = mrkit_floatingLeg_inflationRateCalculation_Index_0963
	,mrkit_floatingLeg_inflationRateCalculation_Index_Frequency_Multiplier_0964 = mrkit_floatingLeg_inflationRateCalculation_Index_Frequency_Multiplier_0963
	,mrkit_floatingLeg_inflationRateCalculation_Index_Frequency_Period_0964 = mrkit_floatingLeg_inflationRateCalculation_Index_Frequency_Period_0963
	,mrkit_floatingLeg_inflationRateCalculation_Index_Source_0964 = mrkit_floatingLeg_inflationRateCalculation_Index_Source_0963
	,mrkit_floatingLeg_inflationRateCalculation_Inflation_Rate_Interpolation_Method_0964 = mrkit_floatingLeg_inflationRateCalculation_Inflation_Rate_Interpolation_Method_0963
	,mrkit_floatingLeg_inflationRateCalculation_Inflation_Rate_Level_0964 = mrkit_floatingLeg_inflationRateCalculation_Inflation_Rate_Level_0963
	,mrkit_floatingLeg_inflationRateCalculation_DayCountFraction_0964 = mrkit_floatingLeg_inflationRateCalculation_DayCountFraction_0963
	,mrkit_floatingLeg_inflationRateCalculation_Spread_0964 = mrkit_floatingLeg_inflationRateCalculation_Spread_0963

	-- Payment
	,mrkit_payment_Payer_0964 = mrkit_payment_Payer_0963
	,mrkit_payment_Receiver_0964 = mrkit_payment_Receiver_0963
	,mrkit_payment_Payment_Amount_0964 = mrkit_payment_Payment_Amount_0963
	,mrkit_payment_Payment_Currency_0964 = mrkit_payment_Payment_Currency_0963
	,mrkit_payment_Payment_Date_0964 = mrkit_payment_Payment_Date_0963
	,mrkit_payment_Payment_Day_Business_Day_Convention_0964 = mrkit_payment_Payment_Day_Business_Day_Convention_0963
	,mrkit_payment_Payment_Day_Business_Day_0964 = mrkit_payment_Payment_Day_Business_Day_0963
	,mrkit_payment_Reason_0964 = mrkit_payment_Reason_0963

	-- Exchange
	,mrkit_exchange_Client_Clearing_0964 = mrkit_exchange_Client_Clearing_0963
	,mrkit_exchange_Bilateral_Clearing_House_0964 = mrkit_exchange_Bilateral_Clearing_House_0963
		
	-- swStructuredTradeDetails
	,mrkit_swStructuredTradeDetails_Party_A_Alocation_ID_0964 = mrkit_swStructuredTradeDetails_Party_A_Alocation_ID_0963
	,mrkit_swStructuredTradeDetails_Party_A_Alocation_Name_0964 = mrkit_swStructuredTradeDetails_Party_A_Alocation_Name_0963
	,mrkit_swStructuredTradeDetails_Party_B_Alocation_ID_0964	= mrkit_swStructuredTradeDetails_Party_B_Alocation_ID_0963
	,mrkit_swStructuredTradeDetails_Party_B_Alocation_Name_0964 = mrkit_swStructuredTradeDetails_Party_B_Alocation_Name_0963


	-- Código de instância da importação
	,cod_instc_ipc_0964 = cod_instc_ipc_0963
	
	
	-- Dados Enriquecidos
	,cod_instc_ctpt_0964 = cod_instc_ctpt_0963
	,cod_instc_moe_pta_fix_0964 = cod_instc_moe_pta_fix_0963
	,cod_instc_moe_pta_flu_0964 = cod_instc_moe_pta_flu_0963
	,cod_instc_indx_0964 = cod_instc_indx_0963
	,cod_instc_moe_upfront_0964 = cod_instc_moe_upfront_0963


	-- att rabo de tabela
	,dat_ult_alt_0964 = GETDATE()
	,usr_ult_alt_0964 = SUSER_NAME()

FROM
	dbo.dd_mrkit_irs_0964 AS final
	INNER JOIN
	dbo.dd_mrkit_irs_temp_0963 AS temp ON	final.mrkit_header_Trade_ID_0964	= temp.mrkit_header_Trade_ID_0963
										AND final.mrkit_header_Trade_Date_0964	= temp.mrkit_header_Trade_Date_0963
WHERE
		temp.ind_sit_0963			= 1
	AND	final.ind_sit_0964			= 1
	AND temp.cod_instc_ipc_0963		= @cod_instc_ipc
	AND final.cod_instc_ipc_0964	= @cod_instc_ipc_vigente



/***********************************************************************************************************
	Inserindo os novos dados na tabela final do Markit
***********************************************************************************************************/
INSERT INTO
	dbo.dd_mrkit_irs_0964
	(
		-- Header
		 mrkit_header_Trade_ID_0964
		,mrkit_header_Trade_Version_0964
		,mrkit_header_Trade_Version_Timestamp_0964
		,mrkit_header_Trade_Date_0964
		,mrkit_header_Trade_Status_0964
		,mrkit_header_Master_Agreement_Type_0964
		,mrkit_header_Contractual_Definitions_0964
		,mrkit_header_Party_A_0964
		,mrkit_header_Party_B_0964
		,mrkit_header_Product_Type_0964
		,mrkit_header_Template_Name_0964

		-- Fixed Leg
		,mrkit_fixedLeg_Payer_0964
		,mrkit_fixedLeg_Receiver_0964
		,mrkit_fixedLeg_Effective_Date_0964
		,mrkit_fixedLeg_Effective_Date_Adjustments_0964
		,mrkit_fixedLeg_Termination_Date_0964
		,mrkit_fixedLeg_Termination_Date_Adjustments_0964
		,mrkit_fixedLeg_Calculation_Period_Dates_Adjustments_0964
		,mrkit_fixedLeg_Calculation_Period_Frequency_Multiplier_0964
		,mrkit_fixedLeg_Calculation_Period_Frequency_0964
		,mrkit_fixedLeg_Calculation_Period_Frequency_Roll_Convention_0964
		,mrkit_fixedLeg_Payment_Frequency_Period_Multiplier_0964
		,mrkit_fixedLeg_Payment_Frequency_Period_0964
		,mrkit_fixedLeg_Payment_Dates_PayRelativeTo_0964
		,mrkit_fixedLeg_Payment_Dates_Business_Convention_0964
		,mrkit_fixedLeg_Payment_Dates_Business_Convention_Business_Centers_0964
		,mrkit_fixedLeg_Payments_Day_Offset_Multiplier_0964
		,mrkit_fixedLeg_Payments_Day_Offset_Period_0964
		,mrkit_fixedLeg_Payments_Day_Offset_Day_Type_0964
		,mrkit_fixedLeg_Notional_Amount_0964
		,mrkit_fixedLeg_Notional_Amount_Currency_0964
		,mrkit_fixedLeg_Fixed_Rate_0964
		,mrkit_fixedLeg_Fixed_Rate_Day_Count_Fraction_0964
		,mrkit_fixedLeg_CashFlows_Match_Parameters_0964
		,mrkit_fixedLeg_CashFlows_Payment_Unadjusted_Payment_Date_0964
		,mrkit_fixedLeg_CashFlows_Payment_Fixed_Payment_Amount_0964

		-- Floating Leg
		,mrkit_floatingLeg_Payer_0964
		,mrkit_floatingLeg_Receiver_0964
		,mrkit_floatingLeg_Effective_Date_0964
		,mrkit_floatingLeg_Effective_Date_Adjustments_0964
		,mrkit_floatingLeg_Termination_Date_0964
		,mrkit_floatingLeg_Termination_Date_Adjustments_0964
		,mrkit_floatingLeg_Calculation_Period_Dates_Adjustments_0964
		,mrkit_floatingLeg_Calculation_Period_Frequency_Multiplier_0964
		,mrkit_floatingLeg_Calculation_Period_Frequency_0964
		,mrkit_floatingLeg_Calculation_Period_Frequency_Roll_Convention_0964
		,mrkit_floatingLeg_Payment_Frequency_Period_Multiplier_0964
		,mrkit_floatingLeg_Payment_Frequency_Period_0964
		,mrkit_floatingLeg_Payment_Dates_PayRelativeTo_0964
		,mrkit_floatingLeg_Payment_Dates_Business_Convention_0964
		,mrkit_floatingLeg_Payment_Dates_Business_Convention_Business_Centers_0964
		,mrkit_floatingLeg_Payments_Day_Offset_Multiplier_0964
		,mrkit_floatingLeg_Payments_Day_Offset_Period_0964
		,mrkit_floatingLeg_Payments_Day_Offset_Day_Type_0964
		,mrkit_floatingLeg_Fixing_Reset_Related_To_0964
		,mrkit_floatingLeg_Fixing_Dates_Multiplier_0964
		,mrkit_floatingLeg_Fixing_Dates_Period_0964
		,mrkit_floatingLeg_Fixing_Day_Convention_0964
		,mrkit_floatingLeg_Fixing_Day_Business_Center_0964
		,mrkit_floatingLeg_Reset_Frequency_Multiplier_0964
		,mrkit_floatingLeg_Reset_Frequency_Period_0964
		,mrkit_floatingLeg_Reset_Date_Adjustment_0964
		,mrkit_floatingLeg_Reset_Date_Business_Center_0964
		,mrkit_floatingLeg_Notional_Amount_0964
		,mrkit_floatingLeg_Notional_Amount_Currency_0964
		-- tipo 1 - Produto = "SingleCurrencyInterestRateSwap" ou "OIS"
		,mrkit_floatingLeg_floatingRateCalculation_Index_0964
		,mrkit_floatingLeg_floatingRateCalculation_Index_Frequency_Multiplier_0964
		,mrkit_floatingLeg_floatingRateCalculation_Index_Frequency_Period_0964
		,mrkit_floatingLeg_floatingRateCalculation_Index_Source_0964
		,mrkit_floatingLeg_floatingRateCalculation_Inflation_Rate_Interpolation_Method_0964
		,mrkit_floatingLeg_floatingRateCalculation_Inflation_Rate_Level_0964
		,mrkit_floatingLeg_floatingRateCalculation_DayCountFraction_0964
		,mrkit_floatingLeg_floatingRateCalculation_Spread_0964
		-- tipo 2 - Produto = "ZC Inflation"
		,mrkit_floatingLeg_inflationRateCalculation_Index_0964
		,mrkit_floatingLeg_inflationRateCalculation_Index_Frequency_Multiplier_0964
		,mrkit_floatingLeg_inflationRateCalculation_Index_Frequency_Period_0964
		,mrkit_floatingLeg_inflationRateCalculation_Index_Source_0964
		,mrkit_floatingLeg_inflationRateCalculation_Inflation_Rate_Interpolation_Method_0964
		,mrkit_floatingLeg_inflationRateCalculation_Inflation_Rate_Level_0964
		,mrkit_floatingLeg_inflationRateCalculation_DayCountFraction_0964
		,mrkit_floatingLeg_inflationRateCalculation_Spread_0964

		-- Payment
		,mrkit_payment_Payer_0964
		,mrkit_payment_Receiver_0964
		,mrkit_payment_Payment_Amount_0964
		,mrkit_payment_Payment_Currency_0964
		,mrkit_payment_Payment_Date_0964
		,mrkit_payment_Payment_Day_Business_Day_Convention_0964
		,mrkit_payment_Payment_Day_Business_Day_0964
		,mrkit_payment_Reason_0964

		-- Exchange
		,mrkit_exchange_Client_Clearing_0964
		,mrkit_exchange_Bilateral_Clearing_House_0964


		-- swStructuredTradeDetails
		,mrkit_swStructuredTradeDetails_Party_A_Alocation_ID_0964
		,mrkit_swStructuredTradeDetails_Party_A_Alocation_Name_0964
		,mrkit_swStructuredTradeDetails_Party_B_Alocation_ID_0964
		,mrkit_swStructuredTradeDetails_Party_B_Alocation_Name_0964


		-- Código de Instância da Importação
		,cod_instc_ipc_0964


		-- Dados Enriquecidos
		,cod_instc_ctpt_0964
		,cod_instc_moe_pta_fix_0964
		,cod_instc_moe_pta_flu_0964
		,cod_instc_indx_0964
		,cod_instc_moe_upfront_0964


		-- Controle de versao da tabela
		,ind_sit_0964

		,dat_cdm_0964
		,usr_cdm_0964
	)
SELECT
		-- Header
		 mrkit_header_Trade_ID_0963
		,mrkit_header_Trade_Version_0963
		,mrkit_header_Trade_Version_Timestamp_0963
		,mrkit_header_Trade_Date_0963
		,mrkit_header_Trade_Status_0963
		,mrkit_header_Master_Agreement_Type_0963
		,mrkit_header_Contractual_Definitions_0963
		,mrkit_header_Party_A_0963
		,mrkit_header_Party_B_0963
		,mrkit_header_Product_Type_0963
		,mrkit_header_Template_Name_0963

		-- Fixed Leg
		,mrkit_fixedLeg_Payer_0963
		,mrkit_fixedLeg_Receiver_0963
		,mrkit_fixedLeg_Effective_Date_0963
		,mrkit_fixedLeg_Effective_Date_Adjustments_0963
		,mrkit_fixedLeg_Termination_Date_0963
		,mrkit_fixedLeg_Termination_Date_Adjustments_0963
		,mrkit_fixedLeg_Calculation_Period_Dates_Adjustments_0963
		,mrkit_fixedLeg_Calculation_Period_Frequency_Multiplier_0963
		,mrkit_fixedLeg_Calculation_Period_Frequency_0963
		,mrkit_fixedLeg_Calculation_Period_Frequency_Roll_Convention_0963
		,mrkit_fixedLeg_Payment_Frequency_Period_Multiplier_0963
		,mrkit_fixedLeg_Payment_Frequency_Period_0963
		,mrkit_fixedLeg_Payment_Dates_PayRelativeTo_0963
		,mrkit_fixedLeg_Payment_Dates_Business_Convention_0963
		,mrkit_fixedLeg_Payment_Dates_Business_Convention_Business_Centers_0963
		,mrkit_fixedLeg_Payments_Day_Offset_Multiplier_0963
		,mrkit_fixedLeg_Payments_Day_Offset_Period_0963
		,mrkit_fixedLeg_Payments_Day_Offset_Day_Type_0963
		,mrkit_fixedLeg_Notional_Amount_0963
		,mrkit_fixedLeg_Notional_Amount_Currency_0963
		,mrkit_fixedLeg_Fixed_Rate_0963
		,mrkit_fixedLeg_Fixed_Rate_Day_Count_Fraction_0963
		,mrkit_fixedLeg_CashFlows_Match_Parameters_0963
		,mrkit_fixedLeg_CashFlows_Payment_Unadjusted_Payment_Date_0963
		,mrkit_fixedLeg_CashFlows_Payment_Fixed_Payment_Amount_0963

		-- Floating Leg
		,mrkit_floatingLeg_Payer_0963
		,mrkit_floatingLeg_Receiver_0963
		,mrkit_floatingLeg_Effective_Date_0963
		,mrkit_floatingLeg_Effective_Date_Adjustments_0963
		,mrkit_floatingLeg_Termination_Date_0963
		,mrkit_floatingLeg_Termination_Date_Adjustments_0963
		,mrkit_floatingLeg_Calculation_Period_Dates_Adjustments_0963
		,mrkit_floatingLeg_Calculation_Period_Frequency_Multiplier_0963
		,mrkit_floatingLeg_Calculation_Period_Frequency_0963
		,mrkit_floatingLeg_Calculation_Period_Frequency_Roll_Convention_0963
		,mrkit_floatingLeg_Payment_Frequency_Period_Multiplier_0963
		,mrkit_floatingLeg_Payment_Frequency_Period_0963
		,mrkit_floatingLeg_Payment_Dates_PayRelativeTo_0963
		,mrkit_floatingLeg_Payment_Dates_Business_Convention_0963
		,mrkit_floatingLeg_Payment_Dates_Business_Convention_Business_Centers_0963
		,mrkit_floatingLeg_Payments_Day_Offset_Multiplier_0963
		,mrkit_floatingLeg_Payments_Day_Offset_Period_0963
		,mrkit_floatingLeg_Payments_Day_Offset_Day_Type_0963
		,mrkit_floatingLeg_Fixing_Reset_Related_To_0963
		,mrkit_floatingLeg_Fixing_Dates_Multiplier_0963
		,mrkit_floatingLeg_Fixing_Dates_Period_0963
		,mrkit_floatingLeg_Fixing_Day_Convention_0963
		,mrkit_floatingLeg_Fixing_Day_Business_Center_0963
		,mrkit_floatingLeg_Reset_Frequency_Multiplier_0963
		,mrkit_floatingLeg_Reset_Frequency_Period_0963
		,mrkit_floatingLeg_Reset_Date_Adjustment_0963
		,mrkit_floatingLeg_Reset_Date_Business_Center_0963
		,mrkit_floatingLeg_Notional_Amount_0963
		,mrkit_floatingLeg_Notional_Amount_Currency_0963
		-- tipo 1 - Produto = "SingleCurrencyInterestRateSwap" ou "OIS"
		,mrkit_floatingLeg_floatingRateCalculation_Index_0963
		,mrkit_floatingLeg_floatingRateCalculation_Index_Frequency_Multiplier_0963
		,mrkit_floatingLeg_floatingRateCalculation_Index_Frequency_Period_0963
		,mrkit_floatingLeg_floatingRateCalculation_Index_Source_0963
		,mrkit_floatingLeg_floatingRateCalculation_Inflation_Rate_Interpolation_Method_0963
		,mrkit_floatingLeg_floatingRateCalculation_Inflation_Rate_Level_0963
		,mrkit_floatingLeg_floatingRateCalculation_DayCountFraction_0963
		,mrkit_floatingLeg_floatingRateCalculation_Spread_0963
		-- tipo 2 - Produto = "ZC Inflation"
		,mrkit_floatingLeg_inflationRateCalculation_Index_0963
		,mrkit_floatingLeg_inflationRateCalculation_Index_Frequency_Multiplier_0963
		,mrkit_floatingLeg_inflationRateCalculation_Index_Frequency_Period_0963
		,mrkit_floatingLeg_inflationRateCalculation_Index_Source_0963
		,mrkit_floatingLeg_inflationRateCalculation_Inflation_Rate_Interpolation_Method_0963
		,mrkit_floatingLeg_inflationRateCalculation_Inflation_Rate_Level_0963
		,mrkit_floatingLeg_inflationRateCalculation_DayCountFraction_0963
		,mrkit_floatingLeg_inflationRateCalculation_Spread_0963

		-- Payment
		,mrkit_payment_Payer_0963
		,mrkit_payment_Receiver_0963
		,mrkit_payment_Payment_Amount_0963
		,mrkit_payment_Payment_Currency_0963
		,mrkit_payment_Payment_Date_0963
		,mrkit_payment_Payment_Day_Business_Day_Convention_0963
		,mrkit_payment_Payment_Day_Business_Day_0963
		,mrkit_payment_Reason_0963

		-- Exchange
		,mrkit_exchange_Client_Clearing_0963
		,mrkit_exchange_Bilateral_Clearing_House_0963

		-- swStructuredTradeDetails
		,mrkit_swStructuredTradeDetails_Party_A_Alocation_ID_0963
		,mrkit_swStructuredTradeDetails_Party_A_Alocation_Name_0963
		,mrkit_swStructuredTradeDetails_Party_B_Alocation_ID_0963
		,mrkit_swStructuredTradeDetails_Party_B_Alocation_Name_0963


		-- Código de Instância da Importação
		,cod_instc_ipc_0963


		-- Dados Enriquecidos
		,cod_instc_ctpt_0963
		,cod_instc_moe_pta_fix_0963
		,cod_instc_moe_pta_flu_0963
		,cod_instc_indx_0963
		,cod_instc_moe_upfront_0963


		-- Controle de versao da tabela
		,1

		,GETDATE()
		,SUSER_NAME()
	
FROM
	dbo.dd_mrkit_irs_temp_0963 AS temp
	LEFT JOIN
	dbo.dd_mrkit_irs_0964 AS final ON	final.mrkit_header_Trade_ID_0964	= temp.mrkit_header_Trade_ID_0963
									AND final.mrkit_header_Trade_Date_0964	= temp.mrkit_header_Trade_Date_0963	
									AND final.cod_instc_ipc_0964		= temp.cod_instc_ipc_0963	
									AND final.ind_sit_0964				= 1
WHERE
		temp.ind_sit_0963			= 1
	AND temp.cod_instc_ipc_0963		= @cod_instc_ipc
	AND final.cod_instc_0964 IS NULL



/***********************************************************************************************************
	 Alertando sobre possíveis problemas na importação e ativando a importação atual                                                
***********************************************************************************************************/
-- Colocando os erros em uma tabela global, para que esta possa ser acessada pela procedure de email
IF  EXISTS (SELECT * FROM tempdb.sys.objects WHERE name = '##Temp_Problemas_Validacao_Markit' )
DROP TABLE ##Temp_Problemas_Validacao_Markit

CREATE TABLE ##Temp_Problemas_Validacao_Markit (descErro varchar(8000))

INSERT INTO
	##Temp_Problemas_Validacao_Markit
SELECT DISTINCT
	descErro
FROM
	#Problemas_Validacao_Markit
WHERE
	descErro <> ''

	
-- Só é necessário o envio de email, caso existam erros
Declare @qtdErrosValidacao int

Select 
	@qtdErrosValidacao = COUNT(*)
From 
	##Temp_Problemas_Validacao_Markit

IF @qtdErrosValidacao > 0 AND @@SERVERNAME = 'vm-sql-prd-003'
BEGIN
	-- Enviando email de Monitoramento para alertar sobre a não integridade da importação
	EXECUTE bd_108_bbmcorp..UP_Envia_Email
									@nome_da_rotina_executora = 'ALERTA_CADASTRO_IMPORTACAO_MARKIT'
									,@profile_name = 'Monitoramento'
									,@recipients = 'funds@bahiaasset.com.br'
									,@subject = 'Alerta: Importação de Dados - Markit'
									,@query =  'SET NOCOUNT ON; Select * From ##Temp_Problemas_Validacao_Markit'
									,@execute_query_database = 'bd_106_bbmfront'
									,@attach_query_result_as_file = 1
									,@query_attachment_filename = 'MARKIT_PROBLEMA_IMPORTACAO.csv'
									,@query_result_header = 0

	RETURN
END



/****************************************************************************************************
	Desabilitando a importação vigente até então, caso exista e seja diferente desta
****************************************************************************************************/
UPDATE
	ctrl_ipc_mrkit_0962
SET
	 ind_sit_0962 = 3
	,dat_sit_0962 = GETDATE()
	,usr_sit_0962 = SUSER_NAME()
WHERE
		cod_instc_0962 <> @cod_instc_ipc
	AND dat_ipc_0962 = @data



/************************************************************
	Marcando esta importação como a vigente
************************************************************/
UPDATE
	ctrl_ipc_mrkit_0962
SET
	ind_sit_0962= 1
	,dat_sit_0962 = GETDATE()
	,usr_sit_0962 = SUSER_NAME()
WHERE
		cod_instc_0962 = @cod_instc_ipc
	AND dat_ipc_0962 = @data



	select * from #Problemas_Validacao_Markit