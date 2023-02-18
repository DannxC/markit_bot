USE bd_106_bbmfront

--use bd_106_bbmfront
--DROP TABLE ctrl_ipc_mrkit_0962
--DROP TABLE dd_mrkit_temp_0963
--DROP TABLE dd_mrkit_0964

CREATE TABLE ctrl_ipc_mrkit_0962
(
    cod_instc_0962           int IDENTITY(1,1) PRIMARY KEY		-- chave primária, ela se auto-incrementa

	,dat_ipc_0962				 Date

    -- Controle de versao da tabela

    ,ind_sit_0962                int

    ,dat_cdm_0962                DateTime
    ,usr_cdm_0962                VarChar(256)

    ,dat_sit_0962                DateTime
    ,usr_sit_0962                VarChar(256)

    ,dat_ult_alt_0962            DateTime
    ,usr_ult_alt_0962            VarChar(256)
)

CREATE TABLE dd_mrkit_temp_0963
(
	-- codInstc provindo da tabela de controle.

     cod_instc_0963					int IDENTITY(1,1) PRIMARY KEY		-- chave primária, ela se auto-incrementa


	-- Principais dados
	
	-- Header
	,header_Trade_ID_0963																		bigint
	,header_Trade_Version_0963																	bigint
	,header_Trade_Version_Timestamp_0963														DateTime
	,header_Trade_Date_0963																		date
	,header_Trade_Status_0963																	varchar(200)
	,header_Master_Agreement_Type_0963															varchar(200)
	,header_Contractual_Definitions_0963														varchar(200)
	,header_Party_A_0963																		varchar(200)
	,header_Party_B_0963																		varchar(200)
	,header_Product_Type_0963																	varchar(200)
	,header_Template_Name_0963																	varchar(200)

	-- Fixed Leg
	,fixedLeg_Payer_0963																		varchar(200)
	,fixedLeg_Receiver_0963																		varchar(200)
	,fixedLeg_Effective_Date_0963																date
	,fixedLeg_Effective_Date_Adjustments_0963													varchar(200)
	,fixedLeg_Termination_Date_0963																date
	,fixedLeg_Termination_Date_Adjustments_0963													varchar(200)
	,fixedLeg_Calculation_Period_Dates_Adjustments_0963											varchar(200)
	,fixedLeg_Calculation_Period_Frequency_Multiplier_0963										bigint
	,fixedLeg_Calculation_Period_Frequency_0963													varchar(200)
	,fixedLeg_Calculation_Period_Frequency_Roll_Convention_0963									varchar(200)
	,fixedLeg_Payment_Frequency_Period_Multiplier_0963											bigint
	,fixedLeg_Payment_Frequency_Period_0963														varchar(200)
	,fixedLeg_Payment_Dates_PayRelativeTo_0963													varchar(200)
	,fixedLeg_Payment_Dates_Business_Convention_0963											varchar(200)
	,fixedLeg_Payment_Dates_Business_Convention_Business_Centers_0963							varchar(200)
	,fixedLeg_Payments_Day_Offset_Multiplier_0963												bigint
	,fixedLeg_Payments_Day_Offset_Period_0963													varchar(200)
	,fixedLeg_Payments_Day_Offset_Day_Type_0963													varchar(200)
	,fixedLeg_Notional_Amount_0963																bigint
	,fixedLeg_Notional_Amount_Currency_0963														varchar(200)
	,fixedLeg_Fixed_Rate_0963																	float
	,fixedLeg_Fixed_Rate_Day_Count_Fraction_0963												varchar(200)
	,fixedLeg_CashFlows_Match_Parameters_0963													bit
	,fixedLeg_CashFlows_Payment_Unadjusted_Payment_Date_0963									date
	,fixedLeg_CashFlows_Payment_Fixed_Payment_Amount_0963										float

	-- Floating Leg
	,floatingLeg_Payer_0963																		varchar(200)
	,floatingLeg_Receiver_0963																	varchar(200)
	,floatingLeg_Effective_Date_0963															date
	,floatingLeg_Effective_Date_Adjustments_0963												varchar(200)
	,floatingLeg_Termination_Date_0963															date
	,floatingLeg_Termination_Date_Adjustments_0963												varchar(200)
	,floatingLeg_Calculation_Period_Dates_Adjustments_0963										varchar(200)
	,floatingLeg_Calculation_Period_Frequency_Multiplier_0963									bigint
	,floatingLeg_Calculation_Period_Frequency_0963												varchar(200)
	,floatingLeg_Calculation_Period_Frequency_Roll_Convention_0963								varchar(200)
	,floatingLeg_Payment_Frequency_Period_Multiplier_0963										bigint
	,floatingLeg_Payment_Frequency_Period_0963													varchar(200)
	,floatingLeg_Payment_Dates_PayRelativeTo_0963												varchar(200)
	,floatingLeg_Payment_Dates_Business_Convention_0963											varchar(200)
	,floatingLeg_Payment_Dates_Business_Convention_Business_Centers_0963						varchar(200)
	,floatingLeg_Payments_Day_Offset_Multiplier_0963											bigint
	,floatingLeg_Payments_Day_Offset_Period_0963												varchar(200)
	,floatingLeg_Payments_Day_Offset_Day_Type_0963												varchar(200)
	,floatingLeg_Fixing_Reset_Related_To_0963													varchar(200)
	,floatingLeg_Fixing_Dates_Multiplier_0963													bigint
	,floatingLeg_Fixing_Dates_Period_0963														varchar(200)
	,floatingLeg_Fixing_Day_Convention_0963														varchar(200)
	,floatingLeg_Fixing_Day_Business_Center_0963												varchar(200)
	,floatingLeg_Reset_Frequency_Multiplier_0963												bigint
	,floatingLeg_Reset_Frequency_Period_0963													varchar(200)
	,floatingLeg_Reset_Date_Adjustment_0963														varchar(200)
	,floatingLeg_Reset_Date_Business_Center_0963												varchar(200)
	,floatingLeg_Notional_Amount_0963															bigint
	,floatingLeg_Notional_Amount_Currency_0963													varchar(200)
	-- tipo 1 - Produto = "SingleCurrencyInterestRateSwap" ou "OIS"
	,floatingLeg_floatingRateCalculation_Index_0963												varchar(200)
	,floatingLeg_floatingRateCalculation_Index_Frequency_Multiplier_0963						bigint
	,floatingLeg_floatingRateCalculation_Index_Frequency_Period_0963							varchar(200)
	,floatingLeg_floatingRateCalculation_Index_Source_0963										varchar(200)
	,floatingLeg_floatingRateCalculation_Inflation_Rate_Interpolation_Method_0963				varchar(200)
	,floatingLeg_floatingRateCalculation_Inflation_Rate_Level_0963								float
	,floatingLeg_floatingRateCalculation_DayCountFraction_0963									varchar(200)
	,floatingLeg_floatingRateCalculation_Spread_0963											float
	-- tipo 2 - Produto = "ZC Inflation"
	,floatingLeg_inflationRateCalculation_Index_0963											varchar(200)
	,floatingLeg_inflationRateCalculation_Index_Frequency_Multiplier_0963						bigint
	,floatingLeg_inflationRateCalculation_Index_Frequency_Period_0963							varchar(200)
	,floatingLeg_inflationRateCalculation_Index_Source_0963										varchar(200)
	,floatingLeg_inflationRateCalculation_Inflation_Rate_Interpolation_Method_0963				varchar(200)
	,floatingLeg_inflationRateCalculation_Inflation_Rate_Level_0963								float
	,floatingLeg_inflationRateCalculation_DayCountFraction_0963									varchar(200)
	,floatingLeg_inflationRateCalculation_Spread_0963											float

	-- Payment
	,payment_Payer_0963																			varchar(200)
	,payment_Receiver_0963																		varchar(200)
	,payment_Payment_Amount_0963																float
	,payment_Payment_Currency_0963																varchar(200)
	,payment_Payment_Date_0963																	date
	,payment_Payment_Day_Business_Day_Convention_0963											varchar(200)
	,payment_Payment_Day_Business_Day_0963														varchar(200)
	,payment_Reason_0963																		varchar(200)

	-- Exchange
	,exchange_Client_Clearing_0963																bit
	,exchange_Bilateral_Clearing_House_0963														varchar(200)

	-- swStructuredTradeDetails
	,swStructuredTradeDetails_Party_A_Alocation_ID_0963											varchar(200)
	,swStructuredTradeDetails_Party_A_Alocation_Name_0963										varchar(200)
	,swStructuredTradeDetails_Party_B_Alocation_ID_0963											varchar(200)
	,swStructuredTradeDetails_Party_B_Alocation_Name_0963										varchar(200)


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



CREATE TABLE dd_mrkit_0964
(
	-- codInstc provindo da tabela de controle.
     cod_instc_0964					int IDENTITY(1,1) PRIMARY KEY		-- chave primária, ela se auto-incrementa


	-- Principais dados
	
	-- Header
	,header_Trade_ID_0964																		bigint
	,header_Trade_Version_0964																	bigint
	,header_Trade_Version_Timestamp_0964														DateTime
	,header_Trade_Date_0964																		date
	,header_Trade_Status_0964																	varchar(200)
	,header_Master_Agreement_Type_0964															varchar(200)
	,header_Contractual_Definitions_0964														varchar(200)
	,header_Party_A_0964																		varchar(200)
	,header_Party_B_0964																		varchar(200)
	,header_Product_Type_0964																	varchar(200)
	,header_Template_Name_0964																	varchar(200)

	-- Fixed Leg
	,fixedLeg_Payer_0964																		varchar(200)
	,fixedLeg_Receiver_0964																		varchar(200)
	,fixedLeg_Effective_Date_0964																date
	,fixedLeg_Effective_Date_Adjustments_0964													varchar(200)
	,fixedLeg_Termination_Date_0964																date
	,fixedLeg_Termination_Date_Adjustments_0964													varchar(200)
	,fixedLeg_Calculation_Period_Dates_Adjustments_0964											varchar(200)
	,fixedLeg_Calculation_Period_Frequency_Multiplier_0964										bigint
	,fixedLeg_Calculation_Period_Frequency_0964													varchar(200)
	,fixedLeg_Calculation_Period_Frequency_Roll_Convention_0964									varchar(200)
	,fixedLeg_Payment_Frequency_Period_Multiplier_0964											bigint
	,fixedLeg_Payment_Frequency_Period_0964														varchar(200)
	,fixedLeg_Payment_Dates_PayRelativeTo_0964													varchar(200)
	,fixedLeg_Payment_Dates_Business_Convention_0964											varchar(200)
	,fixedLeg_Payment_Dates_Business_Convention_Business_Centers_0964							varchar(200)
	,fixedLeg_Payments_Day_Offset_Multiplier_0964												bigint
	,fixedLeg_Payments_Day_Offset_Period_0964													varchar(200)
	,fixedLeg_Payments_Day_Offset_Day_Type_0964													varchar(200)
	,fixedLeg_Notional_Amount_0964																bigint
	,fixedLeg_Notional_Amount_Currency_0964														varchar(200)
	,fixedLeg_Fixed_Rate_0964																	float
	,fixedLeg_Fixed_Rate_Day_Count_Fraction_0964												varchar(200)
	,fixedLeg_CashFlows_Match_Parameters_0964													bit
	,fixedLeg_CashFlows_Payment_Unadjusted_Payment_Date_0964									date
	,fixedLeg_CashFlows_Payment_Fixed_Payment_Amount_0964										float

	-- Floating Leg
	,floatingLeg_Payer_0964																		varchar(200)
	,floatingLeg_Receiver_0964																	varchar(200)
	,floatingLeg_Effective_Date_0964															date
	,floatingLeg_Effective_Date_Adjustments_0964												varchar(200)
	,floatingLeg_Termination_Date_0964															date
	,floatingLeg_Termination_Date_Adjustments_0964												varchar(200)
	,floatingLeg_Calculation_Period_Dates_Adjustments_0964										varchar(200)
	,floatingLeg_Calculation_Period_Frequency_Multiplier_0964									bigint
	,floatingLeg_Calculation_Period_Frequency_0964												varchar(200)
	,floatingLeg_Calculation_Period_Frequency_Roll_Convention_0964								varchar(200)
	,floatingLeg_Payment_Frequency_Period_Multiplier_0964										bigint
	,floatingLeg_Payment_Frequency_Period_0964													varchar(200)
	,floatingLeg_Payment_Dates_PayRelativeTo_0964												varchar(200)
	,floatingLeg_Payment_Dates_Business_Convention_0964											varchar(200)
	,floatingLeg_Payment_Dates_Business_Convention_Business_Centers_0964						varchar(200)
	,floatingLeg_Payments_Day_Offset_Multiplier_0964											bigint
	,floatingLeg_Payments_Day_Offset_Period_0964												varchar(200)
	,floatingLeg_Payments_Day_Offset_Day_Type_0964												varchar(200)
	,floatingLeg_Fixing_Reset_Related_To_0964													varchar(200)
	,floatingLeg_Fixing_Dates_Multiplier_0964													bigint
	,floatingLeg_Fixing_Dates_Period_0964														varchar(200)
	,floatingLeg_Fixing_Day_Convention_0964														varchar(200)
	,floatingLeg_Fixing_Day_Business_Center_0964												varchar(200)
	,floatingLeg_Reset_Frequency_Multiplier_0964												bigint
	,floatingLeg_Reset_Frequency_Period_0964													varchar(200)
	,floatingLeg_Reset_Date_Adjustment_0964														varchar(200)
	,floatingLeg_Reset_Date_Business_Center_0964												varchar(200)
	,floatingLeg_Notional_Amount_0964															bigint
	,floatingLeg_Notional_Amount_Currency_0964													varchar(200)
	-- tipo 1 - Produto = "SingleCurrencyInterestRateSwap" ou "OIS"
	,floatingLeg_floatingRateCalculation_Index_0964												varchar(200)
	,floatingLeg_floatingRateCalculation_Index_Frequency_Multiplier_0964						bigint
	,floatingLeg_floatingRateCalculation_Index_Frequency_Period_0964							varchar(200)
	,floatingLeg_floatingRateCalculation_Index_Source_0964										varchar(200)
	,floatingLeg_floatingRateCalculation_Inflation_Rate_Interpolation_Method_0964				varchar(200)
	,floatingLeg_floatingRateCalculation_Inflation_Rate_Level_0964								float
	,floatingLeg_floatingRateCalculation_DayCountFraction_0964									varchar(200)
	,floatingLeg_floatingRateCalculation_Spread_0964											float
	-- tipo 2 - Produto = "ZC Inflation"
	,floatingLeg_inflationRateCalculation_Index_0964											varchar(200)
	,floatingLeg_inflationRateCalculation_Index_Frequency_Multiplier_0964						bigint
	,floatingLeg_inflationRateCalculation_Index_Frequency_Period_0964							varchar(200)
	,floatingLeg_inflationRateCalculation_Index_Source_0964										varchar(200)
	,floatingLeg_inflationRateCalculation_Inflation_Rate_Interpolation_Method_0964				varchar(200)
	,floatingLeg_inflationRateCalculation_Inflation_Rate_Level_0964								float
	,floatingLeg_inflationRateCalculation_DayCountFraction_0964									varchar(200)
	,floatingLeg_inflationRateCalculation_Spread_0964											float

	-- Payment
	,payment_Payer_0964																			varchar(200)
	,payment_Receiver_0964																		varchar(200)
	,payment_Payment_Amount_0964																float
	,payment_Payment_Currency_0964																varchar(200)
	,payment_Payment_Date_0964																	date
	,payment_Payment_Day_Business_Day_Convention_0964											varchar(200)
	,payment_Payment_Day_Business_Day_0964														varchar(200)
	,payment_Reason_0964																		varchar(200)

	-- Exchange
	,exchange_Client_Clearing_0964																bit
	,exchange_Bilateral_Clearing_House_0964														varchar(200)

	-- swStructuredTradeDetails
	,swStructuredTradeDetails_Party_A_Alocation_ID_0964											varchar(200)
	,swStructuredTradeDetails_Party_A_Alocation_Name_0964										varchar(200)
	,swStructuredTradeDetails_Party_B_Alocation_ID_0964											varchar(200)
	,swStructuredTradeDetails_Party_B_Alocation_Name_0964										varchar(200)


	-- Código de Instância da Importação
	,cod_instc_ipc_0964							int


	-- Dados Enriquecidos
	,cod_instc_ctpt_0964						int	
	,cod_instc_moe_pta_fix_0964					int
	,cod_instc_moe_pta_flu_0964					int
	,cod_instc_indx_0964						INT
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