USE bd_106_bbmfront
GO


/****** Object:  StoredProcedure [dbo].[UP_Processa_Dados_Markit]    Script Date: 19/01/2023 13:24:00 ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[UP_USR_Busca_Batimento_Execucoes_Markit_IRS] (

	@data		SMALLDATETIME = null

)
AS 

SET @data = ISNULL(@data,GETDATE())
DECLARE @data_markit DATE = CAST(@data AS date)



/***********************************************************************************************************
	Dados das ordens                                              
***********************************************************************************************************/
DECLARE @STATUS_ABRT VARCHAR(10) = 'ABERTA'
DECLARE @STATUS_BLQ VARCHAR(10) = 'BLOQUEADA'

SELECT 
	-- Dados da Ordem
	 ord.cod_instc_0010																												AS Id_Ordem   
	,''																																AS Batido     
	,IIF(ctrl_apvd.cod_usr_stt_blq_0150 IS NOT NULL, @STATUS_BLQ, @STATUS_ABRT)														AS Bloqueio   -- se tem usr q bloqueou, a coluna mostra
	,atv.desc_abvd_0012																												AS Ativo      
	,fnd.desc_abvd_0019																												AS Fundo      
	,cstd.desc_abvd_0030																											AS Custodiante




	-- Dados do Batimento
	,CASE 
		WHEN	ctr.clrd_0163 = 1		THEN	'CLEARED' 
		ELSE	'BILATERAL' 
	 END																															AS Cleared          -- fala se o contrato tem "clearing" ou nao... (intermediario na venda)
	
	,ctr.merc_0163																													AS Mercado          -- bolsa em que está sendo tradado

	,ctpt.desc_abvd_0030																											AS Contraparte
	,ctpt.cod_instc_0030																											AS Instancia_Contraparte

	,cast(ord.dat_trd_0010 AS datetime)																								AS Data_Trade          

	,cast(atv.dat_abt_0012 as datetime)																								AS Data_Inicio          

	,cast(atv.dat_vnc_0012 as datetime)																								AS Data_Vencimento

	,IIF(indx_psv.desc_abvd_0174 = 'FIXA', indx_psv.desc_abvd_0174, indx_atv.desc_abvd_0174)										AS Ponta_Passiva_Indice

	,IIF(indx_psv.desc_abvd_0174 = 'FIXA', ord.tax_pre_pta_psva_0010, ord.tax_pre_pta_atva_0010)									AS Ponta_Passiva_Taxa         
	
	,ctr.bas_dia_pta_fix_tax_0163																									AS Ponta_Passiva_Base_Dias     

	,aloc.ntnl_0023																													AS Ponta_Passiva_Notional

	,moe_ntntl.cod_bbm_0042																											AS Ponta_Passiva_Moeda_Notional
	,moe_ntntl.cod_instc_0042																										AS Instancia_Ponta_Passiva_Moeda_Notional

	,IIF(indx_psv.desc_abvd_0174 = 'FIXA'
			,ISNULL(CAST(ord.frq_reset_pta_psva_0010 AS VARCHAR(10)), '') + ISNULL(ord.tip_frq_reset_pta_psva_0010, '')
			,ISNULL(CAST(ord.frq_reset_pta_atva_0010 AS VARCHAR(10)), '') + ISNULL(ord.tip_frq_reset_pta_atva_0010, ''))			AS Ponta_Passiva_Frequencia_Cupom

	,IIF(indx_psv.desc_abvd_0174 = 'FIXA', indx_atv.desc_abvd_0174, indx_psv.desc_abvd_0174)										AS Ponta_Ativa_Indice

	,ctr.bas_dia_pta_indx_atv_0163																									AS Ponta_Ativa_Base_Dias
	
	,0																																AS Spread

	,aloc.ntnl_0023																													AS Ponta_Ativa_Notional     
	
	,moe_ntntl.cod_bbm_0042																											AS Ponta_Ativa_Moeda_Notional   
	,moe_ntntl.cod_instc_0042																										AS Instancia_Ponta_Ativa_Moeda_Notional

	,IIF(indx_psv.desc_abvd_0174 = 'FIXA'
			,ISNULL(CAST(ord.frq_reset_pta_atva_0010 AS VARCHAR(10)), '') + ISNULL(ord.tip_frq_reset_pta_atva_0010, '')
			,ISNULL(CAST(ord.frq_reset_pta_psva_0010 AS VARCHAR(10)), '') + ISNULL(ord.tip_frq_reset_pta_psva_0010, ''))			AS Ponta_Ativa_Frequencia_Cupom    

	,ord.upfront_0010																												AS Valor_Upfront

	,moe_upfront.cod_bbm_0042																										AS Moeda_Upfront
	,ord.dat_liq_0010																												AS Data_Liquidacao
	,moe_upfront.cod_instc_0042																										AS Instancia_Moeda_Upfront
	
	,IIF(indx_psv.desc_abvd_0174 = 'FIXA', indx_atv.cod_instc_0174, indx_psv.cod_instc_0174)										AS Instancia_Ponta_Flutuante_Indice
	
	,IIF(indx_psv.desc_abvd_0174 = 'FIXA', 'Bahia', 'Contraparte')																	AS Contraparte_Passiva_Ponta_Fixa

	,IIF(indx_atv.desc_abvd_0174 = 'FIXA', 'Bahia', 'Contraparte')																	AS Contraparte_Passiva_Ponta_Flutuante

INTO
	#ordens
FROM 
	bd_106_bbmfront.dbo.ord_bbm_0010 AS ord                    -- ordem que o trader botou no mercado
	INNER JOIN
	bd_106_bbmfront.dbo.cls_ngc_0018 AS cls_ngc ON cls_ngc.cod_instc_0018 = ord.cod_instc_cls_ngc_0010
	INNER JOIN
	bd_106_bbmfront.dbo.ord_aloc_0023 AS aloc ON aloc.cod_instc_ord_0023 = ord.cod_instc_0010		-- 1 ordem tem varias linhas nas ord_aloc
	INNER JOIN
	bd_108_bbmcorp.dbo.v_fnd_inv_0019 AS fnd ON fnd.cod_instc_0019 = aloc.Cod_instc_fnd_0023		-- tem infos sobre o fundo associado ao aloc
	INNER JOIN
	bd_108_bbmcorp.dbo.v_atv_bbm_0012 AS atv ON atv.cod_instc_0012 = ord.cod_instc_atv_0010		 -- possui infos do ativo / algumas colunas do contrato
	INNER JOIN
	bd_108_bbmcorp.dbo.v_ctr_0163 AS ctr ON ctr.cod_instc_0163 = atv.cod_instc_ctr_0012		-- colunas do contrato
	LEFT JOIN
	bd_106_bbmfront.dbo.ctrl_apvd_ord_0150 AS ctrl_apvd ON		ctrl_apvd.cod_instc_ord_0150	= ord.cod_instc_0010		-- trade temq ser aprovado por 3 caras
															AND ctrl_apvd.cod_instc_fnd_0150	= fnd.Cod_instc_0019                               
															AND ctrl_apvd.ind_sit_0150			= 1 
															AND ctrl_apvd.orig_0150				= 'SWP'
	LEFT JOIN
	bd_108_bbmcorp.dbo.v_itmd_0030 cstd ON cstd.cod_instc_0030 = ord.Cod_instc_cstd_0010
	LEFT JOIN
	bd_108_bbmcorp.dbo.v_itmd_0030 ctpt ON ctpt.cod_instc_0030 = ord.Cod_instc_ctpt_0010
	LEFT JOIN
	bd_108_bbmcorp.dbo.v_moe_0042 AS moe_ntntl ON moe_ntntl.cod_instc_0042 = atv.cod_instc_moe_ntnl_0012		-- o ativo q sabe a moeda do trade
	LEFT JOIN
	bd_108_bbmcorp.dbo.v_moe_0042 AS moe_upfront ON moe_upfront.cod_instc_0042 = ord.cod_instc_moe_liq_0010
	LEFT JOIN
	bd_108_bbmcorp.dbo.indx_0174 AS indx_atv ON indx_atv.cod_instc_0174 = ord.cod_instc_indx_pta_atva_0010
	LEFT JOIN
	bd_108_bbmcorp.dbo.indx_0174 AS indx_psv ON indx_psv.cod_instc_0174 = ord.cod_instc_indx_pta_psva_0010
	

WHERE 
		aloc.ind_sit_0023		= 1
	AND fnd.ind_sit_0019		= 1
	AND ord.ind_sit_0010		= 1
	AND atv.cls_ctr_0012		= 'IRS'
	AND aloc.dat_trd_0023		= @data
	AND ord.cod_instc_cls_ngc_0010 NOT IN (11,12)

ORDER BY
       ord.dat_trd_0010 DESC


/***********************************************************************************************************
	Dados do markit                                                
***********************************************************************************************************/
/************************************************************
	Mapeando a Contraparte no markit
************************************************************/
CREATE TABLE #Lado_Contraparte (cod_instc_mapeado int, party_ctpt varchar(100))

INSERT INTO 
	#Lado_Contraparte
SELECT
	markit.cod_instc_0964
	,CASE 
		WHEN header_Party_A_0964 = cod_ext.cod_ext_0443		THEN  'partyA'
		WHEN header_Party_B_0964 = cod_ext.cod_ext_0443		THEN  'partyB'
		ELSE ''
	 END
FROM 
	bd_106_bbmfront.dbo.dd_mrkit_0964 AS markit
    INNER JOIN
    bd_108_bbmcorp.dbo.v_itmd_0030 AS ctpt ON ctpt.cod_instc_0030 = markit.cod_instc_ctpt_0964
	INNER JOIN
	bd_108_bbmcorp.dbo.cod_ext_0443 AS cod_ext ON cod_ext.cod_instc_int_0443 = ctpt.cod_instc_0030
WHERE
		markit.ind_sit_0964 = 1
	AND	ctpt.ind_sit_0030 = 1
	AND cod_ext.ind_sit_0443 = 1
	AND cod_ext.tip_0443 = 'Executing Broker'
	AND cod_ext.fte_0443 = 'Markit'


/************************************************************
		Dados do markit
************************************************************/
SELECT 
	 markit.mrkit_header_Trade_ID_0964																												AS Trade_ID
	,markit.mrkit_header_Trade_Version_0964																											AS Trade_Version
	,markit.mrkit_header_Trade_Status_0964																											AS Trade_Status
	,markit.mrkit_header_Product_Type_0964																											AS Product_Type
	,markit.mrkit_header_Template_Name_0964																											AS Template_Name
	,IIF(lado_ctpt.party_ctpt = 'partyA'
		, markit.mrkit_swStructuredTradeDetails_Party_B_Alocation_ID_0964
		, markit.mrkit_swStructuredTradeDetails_Party_A_Alocation_ID_0964)																			AS Alocacao
	,CASE 
		WHEN markit.mrkit_exchange_Client_Clearing_0964 = 1		THEN	'CLEARED' 
		ELSE 'BILATERAL' 
     END																																		AS Client_Clearing
	,SUBSTRING(REPLACE(markit.mrkit_exchange_Bilateral_Clearing_House_0964, 'X', ''), 1, 3)															AS Mercado
	,ctpt.desc_abvd_0030																														AS Contraparte
	,ctpt.cod_instc_0030																														AS Instancia_Contraparte
	,markit.mrkit_header_Trade_Date_0964																												AS Trade_Date
	,ISNULL(markit.mrkit_floatingLeg_Effective_Date_0964, markit.mrkit_fixedLeg_Effective_Date_0964)														AS Effective_Date		-- falar com o richard
	,ISNULL(markit.mrkit_floatingLeg_Termination_Date_0964, markit.mrkit_fixedLeg_Termination_Date_0964)													AS Termination_Date		-- falar com o richard		
	,IIF(lado_ctpt.party_ctpt = mrkit_fixedLeg_Payer_0964, 'Contraparte', 'Bahia')																	AS Contraparte_Passiva_Ponta_Fixa		-- refere-se ao pagante da ponta fixa
	,markit.mrkit_fixedLeg_Fixed_Rate_0964																											AS Taxa_Ponta_Fixa
	,markit.mrkit_fixedLeg_Fixed_Rate_Day_Count_Fraction_0964																							AS Day_Count_Fraction_Ponta_Fixa
	,markit.mrkit_fixedLeg_Notional_Amount_0964																										AS Notional_Amount_Ponta_Fixa
	,moe_pta_fix.cod_bbm_0042																													AS Moeda_Notional_Amount_Ponta_Fixa
	,moe_pta_fix.cod_instc_0042																													AS Instancia_Moeda_Notional_Amount_Ponta_Fixa
	
	,CASE
		WHEN	markit.mrkit_header_Product_Type_0964 = 'ZC Inflation Swap'
			OR	ISNULL(CAST(markit.mrkit_fixedLeg_Payment_Frequency_Period_Multiplier_0964 as varchar(10)), '')
				+ISNULL(markit.mrkit_fixedLeg_Payment_Frequency_Period_0964, '') = '1T'
		THEN	'0V'
		ELSE	ISNULL(CAST(markit.mrkit_fixedLeg_Payment_Frequency_Period_Multiplier_0964 as varchar(10)), '')
				+ISNULL(REPLACE(markit.mrkit_fixedLeg_Payment_Frequency_Period_0964,'Y','A'), '0V')
	 END																																		AS Frequencia_Cupom_Ponta_Fixa

	,IIF(lado_ctpt.party_ctpt = mrkit_floatingLeg_Payer_0964, 'Contraparte', 'Bahia')																	AS Contraparte_Passiva_Ponta_Flutuante		-- refere-se ao pagante da ponta flutuante

	,indx.desc_abvd_0174																																AS Indice_Ponta_Flutuante
	,indx.cod_instc_0174																														AS Isntancia_Indice_Ponta_Flutuante

	,markit.mrkit_floatingLeg_floatingRateCalculation_DayCountFraction_0964																			AS Day_Count_Fraction_Ponta_Flutuante

	,ISNULL(ISNULL(markit.mrkit_floatingLeg_inflationRateCalculation_Spread_0964, markit.mrkit_floatingLeg_floatingRateCalculation_Spread_0964), '0')		AS Spread_Ponta_Flutuante -- falar com o richard    
	
	,markit.mrkit_floatingLeg_Notional_Amount_0964																									AS Notional_Amount_Ponta_Flutuante
	,moe_pta_flu.cod_bbm_0042																													AS Moeda_Notional_Amount_Ponta_Flutuante
	,moe_pta_flu.cod_instc_0042																													AS Instancia_Moeda_Notional_Amount_Ponta_Flutuante		
	,CASE
		WHEN	markit.mrkit_header_Product_Type_0964 = 'ZC Inflation Swap'
			OR	ISNULL(CAST(markit.mrkit_floatingLeg_Payment_Frequency_Period_Multiplier_0964 as varchar(10)), '')
				+ISNULL(markit.mrkit_floatingLeg_Payment_Frequency_Period_0964, '') = '1T'
		THEN	'0V'
		ELSE	ISNULL(CAST(markit.mrkit_floatingLeg_Payment_Frequency_Period_Multiplier_0964 as varchar(10)), '')
				+ISNULL(REPLACE(markit.mrkit_floatingLeg_Payment_Frequency_Period_0964,'Y','A'), '0V')
	 END																																		AS Frequencia_Cupom_Ponta_Flutuante
	,CASE
		WHEN mrkit_payment_Payer_0964 = lado_ctpt.party_ctpt		THEN	(markit.mrkit_payment_Payment_Amount_0964)
		WHEN mrkit_payment_Receiver_0964 = lado_ctpt.party_ctpt	THEN	(-1) * (markit.mrkit_payment_Payment_Amount_0964)
		ELSE	''
	 END																																		AS Valor_Upfront
	,moe_upfront.cod_bbm_0042																													AS Moeda_Upfront
	,mrkit_payment_Payment_Date_0964																													AS Data_Liquidacao_Markit
	,moe_upfront.cod_instc_0042																													AS Instancia_Moeda_Upfront
	,ISNULL(markit.mrkit_floatingLeg_Effective_Date_Adjustments_0964, markit.mrkit_fixedLeg_Effective_Date_Adjustments_0964)								AS Effective_Date_Adjustments
	,ISNULL(markit.mrkit_floatingLeg_Termination_Date_0964, markit.mrkit_fixedLeg_Termination_Date_0964)													AS Termination_Date_Adjustments
	,markit.mrkit_payment_Payment_Day_Business_Day_Convention_0964																					AS Payment_Day_Business_Day_Convention
	,markit.mrkit_header_Master_Agreement_Type_0964																									AS Master_Agreement_Type
	,markit.mrkit_header_Contractual_Definitions_0964																									AS Contractual_Definitions
INTO 
	#markit
FROM
	bd_106_bbmfront.dbo.dd_mrkit_irs_0964 AS markit
	INNER JOIN
	bd_106_bbmfront.dbo.ctrl_ipc_mrkit_0962 AS ipc ON ipc.cod_instc_0962 = markit.cod_instc_ipc_0964
	INNER JOIN
	#Lado_Contraparte AS lado_ctpt ON lado_ctpt.cod_instc_mapeado = markit.cod_instc_0964		-- casa com a tabela temporaria que diz qual party representa a contraparte
	LEFT JOIN
	bd_108_bbmcorp.dbo.v_itmd_0030 AS ctpt ON ctpt.cod_instc_0030 = markit.cod_instc_ctpt_0964
	LEFT JOIN
	bd_108_bbmcorp.dbo.indx_0174 AS indx ON indx.cod_instc_0174 = markit.cod_instc_indx_0964
	LEFT JOIN
	bd_108_bbmcorp.dbo.v_moe_0042 AS moe_pta_fix ON moe_pta_fix.cod_instc_0042 = markit.cod_instc_moe_pta_fix_0964
	LEFT JOIN
	bd_108_bbmcorp.dbo.v_moe_0042 AS moe_pta_flu ON moe_pta_flu.cod_instc_0042 = markit.cod_instc_moe_pta_flu_0964
	LEFT JOIN
	bd_108_bbmcorp.dbo.v_moe_0042 AS moe_upfront ON moe_upfront.cod_instc_0042 = markit.cod_instc_moe_upfront_0964
WHERE
	    ctpt.ind_sit_0030 = 1
	AND indx.ind_sit_0174 = 1
	AND ipc.ind_sit_0962 = 1
	AND markit.mrkit_header_Trade_Date_0964 = @data
	AND ipc.dat_ipc_0962 = @data
ORDER BY 
	markit.header_Trade_Date_0964 DESC


/***********************************************************************************************************
	Batimento                                                
***********************************************************************************************************/
SELECT 
	 ord.Id_Ordem																					AS Id_Ordem   
	,CASE 
		WHEN 
				ord.Cleared																					= markit.Client_Clearing
			AND ord.Mercado																					= markit.Mercado
			AND ord.Instancia_Contraparte																	= markit.Instancia_Contraparte  
			AND ord.Data_Trade																				= markit.Trade_Date
			AND ord.Data_Inicio																				= markit.Effective_Date
			AND ord.Data_Vencimento																			= markit.Termination_Date
			AND ord.Contraparte_Passiva_Ponta_Fixa															= markit.Contraparte_Passiva_Ponta_Fixa
			AND ord.Ponta_Passiva_Taxa																		= markit.Taxa_Ponta_Fixa
			AND ord.Ponta_Passiva_Base_Dias																	= markit.Day_Count_Fraction_Ponta_Fixa
			AND ord.Ponta_Passiva_Notional																	= markit.Notional_Amount_Ponta_Fixa
			AND ord.Instancia_Ponta_Passiva_Moeda_Notional													= markit.Instancia_Moeda_Notional_Amount_Ponta_Fixa
			AND ord.Ponta_Passiva_Frequencia_Cupom															= markit.Frequencia_Cupom_Ponta_Fixa
			AND ord.Contraparte_Passiva_Ponta_Flutuante														= markit.Contraparte_Passiva_Ponta_Flutuante
			AND	ord.Instancia_Ponta_Flutuante_Indice														= markit.Isntancia_Indice_Ponta_Flutuante					
			AND ord.Ponta_Ativa_Base_Dias																	= markit.Day_Count_Fraction_Ponta_Flutuante
			AND ord.Spread																					= markit.Spread_Ponta_Flutuante
			AND ord.Ponta_Ativa_Notional																	= markit.Notional_Amount_Ponta_Flutuante
			AND ord.Instancia_Ponta_Ativa_Moeda_Notional													= markit.Instancia_Moeda_Notional_Amount_Ponta_Flutuante
			AND ord.Ponta_Ativa_Frequencia_Cupom															= markit.Frequencia_Cupom_Ponta_Flutuante
			AND ord.Valor_Upfront																			= markit.Valor_Upfront					
			AND ( IIF(ISNULL(ord.Valor_Upfront, 0) = 0, 0, ord.Instancia_Moeda_Upfront)						= ISNULL(markit.Instancia_Moeda_Upfront, 0) )
			AND  CAST(IIF(ISNULL(ord.Valor_Upfront, 0) = 0, GETDATE(), ord.Data_Liquidacao)  AS DATE)		= CAST(ISNULL(markit.Data_Liquidacao_Markit,GETDATE()) AS DATE)
		THEN 'true'
		ELSE 'false'
	 END																							AS Batido     
	,ord.Bloqueio  																					AS Bloqueio   
	,ord.Ativo      																				AS Ativo      
	,ord.Fundo      																				AS Fundo      
	,ord.Custodiante																				AS Custodiante
	
	,markit.Trade_ID																				AS Trade_ID
	,markit.Trade_Version																			AS Trade_Version
	,markit.Trade_Status																			AS Trade_Status
	,markit.Product_Type																			AS Product_Type
	,markit.Template_Name																			AS Template_Name
	,markit.Alocacao																				AS Alocacao

	,ISNULL(ord.Cleared, markit.Client_Clearing)													AS Clearedo
	,ISNULL(ord.Mercado, markit.Mercado)															AS Mercado
	,ISNULL(ord.Contraparte, markit.Contraparte)													AS Contraparte         
	,ISNULL(ord.Data_Trade, markit.Trade_Date)														AS Data_Trade          
	,ISNULL(ord.Data_Inicio, markit.Effective_Date)													AS Data_Inicio          
	,ISNULL(ord.Data_Vencimento, markit.Termination_Date)											AS Data_Vencimento

	,ISNULL(ord.Contraparte_Passiva_Ponta_Fixa, markit.Contraparte_Passiva_Ponta_Fixa)				AS Contraparte_Passiva_Ponta_Fixa
	,ISNULL(ord.Ponta_Passiva_Taxa, markit.Taxa_Ponta_Fixa)											AS Taxa_Ponta_Fixa
	,ISNULL(ord.Ponta_Passiva_Base_Dias, markit.Day_Count_Fraction_Ponta_Fixa)						AS Base_Dias_Ponta_Fixa
	,ISNULL(ord.Ponta_Passiva_Notional, markit.Notional_Amount_Ponta_Fixa)							AS Notional_Amount_Ponta_Fixa
	,ISNULL(ord.Ponta_Passiva_Moeda_Notional, markit.Moeda_Notional_Amount_Ponta_Fixa)				AS Moeda_Notional_Amount_Ponta_Fixa    
	,ISNULL(ord.Ponta_Passiva_Frequencia_Cupom, markit.Frequencia_Cupom_Ponta_Fixa)					AS Frequencia_Cupom_Ponta_Fixa

	,ISNULL(ord.Contraparte_Passiva_Ponta_Flutuante, markit.Contraparte_Passiva_Ponta_Flutuante)	AS Contraparte_Passiva_Ponta_Flutuante
	,ISNULL(ord.Ponta_Ativa_Indice, markit.Indice_Ponta_Flutuante)									AS Indice_Ponta_Flutuante
	,ISNULL(ord.Ponta_Ativa_Base_Dias, markit.Day_Count_Fraction_Ponta_Flutuante)					AS Base_Dias_Ponta_Flutuante
	,ISNULL(ord.Spread, markit.Spread_Ponta_Flutuante)												AS Spread
	,ISNULL(ord.Ponta_Ativa_Notional, markit.Notional_Amount_Ponta_Flutuante)						AS Notional_Amount_Ponta_Flutuante
	,ISNULL(ord.Ponta_Ativa_Moeda_Notional, markit.Moeda_Notional_Amount_Ponta_Flutuante)			AS Moeda_Notional_Amount_Ponta_Flutuante
	,ISNULL(ord.Ponta_Ativa_Frequencia_Cupom, markit.Frequencia_Cupom_Ponta_Flutuante)				AS Frequencia_Cupom_Ponta_Flutuante
	,ISNULL(ord.Valor_Upfront, markit.Valor_Upfront)												AS Valor_Upfront	
	,ISNULL(ord.Moeda_Upfront, markit.Moeda_Upfront)												AS Moeda_Upfront
	,ISNULL(ord.Data_Liquidacao, markit.Data_Liquidacao_Markit)										AS Data_Liquidacao

	,markit.Effective_Date_Adjustments																AS Effective_Date_Adjustments		
	,markit.Termination_Date_Adjustments															AS Termination_Date_Adjustments		
	,markit.Payment_Day_Business_Day_Convention														AS Payment_Day_Business_Day_Convention
	,markit.Master_Agreement_Type																	AS Master_Agreement_Type
	,markit.Contractual_Definitions																	AS Contractual_Definitions	
FROM
	#markit AS markit
	FULL OUTER JOIN
	#ordens AS ord ON	
						ord.Cleared																					= markit.Client_Clearing
					AND ord.Mercado																					= markit.Mercado     -- apenas operamos com LCH e CME   
					AND ord.Instancia_Contraparte																	= markit.Instancia_Contraparte  
					AND ord.Data_Trade																				= markit.Trade_Date
					AND ord.Data_Inicio																				= markit.Effective_Date
					AND ord.Data_Vencimento																			= markit.Termination_Date
					AND ord.Contraparte_Passiva_Ponta_Fixa															= markit.Contraparte_Passiva_Ponta_Fixa
					AND ord.Ponta_Passiva_Taxa																		= markit.Taxa_Ponta_Fixa
					AND ord.Ponta_Passiva_Base_Dias																	= markit.Day_Count_Fraction_Ponta_Fixa
					AND ord.Ponta_Passiva_Notional																	= markit.Notional_Amount_Ponta_Fixa
					AND ord.Instancia_Ponta_Passiva_Moeda_Notional													= markit.Instancia_Moeda_Notional_Amount_Ponta_Fixa
					AND ord.Ponta_Passiva_Frequencia_Cupom															= markit.Frequencia_Cupom_Ponta_Fixa
					AND ord.Contraparte_Passiva_Ponta_Flutuante														= markit.Contraparte_Passiva_Ponta_Flutuante
					AND	ord.Instancia_Ponta_Flutuante_Indice														= markit.Isntancia_Indice_Ponta_Flutuante					
					AND ord.Ponta_Ativa_Base_Dias																	= markit.Day_Count_Fraction_Ponta_Flutuante
					AND ord.Spread																					= markit.Spread_Ponta_Flutuante
					AND ord.Ponta_Ativa_Notional																	= markit.Notional_Amount_Ponta_Flutuante
					AND ord.Instancia_Ponta_Ativa_Moeda_Notional													= markit.Instancia_Moeda_Notional_Amount_Ponta_Flutuante
					AND ord.Ponta_Ativa_Frequencia_Cupom															= markit.Frequencia_Cupom_Ponta_Flutuante
					AND ord.Valor_Upfront																			= markit.Valor_Upfront					
					AND (IIF(ISNULL(ord.Valor_Upfront, 0) = 0, 0, ord.Instancia_Moeda_Upfront)						= ISNULL(markit.Instancia_Moeda_Upfront, 0))	-- se no bahia nao tem valor do upfront --> a instancia da moeda do bahia vai ser levada para 0 --> comparado com a moeda do markit
					AND  CAST(IIF(ISNULL(ord.Valor_Upfront, 0) = 0, GETDATE(), ord.Data_Liquidacao)  AS DATE)		= CAST(ISNULL(markit.Data_Liquidacao_Markit,GETDATE()) AS DATE)