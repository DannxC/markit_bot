USE [bd_108_bbmcorp]
 
-- Inserindo usu�rio com vis�o total
Insert Into usr_0021
(
       nom_usr_0021
       ,cod_usr_0021
       ,vsa_tot_0021
       ,usr_sis_0021
       ,opd_dflt_0021
 
       ,ind_sit_0021
       ,dat_cdm_0021
       ,usr_cdm_0021
)
Values
(
       SUSER_NAME()
       ,SUSER_NAME()
       ,1
       ,0
       ,0
 
       ,1
       ,GETDATE()
       ,SUSER_NAME()
)
 
Declare @cod_instc_usr int = SCOPE_IDENTITY()
 
-- Inserindo usu�rio em todas as �reas
Insert Into usr_area_0022
(
       cod_instc_usr_0022
       ,cod_instc_area_0022
 
       ,ind_sit_0022
       ,dat_cdm_0022
       ,usr_cdm_0022
)
Select
       @cod_instc_usr
       ,cod_instc_0020
 
       ,1
       ,GETDATE()
       ,SUSER_NAME()
From
       area_0020
Where
       ind_sit_0020 = 1
 
-- Inserindo usu�rio em todas as fun��es de seguran�a
Insert Into usr_func_sgn_0028
(
       Cod_Instc_func_sgn_0028
       ,cod_Instc_usr_0028
 
       ,ind_sit_0028
       ,dat_cdm_0028
       ,usr_cdm_0028
)
Select
       cod_instc_0026
       ,@cod_instc_usr
 
       ,1
       ,GETDATE()
       ,SUSER_NAME()
From
       func_sgn_0026
Where
       ind_sit_0026 = 1
 
-- Inserindo usu�rio em todos os perfis do mensageria
Insert Into bd_114_bbmmsg..usr_pfl_msg_bbm_0137
(
       cod_instc_pfl_0137
       ,cod_instc_usr_0137
 
       ,ind_sit_0137
       ,dat_cdm_0137
       ,usr_cdm_0137
)
Select
       cod_instc_0139
       ,@cod_instc_usr
 
       ,1
       ,GETDATE()
       ,SUSER_NAME()
From
       bd_114_bbmmsg..pfl_msg_bbm_0139
Where
       ind_sit_0139 = 1
