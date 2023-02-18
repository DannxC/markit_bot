USE    bd_108_bbmcorp
 
Declare @cod_instc_func_sgn int
 
/************************************************************
       Cria a função de segurança pro Markit
************************************************************/


INSERT INTO 
	dbo.func_sgn_0026
	(
		Cod_Func_0026
		,Desc_func_0026
		,Cod_Instc_sis_0026

		,ind_sit_0026
		,dat_cdm_0026
		,usr_cdm_0026
	)
VALUES
	(
       'ITFC_IPC_DD_MRKIT'
       ,'Permissão para importar os dados do Markit'
	   ,1

       ,1
	   ,GETDATE()
	   ,SUSER_NAME()
	)


set @cod_instc_func_sgn = SCOPE_IDENTITY()
  
 
 
/************************************************************
       Cria as interfaces
************************************************************/
DECLARE @desc_itfc VARCHAR(100) = 'Importacao_Markit'

INSERT INTO dbo.itfc_0115
(
     cod_mpa_0115
    ,desc_itfc_0115
    ,cod_instc_func_sgn_0115
    ,arq_ew_0115
    ,vld_aprv_mpa_0115
    ,cod_instc_area_0115
    ,cod_instc_emp_0115
    ,act_seg_exe_0115
    ,dir_arq_ent_0115
    ,dia_antd_0115
    ,vld_mpa_prc_0115
    ,tip_dd_adc_0115
    ,ind_sit_0115
    ,dat_cdm_0115
    ,usr_cdm_0115
 
)
VALUES
(   
       'OFF'																														-- cod_mpa_0115 - varchar(5)
    ,@desc_itfc																														-- desc_itfc_0115 - varchar(50)            
    ,@cod_instc_func_sgn																											-- cod_instc_func_sgn_0115 - int  
    ,''																																-- arq_ew_0115 - varchar(500)            
    ,NULL																															-- vld_aprv_mpa_0115 - varchar(50)
    ,NULL																															-- cod_instc_area_0115 - int
    ,NULL																															-- cod_instc_emp_0115 - int
    ,0																																-- act_seg_exe_0115 - bit
    ,NULL																															-- dir_arq_ent_0115 - varchar(500)
    ,0																																-- dia_antd_0115 - int
    ,NULL																															-- vld_mpa_prc_0115 - bit
    ,null																															-- tip_dd_adc_0115 - varchar(100)
    ,1																																-- ind_sit_0115 - tinyint
    ,GETDATE()																														-- dat_cdm_0115 - datetime
    ,SUSER_NAME()																													-- usr_cdm_0115 - varchar(100)
   
 )
 
insert into
	usr_func_sgn_0028
(
	Cod_Instc_func_sgn_0028	
	,cod_Instc_usr_0028

	,ind_sit_0028
	,dat_cdm_0028
	,usr_cdm_0028
)


-- cópia dos usuarios da função de segurança do MUFG para o markit
select 
	 @cod_instc_func_sgn
	,cod_Instc_usr_0028

	,1
	,GETDATE()
	,SUSER_NAME()
from 
	usr_func_sgn_0028 
	inner join 
	func_sgn_0026 on Cod_Instc_func_sgn_0028 = cod_instc_0026
where 
		Cod_Func_0026 = 'APVD_ITFC_MUFG'
	and ind_sit_0026 = 1
	and ind_sit_0028 = 1
 
 
