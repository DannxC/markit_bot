USE bd_106_bbmfront

--DROP TABLE dd_mrkit_irs_temp_0963
--DROP TABLE dd_mrkit_irs_0964

/************************************************************
	dd_mrkit_irs_temp_0963
************************************************************/
CREATE TABLE dd_mrkit_irs_temp_0963
(
	-- codInstc provindo da tabela de controle.

     cod_instc_0963					int IDENTITY(1,1) PRIMARY KEY		-- chave primária, ela se auto-incrementa


	-- Principais dados
	
	-- Header
	,mrkit_header_Trade_ID_0963																		bigint
	,mrkit_header_Trade_Version_0963																	bigint
	,mrkit_header_Trade_Version_Timestamp_0963														DateTime
	,mrkit_header_Trade_Date_0963																		date
	,mrkit_header_Trade_Status_0963																	varchar(200)
	,mrkit_header_Master_Agreement_Type_0963															varchar(200)
	,mrkit_header_Contractual_Definitions_0963														varchar(200)
	,mrkit_header_Party_A_0963																		varchar(200)
	,mrkit_header_Party_B_0963																		varchar(200)
	,mrkit_header_Product_Type_0963																	varchar(200)
	,mrkit_header_Template_Name_0963																	varchar(200)
	,mrkit_fixedLeg_Payer_0963																		varchar(200)
	,mrkit_fixedLeg_Receiver_0963																		varchar(200)
	,mrkit_fixedLeg_Effective_Date_0963																date
	,mrkit_fixedLeg_Effective_Date_Adjustments_0963													varchar(200)
	,mrkit_fixedLeg_Termination_Date_0963																date
	,mrkit_fixedLeg_Termination_Date_Adjustments_0963													varchar(200)
	,mrkit_fixedLeg_Calculation_Period_Dates_Adjustments_0963											varchar(200)
	,mrkit_fixedLeg_Calculation_Period_Frequency_Multiplier_0963										bigint
	,mrkit_fixedLeg_Calculation_Period_Frequency_0963													varchar(200)
	,mrkit_fixedLeg_Calculation_Period_Frequency_Roll_Convention_0963									varchar(200)
	,mrkit_fixedLeg_Payment_Frequency_Period_Multiplier_0963											bigint
	,mrkit_fixedLeg_Payment_Frequency_Period_0963														varchar(200)
	,mrkit_fixedLeg_Payment_Dates_PayRelativeTo_0963													varchar(200)
	,mrkit_fixedLeg_Payment_Dates_Business_Convention_0963											varchar(200)
	,mrkit_fixedLeg_Payment_Dates_Business_Convention_Business_Centers_0963							varchar(200)
	,mrkit_fixedLeg_Payments_Day_Offset_Multiplier_0963												bigint
	,mrkit_fixedLeg_Payments_Day_Offset_Period_0963													varchar(200)
	,mrkit_fixedLeg_Payments_Day_Offset_Day_Type_0963													varchar(200)
	,mrkit_fixedLeg_Notional_Amount_0963																bigint
	,mrkit_fixedLeg_Notional_Amount_Currency_0963														varchar(200)
	,mrkit_fixedLeg_Fixed_Rate_0963																	float
	,mrkit_fixedLeg_Fixed_Rate_Day_Count_Fraction_0963												varchar(200)
	,mrkit_fixedLeg_CashFlows_Match_Parameters_0963													bit
	,mrkit_fixedLeg_CashFlows_Payment_Unadjusted_Payment_Date_0963									date
	,mrkit_fixedLeg_CashFlows_Payment_Fixed_Payment_Amount_0963										float
	,mrkit_floatingLeg_Payer_0963																		varchar(200)
	,mrkit_floatingLeg_Receiver_0963																	varchar(200)
	,mrkit_floatingLeg_Effective_Date_0963															date
	,mrkit_floatingLeg_Effective_Date_Adjustments_0963												varchar(200)
	,mrkit_floatingLeg_Termination_Date_0963															date
	,mrkit_floatingLeg_Termination_Date_Adjustments_0963												varchar(200)
	,mrkit_floatingLeg_Calculation_Period_Dates_Adjustments_0963										varchar(200)
	,mrkit_floatingLeg_Calculation_Period_Frequency_Multiplier_0963									bigint
	,mrkit_floatingLeg_Calculation_Period_Frequency_0963												varchar(200)
	,mrkit_floatingLeg_Calculation_Period_Frequency_Roll_Convention_0963								varchar(200)
	,mrkit_floatingLeg_Payment_Frequency_Period_Multiplier_0963										bigint
	,mrkit_floatingLeg_Payment_Frequency_Period_0963													varchar(200)
	,mrkit_floatingLeg_Payment_Dates_PayRelativeTo_0963												varchar(200)
	,mrkit_floatingLeg_Payment_Dates_Business_Convention_0963											varchar(200)
	,mrkit_floatingLeg_Payment_Dates_Business_Convention_Business_Centers_0963						varchar(200)
	,mrkit_floatingLeg_Payments_Day_Offset_Multiplier_0963											bigint
	,mrkit_floatingLeg_Payments_Day_Offset_Period_0963												varchar(200)
	,mrkit_floatingLeg_Payments_Day_Offset_Day_Type_0963												varchar(200)
	,mrkit_floatingLeg_Fixing_Reset_Related_To_0963													varchar(200)
	,mrkit_floatingLeg_Fixing_Dates_Multiplier_0963													bigint
	,mrkit_floatingLeg_Fixing_Dates_Period_0963														varchar(200)
	,mrkit_floatingLeg_Fixing_Day_Convention_0963														varchar(200)
	,mrkit_floatingLeg_Fixing_Day_Business_Center_0963												varchar(200)
	,mrkit_floatingLeg_Reset_Frequency_Multiplier_0963												bigint
	,mrkit_floatingLeg_Reset_Frequency_Period_0963													varchar(200)
	,mrkit_floatingLeg_Reset_Date_Adjustment_0963														varchar(200)
	,mrkit_floatingLeg_Reset_Date_Business_Center_0963												varchar(200)
	,mrkit_floatingLeg_Notional_Amount_0963															bigint
	,mrkit_floatingLeg_Notional_Amount_Currency_0963													varchar(200)
	,mrkit_floatingLeg_floatingRateCalculation_Index_0963												varchar(200)
	,mrkit_floatingLeg_floatingRateCalculation_Index_Frequency_Multiplier_0963						bigint
	,mrkit_floatingLeg_floatingRateCalculation_Index_Frequency_Period_0963							varchar(200)
	,mrkit_floatingLeg_floatingRateCalculation_Index_Source_0963										varchar(200)
	,mrkit_floatingLeg_floatingRateCalculation_Inflation_Rate_Interpolation_Method_0963				varchar(200)
	,mrkit_floatingLeg_floatingRateCalculation_Inflation_Rate_Level_0963								float
	,mrkit_floatingLeg_floatingRateCalculation_DayCountFraction_0963									varchar(200)
	,mrkit_floatingLeg_floatingRateCalculation_Spread_0963											float
	,mrkit_floatingLeg_inflationRateCalculation_Index_0963											varchar(200)
	,mrkit_floatingLeg_inflationRateCalculation_Index_Frequency_Multiplier_0963						bigint
	,mrkit_floatingLeg_inflationRateCalculation_Index_Frequency_Period_0963							varchar(200)
	,mrkit_floatingLeg_inflationRateCalculation_Index_Source_0963										varchar(200)
	,mrkit_floatingLeg_inflationRateCalculation_Inflation_Rate_Interpolation_Method_0963				varchar(200)
	,mrkit_floatingLeg_inflationRateCalculation_Inflation_Rate_Level_0963								float
	,mrkit_floatingLeg_inflationRateCalculation_DayCountFraction_0963									varchar(200)
	,mrkit_floatingLeg_inflationRateCalculation_Spread_0963											float
	,mrkit_payment_Payer_0963																			varchar(200)
	,mrkit_payment_Receiver_0963																		varchar(200)
	,mrkit_payment_Payment_Amount_0963																float
	,mrkit_payment_Payment_Currency_0963																varchar(200)
	,mrkit_payment_Payment_Date_0963																	date
	,mrkit_payment_Payment_Day_Business_Day_Convention_0963											varchar(200)
	,mrkit_payment_Payment_Day_Business_Day_0963														varchar(200)
	,mrkit_payment_Reason_0963																		varchar(200)
	,mrkit_exchange_Client_Clearing_0963																bit
	,mrkit_exchange_Bilateral_Clearing_House_0963														varchar(200)
	,mrkit_swStructuredTradeDetails_Party_A_Alocation_ID_0963											varchar(200)
	,mrkit_swStructuredTradeDetails_Party_A_Alocation_Name_0963										varchar(200)
	,mrkit_swStructuredTradeDetails_Party_B_Alocation_ID_0963											varchar(200)
	,mrkit_swStructuredTradeDetails_Party_B_Alocation_Name_0963										varchar(200)


	-- Código de Instância da Importação
	,cod_instc_ipc_0963				int


	-- Dados Enriquecidos
	,cod_instc_ctpt_0963						int		
	,cod_instc_moe_pta_fix_0963					int		--cod_instc_moe_pta_psva_0963
	,cod_instc_moe_pta_flu_0963					int		--cod_instc_moe_pta_atva_0963
	,cod_instc_indx_0963						INT		--cod_instc_indx_pta_atva_0963
	,cod_instc_moe_upfront_0963					int		


    -- controle de versao da tabela
    ,ind_sit_0963					int

    ,dat_cdm_0963					DateTime
    ,usr_cdm_0963					VarChar(256)

    ,dat_sit_0963					DateTime
    ,usr_sit_0963					VarChar(256)

    ,dat_ult_alt_0963				DateTime
    ,usr_ult_alt_0963				VarChar(256)
)


/************************************************************
	dd_mrkit_irs_0964
************************************************************/
CREATE TABLE dd_mrkit_irs_0964
(
	-- codInstc provindo da tabela de controle.
     cod_instc_0964					int IDENTITY(1,1) PRIMARY KEY		-- chave primária, ela se auto-incrementa


	-- Principais dados
	
	-- Header
	,mrkit_header_Trade_ID_0964																		bigint
	,mrkit_header_Trade_Version_0964																	bigint
	,mrkit_header_Trade_Version_Timestamp_0964														DateTime
	,mrkit_header_Trade_Date_0964																		date
	,mrkit_header_Trade_Status_0964																	varchar(200)
	,mrkit_header_Master_Agreement_Type_0964															varchar(200)
	,mrkit_header_Contractual_Definitions_0964														varchar(200)
	,mrkit_header_Party_A_0964																		varchar(200)
	,mrkit_header_Party_B_0964																		varchar(200)
	,mrkit_header_Product_Type_0964																	varchar(200)
	,mrkit_header_Template_Name_0964																	varchar(200)
	,mrkit_fixedLeg_Payer_0964																		varchar(200)
	,mrkit_fixedLeg_Receiver_0964																		varchar(200)
	,mrkit_fixedLeg_Effective_Date_0964																date
	,mrkit_fixedLeg_Effective_Date_Adjustments_0964													varchar(200)
	,mrkit_fixedLeg_Termination_Date_0964																date
	,mrkit_fixedLeg_Termination_Date_Adjustments_0964													varchar(200)
	,mrkit_fixedLeg_Calculation_Period_Dates_Adjustments_0964											varchar(200)
	,mrkit_fixedLeg_Calculation_Period_Frequency_Multiplier_0964										bigint
	,mrkit_fixedLeg_Calculation_Period_Frequency_0964													varchar(200)
	,mrkit_fixedLeg_Calculation_Period_Frequency_Roll_Convention_0964									varchar(200)
	,mrkit_fixedLeg_Payment_Frequency_Period_Multiplier_0964											bigint
	,mrkit_fixedLeg_Payment_Frequency_Period_0964														varchar(200)
	,mrkit_fixedLeg_Payment_Dates_PayRelativeTo_0964													varchar(200)
	,mrkit_fixedLeg_Payment_Dates_Business_Convention_0964											varchar(200)
	,mrkit_fixedLeg_Payment_Dates_Business_Convention_Business_Centers_0964							varchar(200)
	,mrkit_fixedLeg_Payments_Day_Offset_Multiplier_0964												bigint
	,mrkit_fixedLeg_Payments_Day_Offset_Period_0964													varchar(200)
	,mrkit_fixedLeg_Payments_Day_Offset_Day_Type_0964													varchar(200)
	,mrkit_fixedLeg_Notional_Amount_0964																bigint
	,mrkit_fixedLeg_Notional_Amount_Currency_0964														varchar(200)
	,mrkit_fixedLeg_Fixed_Rate_0964																	float
	,mrkit_fixedLeg_Fixed_Rate_Day_Count_Fraction_0964												varchar(200)
	,mrkit_fixedLeg_CashFlows_Match_Parameters_0964													bit
	,mrkit_fixedLeg_CashFlows_Payment_Unadjusted_Payment_Date_0964									date
	,mrkit_fixedLeg_CashFlows_Payment_Fixed_Payment_Amount_0964										float
	,mrkit_floatingLeg_Payer_0964																		varchar(200)
	,mrkit_floatingLeg_Receiver_0964																	varchar(200)
	,mrkit_floatingLeg_Effective_Date_0964															date
	,mrkit_floatingLeg_Effective_Date_Adjustments_0964												varchar(200)
	,mrkit_floatingLeg_Termination_Date_0964															date
	,mrkit_floatingLeg_Termination_Date_Adjustments_0964												varchar(200)
	,mrkit_floatingLeg_Calculation_Period_Dates_Adjustments_0964										varchar(200)
	,mrkit_floatingLeg_Calculation_Period_Frequency_Multiplier_0964									bigint
	,mrkit_floatingLeg_Calculation_Period_Frequency_0964												varchar(200)
	,mrkit_floatingLeg_Calculation_Period_Frequency_Roll_Convention_0964								varchar(200)
	,mrkit_floatingLeg_Payment_Frequency_Period_Multiplier_0964										bigint
	,mrkit_floatingLeg_Payment_Frequency_Period_0964													varchar(200)
	,mrkit_floatingLeg_Payment_Dates_PayRelativeTo_0964												varchar(200)
	,mrkit_floatingLeg_Payment_Dates_Business_Convention_0964											varchar(200)
	,mrkit_floatingLeg_Payment_Dates_Business_Convention_Business_Centers_0964						varchar(200)
	,mrkit_floatingLeg_Payments_Day_Offset_Multiplier_0964											bigint
	,mrkit_floatingLeg_Payments_Day_Offset_Period_0964												varchar(200)
	,mrkit_floatingLeg_Payments_Day_Offset_Day_Type_0964												varchar(200)
	,mrkit_floatingLeg_Fixing_Reset_Related_To_0964													varchar(200)
	,mrkit_floatingLeg_Fixing_Dates_Multiplier_0964													bigint
	,mrkit_floatingLeg_Fixing_Dates_Period_0964														varchar(200)
	,mrkit_floatingLeg_Fixing_Day_Convention_0964														varchar(200)
	,mrkit_floatingLeg_Fixing_Day_Business_Center_0964												varchar(200)
	,mrkit_floatingLeg_Reset_Frequency_Multiplier_0964												bigint
	,mrkit_floatingLeg_Reset_Frequency_Period_0964													varchar(200)
	,mrkit_floatingLeg_Reset_Date_Adjustment_0964														varchar(200)
	,mrkit_floatingLeg_Reset_Date_Business_Center_0964												varchar(200)
	,mrkit_floatingLeg_Notional_Amount_0964															bigint
	,mrkit_floatingLeg_Notional_Amount_Currency_0964													varchar(200)
	,mrkit_floatingLeg_floatingRateCalculation_Index_0964												varchar(200)
	,mrkit_floatingLeg_floatingRateCalculation_Index_Frequency_Multiplier_0964						bigint
	,mrkit_floatingLeg_floatingRateCalculation_Index_Frequency_Period_0964							varchar(200)
	,mrkit_floatingLeg_floatingRateCalculation_Index_Source_0964										varchar(200)
	,mrkit_floatingLeg_floatingRateCalculation_Inflation_Rate_Interpolation_Method_0964				varchar(200)
	,mrkit_floatingLeg_floatingRateCalculation_Inflation_Rate_Level_0964								float
	,mrkit_floatingLeg_floatingRateCalculation_DayCountFraction_0964									varchar(200)
	,mrkit_floatingLeg_floatingRateCalculation_Spread_0964											float
	,mrkit_floatingLeg_inflationRateCalculation_Index_0964											varchar(200)
	,mrkit_floatingLeg_inflationRateCalculation_Index_Frequency_Multiplier_0964						bigint
	,mrkit_floatingLeg_inflationRateCalculation_Index_Frequency_Period_0964							varchar(200)
	,mrkit_floatingLeg_inflationRateCalculation_Index_Source_0964										varchar(200)
	,mrkit_floatingLeg_inflationRateCalculation_Inflation_Rate_Interpolation_Method_0964				varchar(200)
	,mrkit_floatingLeg_inflationRateCalculation_Inflation_Rate_Level_0964								float
	,mrkit_floatingLeg_inflationRateCalculation_DayCountFraction_0964									varchar(200)
	,mrkit_floatingLeg_inflationRateCalculation_Spread_0964											float
	,mrkit_payment_Payer_0964																			varchar(200)
	,mrkit_payment_Receiver_0964																		varchar(200)
	,mrkit_payment_Payment_Amount_0964																float
	,mrkit_payment_Payment_Currency_0964																varchar(200)
	,mrkit_payment_Payment_Date_0964																	date
	,mrkit_payment_Payment_Day_Business_Day_Convention_0964											varchar(200)
	,mrkit_payment_Payment_Day_Business_Day_0964														varchar(200)
	,mrkit_payment_Reason_0964																		varchar(200)
	,mrkit_exchange_Client_Clearing_0964																bit
	,mrkit_exchange_Bilateral_Clearing_House_0964														varchar(200)
	,mrkit_swStructuredTradeDetails_Party_A_Alocation_ID_0964											varchar(200)
	,mrkit_swStructuredTradeDetails_Party_A_Alocation_Name_0964										varchar(200)
	,mrkit_swStructuredTradeDetails_Party_B_Alocation_ID_0964											varchar(200)
	,mrkit_swStructuredTradeDetails_Party_B_Alocation_Name_0964										varchar(200)


	-- Código de Instância da Importação
	,cod_instc_ipc_0964							int


	-- Dados Enriquecidos
	,cod_instc_ctpt_0964						int	
	,cod_instc_moe_pta_fix_0964					int		--cod_instc_moe_pta_psva_0964
	,cod_instc_moe_pta_flu_0964					int		--cod_instc_moe_pta_atva_0964
	,cod_instc_indx_0964						INT		--cod_instc_indx_pta_atva_0964
	,cod_instc_moe_upfront_0964					int		


    -- Controle de versao da tabela
    ,ind_sit_0964					int

    ,dat_cdm_0964					DateTime
    ,usr_cdm_0964					VarChar(256)

    ,dat_sit_0964					DateTime
    ,usr_sit_0964					VarChar(256)

    ,dat_ult_alt_0964				DateTime
    ,usr_ult_alt_0964				VarChar(256)
)

/************************************************************
	copiando dados das tabelas antigas -dd_mrkit_irs_temp_0963
************************************************************/
GO  

SET IDENTITY_INSERT bd_106_bbmfront.dbo.dd_mrkit_irs_temp_0963 ON

--dd_mrkit_irs_temp_0963
INSERT INTO
	bd_106_bbmfront.dbo.dd_mrkit_irs_temp_0963
	(
	cod_instc_0963,
    mrkit_header_Trade_ID_0963,
    mrkit_header_Trade_Version_0963,
    mrkit_header_Trade_Version_Timestamp_0963,
    mrkit_header_Trade_Date_0963,
    mrkit_header_Trade_Status_0963,
    mrkit_header_Master_Agreement_Type_0963,
    mrkit_header_Contractual_Definitions_0963,
    mrkit_header_Party_A_0963,
    mrkit_header_Party_B_0963,
    mrkit_header_Product_Type_0963,
    mrkit_header_Template_Name_0963,
    mrkit_fixedLeg_Payer_0963,
    mrkit_fixedLeg_Receiver_0963,
    mrkit_fixedLeg_Effective_Date_0963,
    mrkit_fixedLeg_Effective_Date_Adjustments_0963,
    mrkit_fixedLeg_Termination_Date_0963,
    mrkit_fixedLeg_Termination_Date_Adjustments_0963,
    mrkit_fixedLeg_Calculation_Period_Dates_Adjustments_0963,
    mrkit_fixedLeg_Calculation_Period_Frequency_Multiplier_0963,
    mrkit_fixedLeg_Calculation_Period_Frequency_0963,
    mrkit_fixedLeg_Calculation_Period_Frequency_Roll_Convention_0963,
    mrkit_fixedLeg_Payment_Frequency_Period_Multiplier_0963,
    mrkit_fixedLeg_Payment_Frequency_Period_0963,
    mrkit_fixedLeg_Payment_Dates_PayRelativeTo_0963,
    mrkit_fixedLeg_Payment_Dates_Business_Convention_0963,
    mrkit_fixedLeg_Payment_Dates_Business_Convention_Business_Centers_0963,
    mrkit_fixedLeg_Payments_Day_Offset_Multiplier_0963,
    mrkit_fixedLeg_Payments_Day_Offset_Period_0963,
    mrkit_fixedLeg_Payments_Day_Offset_Day_Type_0963,
    mrkit_fixedLeg_Notional_Amount_0963,
    mrkit_fixedLeg_Notional_Amount_Currency_0963,
    mrkit_fixedLeg_Fixed_Rate_0963,
    mrkit_fixedLeg_Fixed_Rate_Day_Count_Fraction_0963,
    mrkit_fixedLeg_CashFlows_Match_Parameters_0963,
    mrkit_fixedLeg_CashFlows_Payment_Unadjusted_Payment_Date_0963,
    mrkit_fixedLeg_CashFlows_Payment_Fixed_Payment_Amount_0963,
    mrkit_floatingLeg_Payer_0963,
    mrkit_floatingLeg_Receiver_0963,
    mrkit_floatingLeg_Effective_Date_0963,
    mrkit_floatingLeg_Effective_Date_Adjustments_0963,
    mrkit_floatingLeg_Termination_Date_0963,
    mrkit_floatingLeg_Termination_Date_Adjustments_0963,
    mrkit_floatingLeg_Calculation_Period_Dates_Adjustments_0963,
    mrkit_floatingLeg_Calculation_Period_Frequency_Multiplier_0963,
    mrkit_floatingLeg_Calculation_Period_Frequency_0963,
    mrkit_floatingLeg_Calculation_Period_Frequency_Roll_Convention_0963,
    mrkit_floatingLeg_Payment_Frequency_Period_Multiplier_0963,
    mrkit_floatingLeg_Payment_Frequency_Period_0963,
    mrkit_floatingLeg_Payment_Dates_PayRelativeTo_0963,
    mrkit_floatingLeg_Payment_Dates_Business_Convention_0963,
    mrkit_floatingLeg_Payment_Dates_Business_Convention_Business_Centers_0963,
    mrkit_floatingLeg_Payments_Day_Offset_Multiplier_0963,
    mrkit_floatingLeg_Payments_Day_Offset_Period_0963,
    mrkit_floatingLeg_Payments_Day_Offset_Day_Type_0963,
    mrkit_floatingLeg_Fixing_Reset_Related_To_0963,
    mrkit_floatingLeg_Fixing_Dates_Multiplier_0963,
    mrkit_floatingLeg_Fixing_Dates_Period_0963,
    mrkit_floatingLeg_Fixing_Day_Convention_0963,
    mrkit_floatingLeg_Fixing_Day_Business_Center_0963,
    mrkit_floatingLeg_Reset_Frequency_Multiplier_0963,
    mrkit_floatingLeg_Reset_Frequency_Period_0963,
    mrkit_floatingLeg_Reset_Date_Adjustment_0963,
    mrkit_floatingLeg_Reset_Date_Business_Center_0963,
    mrkit_floatingLeg_Notional_Amount_0963,
    mrkit_floatingLeg_Notional_Amount_Currency_0963,
    mrkit_floatingLeg_floatingRateCalculation_Index_0963,
    mrkit_floatingLeg_floatingRateCalculation_Index_Frequency_Multiplier_0963,
    mrkit_floatingLeg_floatingRateCalculation_Index_Frequency_Period_0963,
    mrkit_floatingLeg_floatingRateCalculation_Index_Source_0963,
    mrkit_floatingLeg_floatingRateCalculation_Inflation_Rate_Interpolation_Method_0963,
    mrkit_floatingLeg_floatingRateCalculation_Inflation_Rate_Level_0963,
    mrkit_floatingLeg_floatingRateCalculation_DayCountFraction_0963,
    mrkit_floatingLeg_floatingRateCalculation_Spread_0963,
    mrkit_floatingLeg_inflationRateCalculation_Index_0963,
    mrkit_floatingLeg_inflationRateCalculation_Index_Frequency_Multiplier_0963,
    mrkit_floatingLeg_inflationRateCalculation_Index_Frequency_Period_0963,
    mrkit_floatingLeg_inflationRateCalculation_Index_Source_0963,
    mrkit_floatingLeg_inflationRateCalculation_Inflation_Rate_Interpolation_Method_0963,
    mrkit_floatingLeg_inflationRateCalculation_Inflation_Rate_Level_0963,
    mrkit_floatingLeg_inflationRateCalculation_DayCountFraction_0963,
    mrkit_floatingLeg_inflationRateCalculation_Spread_0963,
    mrkit_payment_Payer_0963,
    mrkit_payment_Receiver_0963,
    mrkit_payment_Payment_Amount_0963,
    mrkit_payment_Payment_Currency_0963,
    mrkit_payment_Payment_Date_0963,
    mrkit_payment_Payment_Day_Business_Day_Convention_0963,
    mrkit_payment_Payment_Day_Business_Day_0963,
    mrkit_payment_Reason_0963,
    mrkit_exchange_Client_Clearing_0963,
    mrkit_exchange_Bilateral_Clearing_House_0963,
    mrkit_swStructuredTradeDetails_Party_A_Alocation_ID_0963,
    mrkit_swStructuredTradeDetails_Party_A_Alocation_Name_0963,
    mrkit_swStructuredTradeDetails_Party_B_Alocation_ID_0963,
    mrkit_swStructuredTradeDetails_Party_B_Alocation_Name_0963,
    cod_instc_ipc_0963,
    cod_instc_ctpt_0963,
    cod_instc_moe_pta_fix_0963,
    cod_instc_moe_pta_flu_0963,
    cod_instc_indx_0963,
    cod_instc_moe_upfront_0963,
    ind_sit_0963,
    dat_cdm_0963,
    usr_cdm_0963,
    dat_sit_0963,
    usr_sit_0963,
    dat_ult_alt_0963,
    usr_ult_alt_0963)
SELECT 
	cod_instc_0963,
    header_Trade_ID_0963,
    header_Trade_Version_0963,
    header_Trade_Version_Timestamp_0963,
    header_Trade_Date_0963,
    header_Trade_Status_0963,
    header_Master_Agreement_Type_0963,
    header_Contractual_Definitions_0963,
    header_Party_A_0963,
    header_Party_B_0963,
    header_Product_Type_0963,
    header_Template_Name_0963,
    fixedLeg_Payer_0963,
    fixedLeg_Receiver_0963,
    fixedLeg_Effective_Date_0963,
    fixedLeg_Effective_Date_Adjustments_0963,
    fixedLeg_Termination_Date_0963,
    fixedLeg_Termination_Date_Adjustments_0963,
    fixedLeg_Calculation_Period_Dates_Adjustments_0963,
    fixedLeg_Calculation_Period_Frequency_Multiplier_0963,
    fixedLeg_Calculation_Period_Frequency_0963,
    fixedLeg_Calculation_Period_Frequency_Roll_Convention_0963,
    fixedLeg_Payment_Frequency_Period_Multiplier_0963,
    fixedLeg_Payment_Frequency_Period_0963,
    fixedLeg_Payment_Dates_PayRelativeTo_0963,
    fixedLeg_Payment_Dates_Business_Convention_0963,
    fixedLeg_Payment_Dates_Business_Convention_Business_Centers_0963,
    fixedLeg_Payments_Day_Offset_Multiplier_0963,
    fixedLeg_Payments_Day_Offset_Period_0963,
    fixedLeg_Payments_Day_Offset_Day_Type_0963,
    fixedLeg_Notional_Amount_0963,
    fixedLeg_Notional_Amount_Currency_0963,
    fixedLeg_Fixed_Rate_0963,
    fixedLeg_Fixed_Rate_Day_Count_Fraction_0963,
    fixedLeg_CashFlows_Match_Parameters_0963,
    fixedLeg_CashFlows_Payment_Unadjusted_Payment_Date_0963,
    fixedLeg_CashFlows_Payment_Fixed_Payment_Amount_0963,
    floatingLeg_Payer_0963,
    floatingLeg_Receiver_0963,
    floatingLeg_Effective_Date_0963,
    floatingLeg_Effective_Date_Adjustments_0963,
    floatingLeg_Termination_Date_0963,
    floatingLeg_Termination_Date_Adjustments_0963,
    floatingLeg_Calculation_Period_Dates_Adjustments_0963,
    floatingLeg_Calculation_Period_Frequency_Multiplier_0963,
    floatingLeg_Calculation_Period_Frequency_0963,
    floatingLeg_Calculation_Period_Frequency_Roll_Convention_0963,
    floatingLeg_Payment_Frequency_Period_Multiplier_0963,
    floatingLeg_Payment_Frequency_Period_0963,
    floatingLeg_Payment_Dates_PayRelativeTo_0963,
    floatingLeg_Payment_Dates_Business_Convention_0963,
    floatingLeg_Payment_Dates_Business_Convention_Business_Centers_0963,
    floatingLeg_Payments_Day_Offset_Multiplier_0963,
    floatingLeg_Payments_Day_Offset_Period_0963,
    floatingLeg_Payments_Day_Offset_Day_Type_0963,
    floatingLeg_Fixing_Reset_Related_To_0963,
    floatingLeg_Fixing_Dates_Multiplier_0963,
    floatingLeg_Fixing_Dates_Period_0963,
    floatingLeg_Fixing_Day_Convention_0963,
    floatingLeg_Fixing_Day_Business_Center_0963,
    floatingLeg_Reset_Frequency_Multiplier_0963,
    floatingLeg_Reset_Frequency_Period_0963,
    floatingLeg_Reset_Date_Adjustment_0963,
    floatingLeg_Reset_Date_Business_Center_0963,
    floatingLeg_Notional_Amount_0963,
    floatingLeg_Notional_Amount_Currency_0963,
    floatingLeg_floatingRateCalculation_Index_0963,
    floatingLeg_floatingRateCalculation_Index_Frequency_Multiplier_0963,
    floatingLeg_floatingRateCalculation_Index_Frequency_Period_0963,
    floatingLeg_floatingRateCalculation_Index_Source_0963,
    floatingLeg_floatingRateCalculation_Inflation_Rate_Interpolation_Method_0963,
    floatingLeg_floatingRateCalculation_Inflation_Rate_Level_0963,
    floatingLeg_floatingRateCalculation_DayCountFraction_0963,
    floatingLeg_floatingRateCalculation_Spread_0963,
    floatingLeg_inflationRateCalculation_Index_0963,
    floatingLeg_inflationRateCalculation_Index_Frequency_Multiplier_0963,
    floatingLeg_inflationRateCalculation_Index_Frequency_Period_0963,
    floatingLeg_inflationRateCalculation_Index_Source_0963,
    floatingLeg_inflationRateCalculation_Inflation_Rate_Interpolation_Method_0963,
    floatingLeg_inflationRateCalculation_Inflation_Rate_Level_0963,
    floatingLeg_inflationRateCalculation_DayCountFraction_0963,
    floatingLeg_inflationRateCalculation_Spread_0963,
    payment_Payer_0963,
    payment_Receiver_0963,
    payment_Payment_Amount_0963,
    payment_Payment_Currency_0963,
    payment_Payment_Date_0963,
    payment_Payment_Day_Business_Day_Convention_0963,
    payment_Payment_Day_Business_Day_0963,
    payment_Reason_0963,
    exchange_Client_Clearing_0963,
    exchange_Bilateral_Clearing_House_0963,
    swStructuredTradeDetails_Party_A_Alocation_ID_0963,
    swStructuredTradeDetails_Party_A_Alocation_Name_0963,
    swStructuredTradeDetails_Party_B_Alocation_ID_0963,
    swStructuredTradeDetails_Party_B_Alocation_Name_0963,
    cod_instc_ipc_0963,
    cod_instc_ctpt_0963,
    cod_instc_moe_pta_fix_0963,
    cod_instc_moe_pta_flu_0963,
    cod_instc_indx_0963,
    cod_instc_moe_upfront_0963,
    ind_sit_0963,
    dat_cdm_0963,
    usr_cdm_0963,
    dat_sit_0963,
    usr_sit_0963,
    dat_ult_alt_0963,
    usr_ult_alt_0963 
FROM
	dd_mrkit_temp_0963

SET IDENTITY_INSERT bd_106_bbmfront.dbo.dd_mrkit_irs_temp_0963 OFF
GO  


/************************************************************
	copiando dados das tabelas antigas -dd_mrkit_irs_0964
************************************************************/
GO  

SET IDENTITY_INSERT bd_106_bbmfront.dbo.dd_mrkit_irs_0964 ON

INSERT INTO
	dd_mrkit_irs_0964
(cod_instc_0964,
    mrkit_header_Trade_ID_0964,
    mrkit_header_Trade_Version_0964,
    mrkit_header_Trade_Version_Timestamp_0964,
    mrkit_header_Trade_Date_0964,
    mrkit_header_Trade_Status_0964,
    mrkit_header_Master_Agreement_Type_0964,
    mrkit_header_Contractual_Definitions_0964,
    mrkit_header_Party_A_0964,
    mrkit_header_Party_B_0964,
    mrkit_header_Product_Type_0964,
    mrkit_header_Template_Name_0964,
    mrkit_fixedLeg_Payer_0964,
    mrkit_fixedLeg_Receiver_0964,
    mrkit_fixedLeg_Effective_Date_0964,
    mrkit_fixedLeg_Effective_Date_Adjustments_0964,
    mrkit_fixedLeg_Termination_Date_0964,
    mrkit_fixedLeg_Termination_Date_Adjustments_0964,
    mrkit_fixedLeg_Calculation_Period_Dates_Adjustments_0964,
    mrkit_fixedLeg_Calculation_Period_Frequency_Multiplier_0964,
    mrkit_fixedLeg_Calculation_Period_Frequency_0964,
    mrkit_fixedLeg_Calculation_Period_Frequency_Roll_Convention_0964,
    mrkit_fixedLeg_Payment_Frequency_Period_Multiplier_0964,
    mrkit_fixedLeg_Payment_Frequency_Period_0964,
    mrkit_fixedLeg_Payment_Dates_PayRelativeTo_0964,
    mrkit_fixedLeg_Payment_Dates_Business_Convention_0964,
    mrkit_fixedLeg_Payment_Dates_Business_Convention_Business_Centers_0964,
    mrkit_fixedLeg_Payments_Day_Offset_Multiplier_0964,
    mrkit_fixedLeg_Payments_Day_Offset_Period_0964,
    mrkit_fixedLeg_Payments_Day_Offset_Day_Type_0964,
    mrkit_fixedLeg_Notional_Amount_0964,
    mrkit_fixedLeg_Notional_Amount_Currency_0964,
    mrkit_fixedLeg_Fixed_Rate_0964,
    mrkit_fixedLeg_Fixed_Rate_Day_Count_Fraction_0964,
    mrkit_fixedLeg_CashFlows_Match_Parameters_0964,
    mrkit_fixedLeg_CashFlows_Payment_Unadjusted_Payment_Date_0964,
    mrkit_fixedLeg_CashFlows_Payment_Fixed_Payment_Amount_0964,
    mrkit_floatingLeg_Payer_0964,
    mrkit_floatingLeg_Receiver_0964,
    mrkit_floatingLeg_Effective_Date_0964,
    mrkit_floatingLeg_Effective_Date_Adjustments_0964,
    mrkit_floatingLeg_Termination_Date_0964,
    mrkit_floatingLeg_Termination_Date_Adjustments_0964,
    mrkit_floatingLeg_Calculation_Period_Dates_Adjustments_0964,
    mrkit_floatingLeg_Calculation_Period_Frequency_Multiplier_0964,
    mrkit_floatingLeg_Calculation_Period_Frequency_0964,
    mrkit_floatingLeg_Calculation_Period_Frequency_Roll_Convention_0964,
    mrkit_floatingLeg_Payment_Frequency_Period_Multiplier_0964,
    mrkit_floatingLeg_Payment_Frequency_Period_0964,
    mrkit_floatingLeg_Payment_Dates_PayRelativeTo_0964,
    mrkit_floatingLeg_Payment_Dates_Business_Convention_0964,
    mrkit_floatingLeg_Payment_Dates_Business_Convention_Business_Centers_0964,
    mrkit_floatingLeg_Payments_Day_Offset_Multiplier_0964,
    mrkit_floatingLeg_Payments_Day_Offset_Period_0964,
    mrkit_floatingLeg_Payments_Day_Offset_Day_Type_0964,
    mrkit_floatingLeg_Fixing_Reset_Related_To_0964,
    mrkit_floatingLeg_Fixing_Dates_Multiplier_0964,
    mrkit_floatingLeg_Fixing_Dates_Period_0964,
    mrkit_floatingLeg_Fixing_Day_Convention_0964,
    mrkit_floatingLeg_Fixing_Day_Business_Center_0964,
    mrkit_floatingLeg_Reset_Frequency_Multiplier_0964,
    mrkit_floatingLeg_Reset_Frequency_Period_0964,
    mrkit_floatingLeg_Reset_Date_Adjustment_0964,
    mrkit_floatingLeg_Reset_Date_Business_Center_0964,
    mrkit_floatingLeg_Notional_Amount_0964,
    mrkit_floatingLeg_Notional_Amount_Currency_0964,
    mrkit_floatingLeg_floatingRateCalculation_Index_0964,
    mrkit_floatingLeg_floatingRateCalculation_Index_Frequency_Multiplier_0964,
    mrkit_floatingLeg_floatingRateCalculation_Index_Frequency_Period_0964,
    mrkit_floatingLeg_floatingRateCalculation_Index_Source_0964,
    mrkit_floatingLeg_floatingRateCalculation_Inflation_Rate_Interpolation_Method_0964,
    mrkit_floatingLeg_floatingRateCalculation_Inflation_Rate_Level_0964,
    mrkit_floatingLeg_floatingRateCalculation_DayCountFraction_0964,
    mrkit_floatingLeg_floatingRateCalculation_Spread_0964,
    mrkit_floatingLeg_inflationRateCalculation_Index_0964,
    mrkit_floatingLeg_inflationRateCalculation_Index_Frequency_Multiplier_0964,
    mrkit_floatingLeg_inflationRateCalculation_Index_Frequency_Period_0964,
    mrkit_floatingLeg_inflationRateCalculation_Index_Source_0964,
    mrkit_floatingLeg_inflationRateCalculation_Inflation_Rate_Interpolation_Method_0964,
    mrkit_floatingLeg_inflationRateCalculation_Inflation_Rate_Level_0964,
    mrkit_floatingLeg_inflationRateCalculation_DayCountFraction_0964,
    mrkit_floatingLeg_inflationRateCalculation_Spread_0964,
    mrkit_payment_Payer_0964,
    mrkit_payment_Receiver_0964,
    mrkit_payment_Payment_Amount_0964,
    mrkit_payment_Payment_Currency_0964,
    mrkit_payment_Payment_Date_0964,
    mrkit_payment_Payment_Day_Business_Day_Convention_0964,
    mrkit_payment_Payment_Day_Business_Day_0964,
    mrkit_payment_Reason_0964,
    mrkit_exchange_Client_Clearing_0964,
    mrkit_exchange_Bilateral_Clearing_House_0964,
    mrkit_swStructuredTradeDetails_Party_A_Alocation_ID_0964,
    mrkit_swStructuredTradeDetails_Party_A_Alocation_Name_0964,
    mrkit_swStructuredTradeDetails_Party_B_Alocation_ID_0964,
    mrkit_swStructuredTradeDetails_Party_B_Alocation_Name_0964,
    cod_instc_ipc_0964,
    cod_instc_ctpt_0964,
    cod_instc_moe_pta_fix_0964,
    cod_instc_moe_pta_flu_0964,
    cod_instc_indx_0964,
    cod_instc_moe_upfront_0964,
    ind_sit_0964,
    dat_cdm_0964,
    usr_cdm_0964,
    dat_sit_0964,
    usr_sit_0964,
    dat_ult_alt_0964,
    usr_ult_alt_0964)
SELECT 
	cod_instc_0964,
    header_Trade_ID_0964,
    header_Trade_Version_0964,
    header_Trade_Version_Timestamp_0964,
    header_Trade_Date_0964,
    header_Trade_Status_0964,
    header_Master_Agreement_Type_0964,
    header_Contractual_Definitions_0964,
    header_Party_A_0964,
    header_Party_B_0964,
    header_Product_Type_0964,
    header_Template_Name_0964,
    fixedLeg_Payer_0964,
    fixedLeg_Receiver_0964,
    fixedLeg_Effective_Date_0964,
    fixedLeg_Effective_Date_Adjustments_0964,
    fixedLeg_Termination_Date_0964,
    fixedLeg_Termination_Date_Adjustments_0964,
    fixedLeg_Calculation_Period_Dates_Adjustments_0964,
    fixedLeg_Calculation_Period_Frequency_Multiplier_0964,
    fixedLeg_Calculation_Period_Frequency_0964,
    fixedLeg_Calculation_Period_Frequency_Roll_Convention_0964,
    fixedLeg_Payment_Frequency_Period_Multiplier_0964,
    fixedLeg_Payment_Frequency_Period_0964,
    fixedLeg_Payment_Dates_PayRelativeTo_0964,
    fixedLeg_Payment_Dates_Business_Convention_0964,
    fixedLeg_Payment_Dates_Business_Convention_Business_Centers_0964,
    fixedLeg_Payments_Day_Offset_Multiplier_0964,
    fixedLeg_Payments_Day_Offset_Period_0964,
    fixedLeg_Payments_Day_Offset_Day_Type_0964,
    fixedLeg_Notional_Amount_0964,
    fixedLeg_Notional_Amount_Currency_0964,
    fixedLeg_Fixed_Rate_0964,
    fixedLeg_Fixed_Rate_Day_Count_Fraction_0964,
    fixedLeg_CashFlows_Match_Parameters_0964,
    fixedLeg_CashFlows_Payment_Unadjusted_Payment_Date_0964,
    fixedLeg_CashFlows_Payment_Fixed_Payment_Amount_0964,
    floatingLeg_Payer_0964,
    floatingLeg_Receiver_0964,
    floatingLeg_Effective_Date_0964,
    floatingLeg_Effective_Date_Adjustments_0964,
    floatingLeg_Termination_Date_0964,
    floatingLeg_Termination_Date_Adjustments_0964,
    floatingLeg_Calculation_Period_Dates_Adjustments_0964,
    floatingLeg_Calculation_Period_Frequency_Multiplier_0964,
    floatingLeg_Calculation_Period_Frequency_0964,
    floatingLeg_Calculation_Period_Frequency_Roll_Convention_0964,
    floatingLeg_Payment_Frequency_Period_Multiplier_0964,
    floatingLeg_Payment_Frequency_Period_0964,
    floatingLeg_Payment_Dates_PayRelativeTo_0964,
    floatingLeg_Payment_Dates_Business_Convention_0964,
    floatingLeg_Payment_Dates_Business_Convention_Business_Centers_0964,
    floatingLeg_Payments_Day_Offset_Multiplier_0964,
    floatingLeg_Payments_Day_Offset_Period_0964,
    floatingLeg_Payments_Day_Offset_Day_Type_0964,
    floatingLeg_Fixing_Reset_Related_To_0964,
    floatingLeg_Fixing_Dates_Multiplier_0964,
    floatingLeg_Fixing_Dates_Period_0964,
    floatingLeg_Fixing_Day_Convention_0964,
    floatingLeg_Fixing_Day_Business_Center_0964,
    floatingLeg_Reset_Frequency_Multiplier_0964,
    floatingLeg_Reset_Frequency_Period_0964,
    floatingLeg_Reset_Date_Adjustment_0964,
    floatingLeg_Reset_Date_Business_Center_0964,
    floatingLeg_Notional_Amount_0964,
    floatingLeg_Notional_Amount_Currency_0964,
    floatingLeg_floatingRateCalculation_Index_0964,
    floatingLeg_floatingRateCalculation_Index_Frequency_Multiplier_0964,
    floatingLeg_floatingRateCalculation_Index_Frequency_Period_0964,
    floatingLeg_floatingRateCalculation_Index_Source_0964,
    floatingLeg_floatingRateCalculation_Inflation_Rate_Interpolation_Method_0964,
    floatingLeg_floatingRateCalculation_Inflation_Rate_Level_0964,
    floatingLeg_floatingRateCalculation_DayCountFraction_0964,
    floatingLeg_floatingRateCalculation_Spread_0964,
    floatingLeg_inflationRateCalculation_Index_0964,
    floatingLeg_inflationRateCalculation_Index_Frequency_Multiplier_0964,
    floatingLeg_inflationRateCalculation_Index_Frequency_Period_0964,
    floatingLeg_inflationRateCalculation_Index_Source_0964,
    floatingLeg_inflationRateCalculation_Inflation_Rate_Interpolation_Method_0964,
    floatingLeg_inflationRateCalculation_Inflation_Rate_Level_0964,
    floatingLeg_inflationRateCalculation_DayCountFraction_0964,
    floatingLeg_inflationRateCalculation_Spread_0964,
    payment_Payer_0964,
    payment_Receiver_0964,
    payment_Payment_Amount_0964,
    payment_Payment_Currency_0964,
    payment_Payment_Date_0964,
    payment_Payment_Day_Business_Day_Convention_0964,
    payment_Payment_Day_Business_Day_0964,
    payment_Reason_0964,
    exchange_Client_Clearing_0964,
    exchange_Bilateral_Clearing_House_0964,
    swStructuredTradeDetails_Party_A_Alocation_ID_0964,
    swStructuredTradeDetails_Party_A_Alocation_Name_0964,
    swStructuredTradeDetails_Party_B_Alocation_ID_0964,
    swStructuredTradeDetails_Party_B_Alocation_Name_0964,
    cod_instc_ipc_0964,
    cod_instc_ctpt_0964,
    cod_instc_moe_pta_fix_0964,
    cod_instc_moe_pta_flu_0964,
    cod_instc_indx_0964,
    cod_instc_moe_upfront_0964,
    ind_sit_0964,
    dat_cdm_0964,
    usr_cdm_0964,
    dat_sit_0964,
    usr_sit_0964,
    dat_ult_alt_0964,
    usr_ult_alt_0964 
FROM
	dd_mrkit_0964

SET IDENTITY_INSERT bd_106_bbmfront.dbo.dd_mrkit_irs_0964 OFF
GO  



/************************************************************
	dropando tabelas antigas
************************************************************/

--DROP TABLE dd_mrkit_temp_0963
--DROP TABLE dd_mrkit_0964