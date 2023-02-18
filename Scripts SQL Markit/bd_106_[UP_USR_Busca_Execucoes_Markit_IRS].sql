USE bd_106_bbmfront
GO


/****** Object:  StoredProcedure [dbo].[UP_Processa_Dados_Markit]    Script Date: 19/01/2023 13:24:00 ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- obs: caso queira alterar a proc, basta trocar CREATE por ALTER

ALTER PROCEDURE [dbo].[UP_USR_Busca_Execucoes_Markit_IRS] (

	@data		SMALLDATETIME = null

)
AS 

SET @data = ISNULL(@data,GETDATE())
DECLARE @data_markit DATE = CAST(@data AS date)

SELECT
	 ctpt.desc_abvd_0030					AS Contraparte
	,moe_pas.cod_bbm_0042					AS Moeda_Ponta_Passiva
	,moe_atv.cod_bbm_0042					AS Moda_Ponta_Ativa
	,moe_upf.cod_bbm_0042					AS Moeda_Upfront
	,indx.desc_abvd_0174					AS Indexador
	

	,mrkit_header_Trade_ID_0964																		AS	header_Trade_ID																	
	,mrkit_header_Trade_Version_0964																AS	header_Trade_Version																
	,mrkit_header_Trade_Version_Timestamp_0964														AS	header_Trade_Version_Timestamp													
	,mrkit_header_Trade_Date_0964																	AS	header_Trade_Date																	
	,mrkit_header_Trade_Status_0964																	AS	header_Trade_Status																
	,mrkit_header_Master_Agreement_Type_0964														AS	header_Master_Agreement_Type														
	,mrkit_header_Contractual_Definitions_0964														AS	header_Contractual_Definitions													
	,mrkit_header_Party_A_0964																		AS	header_Party_A																	
	,mrkit_header_Party_B_0964																		AS	header_Party_B																	
	,mrkit_header_Product_Type_0964																	AS	header_Product_Type																
	,mrkit_header_Template_Name_0964																AS	header_Template_Name																
	,mrkit_fixedLeg_Payer_0964																		AS	fixedLeg_Payer																	
	,mrkit_fixedLeg_Receiver_0964																	AS	fixedLeg_Receiver																	
	,mrkit_fixedLeg_Effective_Date_0964																AS	fixedLeg_Effective_Date															
	,mrkit_fixedLeg_Effective_Date_Adjustments_0964													AS	fixedLeg_Effective_Date_Adjustments												
	,mrkit_fixedLeg_Termination_Date_0964															AS	fixedLeg_Termination_Date															
	,mrkit_fixedLeg_Termination_Date_Adjustments_0964												AS	fixedLeg_Termination_Date_Adjustments												
	,mrkit_fixedLeg_Calculation_Period_Dates_Adjustments_0964										AS	fixedLeg_Calculation_Period_Dates_Adjustments										
	,mrkit_fixedLeg_Calculation_Period_Frequency_Multiplier_0964									AS	fixedLeg_Calculation_Period_Frequency_Multiplier									
	,mrkit_fixedLeg_Calculation_Period_Frequency_0964												AS	fixedLeg_Calculation_Period_Frequency												
	,mrkit_fixedLeg_Calculation_Period_Frequency_Roll_Convention_0964								AS	fixedLeg_Calculation_Period_Frequency_Roll_Convention								
	,mrkit_fixedLeg_Payment_Frequency_Period_Multiplier_0964										AS	fixedLeg_Payment_Frequency_Period_Multiplier										
	,mrkit_fixedLeg_Payment_Frequency_Period_0964													AS	fixedLeg_Payment_Frequency_Period													
	,mrkit_fixedLeg_Payment_Dates_PayRelativeTo_0964												AS	fixedLeg_Payment_Dates_PayRelativeTo												
	,mrkit_fixedLeg_Payment_Dates_Business_Convention_0964											AS	fixedLeg_Payment_Dates_Business_Convention										
	,mrkit_fixedLeg_Payment_Dates_Business_Convention_Business_Centers_0964							AS	fixedLeg_Payment_Dates_Business_Convention_Business_Centers						
	,mrkit_fixedLeg_Payments_Day_Offset_Multiplier_0964												AS	fixedLeg_Payments_Day_Offset_Multiplier											
	,mrkit_fixedLeg_Payments_Day_Offset_Period_0964													AS	fixedLeg_Payments_Day_Offset_Period												
	,mrkit_fixedLeg_Payments_Day_Offset_Day_Type_0964												AS	fixedLeg_Payments_Day_Offset_Day_Type												
	,mrkit_fixedLeg_Notional_Amount_0964															AS	fixedLeg_Notional_Amount															
	,mrkit_fixedLeg_Notional_Amount_Currency_0964													AS	fixedLeg_Notional_Amount_Currency													
	,mrkit_fixedLeg_Fixed_Rate_0964																	AS	fixedLeg_Fixed_Rate																
	,mrkit_fixedLeg_Fixed_Rate_Day_Count_Fraction_0964												AS	fixedLeg_Fixed_Rate_Day_Count_Fraction											
	,mrkit_fixedLeg_CashFlows_Match_Parameters_0964													AS	fixedLeg_CashFlows_Match_Parameters												
	,mrkit_fixedLeg_CashFlows_Payment_Unadjusted_Payment_Date_0964									AS	fixedLeg_CashFlows_Payment_Unadjusted_Payment_Date								
	,mrkit_fixedLeg_CashFlows_Payment_Fixed_Payment_Amount_0964										AS	fixedLeg_CashFlows_Payment_Fixed_Payment_Amount									
	,mrkit_floatingLeg_Payer_0964																	AS	floatingLeg_Payer																	
	,mrkit_floatingLeg_Receiver_0964																AS	floatingLeg_Receiver																
	,mrkit_floatingLeg_Effective_Date_0964															AS	floatingLeg_Effective_Date														
	,mrkit_floatingLeg_Effective_Date_Adjustments_0964												AS	floatingLeg_Effective_Date_Adjustments											
	,mrkit_floatingLeg_Termination_Date_0964														AS	floatingLeg_Termination_Date														
	,mrkit_floatingLeg_Termination_Date_Adjustments_0964											AS	floatingLeg_Termination_Date_Adjustments											
	,mrkit_floatingLeg_Calculation_Period_Dates_Adjustments_0964									AS	floatingLeg_Calculation_Period_Dates_Adjustments									
	,mrkit_floatingLeg_Calculation_Period_Frequency_Multiplier_0964									AS	floatingLeg_Calculation_Period_Frequency_Multiplier								
	,mrkit_floatingLeg_Calculation_Period_Frequency_0964											AS	floatingLeg_Calculation_Period_Frequency											
	,mrkit_floatingLeg_Calculation_Period_Frequency_Roll_Convention_0964							AS	floatingLeg_Calculation_Period_Frequency_Roll_Convention							
	,mrkit_floatingLeg_Payment_Frequency_Period_Multiplier_0964										AS	floatingLeg_Payment_Frequency_Period_Multiplier									
	,mrkit_floatingLeg_Payment_Frequency_Period_0964												AS	floatingLeg_Payment_Frequency_Period												
	,mrkit_floatingLeg_Payment_Dates_PayRelativeTo_0964												AS	floatingLeg_Payment_Dates_PayRelativeTo											
	,mrkit_floatingLeg_Payment_Dates_Business_Convention_0964										AS	floatingLeg_Payment_Dates_Business_Convention										
	,mrkit_floatingLeg_Payment_Dates_Business_Convention_Business_Centers_0964						AS	floatingLeg_Payment_Dates_Business_Convention_Business_Centers					
	,mrkit_floatingLeg_Payments_Day_Offset_Multiplier_0964											AS	floatingLeg_Payments_Day_Offset_Multiplier										
	,mrkit_floatingLeg_Payments_Day_Offset_Period_0964												AS	floatingLeg_Payments_Day_Offset_Period											
	,mrkit_floatingLeg_Payments_Day_Offset_Day_Type_0964											AS	floatingLeg_Payments_Day_Offset_Day_Type											
	,mrkit_floatingLeg_Fixing_Reset_Related_To_0964													AS	floatingLeg_Fixing_Reset_Related_To												
	,mrkit_floatingLeg_Fixing_Dates_Multiplier_0964													AS	floatingLeg_Fixing_Dates_Multiplier												
	,mrkit_floatingLeg_Fixing_Dates_Period_0964														AS	floatingLeg_Fixing_Dates_Period													
	,mrkit_floatingLeg_Fixing_Day_Convention_0964													AS	floatingLeg_Fixing_Day_Convention													
	,mrkit_floatingLeg_Fixing_Day_Business_Center_0964												AS	floatingLeg_Fixing_Day_Business_Center											
	,mrkit_floatingLeg_Reset_Frequency_Multiplier_0964												AS	floatingLeg_Reset_Frequency_Multiplier											
	,mrkit_floatingLeg_Reset_Frequency_Period_0964													AS	floatingLeg_Reset_Frequency_Period												
	,mrkit_floatingLeg_Reset_Date_Adjustment_0964													AS	floatingLeg_Reset_Date_Adjustment													
	,mrkit_floatingLeg_Reset_Date_Business_Center_0964												AS	floatingLeg_Reset_Date_Business_Center											
	,mrkit_floatingLeg_Notional_Amount_0964															AS	floatingLeg_Notional_Amount														
	,mrkit_floatingLeg_Notional_Amount_Currency_0964												AS	floatingLeg_Notional_Amount_Currency												
	,mrkit_floatingLeg_floatingRateCalculation_Index_0964											AS	floatingLeg_floatingRateCalculation_Index											
	,mrkit_floatingLeg_floatingRateCalculation_Index_Frequency_Multiplier_0964						AS	floatingLeg_floatingRateCalculation_Index_Frequency_Multiplier					
	,mrkit_floatingLeg_floatingRateCalculation_Index_Frequency_Period_0964							AS	floatingLeg_floatingRateCalculation_Index_Frequency_Period						
	,mrkit_floatingLeg_floatingRateCalculation_Index_Source_0964									AS	floatingLeg_floatingRateCalculation_Index_Source									
	,mrkit_floatingLeg_floatingRateCalculation_Inflation_Rate_Interpolation_Method_0964				AS	floatingLeg_floatingRateCalculation_Inflation_Rate_Interpolation_Method			
	,mrkit_floatingLeg_floatingRateCalculation_Inflation_Rate_Level_0964							AS	floatingLeg_floatingRateCalculation_Inflation_Rate_Level							
	,mrkit_floatingLeg_floatingRateCalculation_DayCountFraction_0964								AS	floatingLeg_floatingRateCalculation_DayCountFraction								
	,mrkit_floatingLeg_floatingRateCalculation_Spread_0964											AS	floatingLeg_floatingRateCalculation_Spread										
	,mrkit_floatingLeg_inflationRateCalculation_Index_0964											AS	floatingLeg_inflationRateCalculation_Index										
	,mrkit_floatingLeg_inflationRateCalculation_Index_Frequency_Multiplier_0964						AS	floatingLeg_inflationRateCalculation_Index_Frequency_Multiplier					
	,mrkit_floatingLeg_inflationRateCalculation_Index_Frequency_Period_0964							AS	floatingLeg_inflationRateCalculation_Index_Frequency_Period						
	,mrkit_floatingLeg_inflationRateCalculation_Index_Source_0964									AS	floatingLeg_inflationRateCalculation_Index_Source									
	,mrkit_floatingLeg_inflationRateCalculation_Inflation_Rate_Interpolation_Method_0964			AS	floatingLeg_inflationRateCalculation_Inflation_Rate_Interpolation_Method			
	,mrkit_floatingLeg_inflationRateCalculation_Inflation_Rate_Level_0964							AS	floatingLeg_inflationRateCalculation_Inflation_Rate_Level							
	,mrkit_floatingLeg_inflationRateCalculation_DayCountFraction_0964								AS	floatingLeg_inflationRateCalculation_DayCountFraction								
	,mrkit_floatingLeg_inflationRateCalculation_Spread_0964											AS	floatingLeg_inflationRateCalculation_Spread										
	,mrkit_payment_Payer_0964																		AS	payment_Payer																		
	,mrkit_payment_Receiver_0964																	AS	payment_Receiver																	
	,mrkit_payment_Payment_Amount_0964																AS	payment_Payment_Amount															
	,mrkit_payment_Payment_Currency_0964															AS	payment_Payment_Currency															
	,mrkit_payment_Payment_Date_0964																AS	payment_Payment_Date																
	,mrkit_payment_Payment_Day_Business_Day_Convention_0964											AS	payment_Payment_Day_Business_Day_Convention										
	,mrkit_payment_Payment_Day_Business_Day_0964													AS	payment_Payment_Day_Business_Day													
	,mrkit_payment_Reason_0964							 											AS	payment_Reason
	,mrkit_exchange_Client_Clearing_0964															AS	exchange_Client_Clearing
	,mrkit_exchange_Bilateral_Clearing_House_0964													AS	exchange_Bilateral_Clearing_House
	,mrkit_swStructuredTradeDetails_Party_A_Alocation_ID_0964										AS	swStructuredTradeDetails_Party_A_Alocation_ID
	,mrkit_swStructuredTradeDetails_Party_A_Alocation_Name_0964										AS	swStructuredTradeDetails_Party_A_Alocation_Name
	,mrkit_swStructuredTradeDetails_Party_B_Alocation_ID_0964										AS	swStructuredTradeDetails_Party_B_Alocation_ID
	,mrkit_swStructuredTradeDetails_Party_B_Alocation_Name_0964										AS	swStructuredTradeDetails_Party_B_Alocation_Name
FROM
	bd_106_bbmfront.dbo.dd_mrkit_irs_0964 AS markit 
	LEFT JOIN
	bd_108_bbmcorp.dbo.itmd_0030 AS ctpt ON ctpt.cod_instc_0030 = markit.cod_instc_ctpt_0964
	LEFT JOIN
	bd_108_bbmcorp.dbo.v_moe_0042 AS moe_pas ON moe_pas.cod_instc_0042 = markit.cod_instc_moe_pta_fix_0964
	LEFT JOIN
	bd_108_bbmcorp.dbo.v_moe_0042 AS moe_atv ON moe_atv.cod_instc_0042 = markit.cod_instc_moe_pta_flu_0964
	LEFT JOIN
	bd_108_bbmcorp.dbo.v_moe_0042 AS moe_upf ON moe_upf.cod_instc_0042 = markit.cod_instc_moe_upfront_0964
	LEFT JOIN
	bd_108_bbmcorp.dbo.indx_0174 AS indx ON indx.cod_instc_0174 = markit.cod_instc_indx_0964
WHERE
		ind_sit_0964 = 1
	AND mrkit_header_Trade_Date_0964 = @data_markit


	