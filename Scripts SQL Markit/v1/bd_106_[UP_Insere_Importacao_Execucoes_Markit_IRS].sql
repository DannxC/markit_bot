USE bd_106_bbmfront
GO


/****** Object:  StoredProcedure [dbo].[UP_Insere_Importacao_Markit]    Script Date: 13/01/2023 14:06:30 ******/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[UP_Insere_Importacao_Execucoes_Markit_IRS](

	@cod_instc_ipc int = NULL OUTPUT		-- parametro de output da proc

)

AS


SET NOCOUNT ON

DECLARE @data DateTime
SET @data = GETDATE()


/****************************************************************************
1� PASSO: Inserir novo registro de importa��o
    (com status "Em Processamento")
****************************************************************************/
INSERT INTO ctrl_ipc_mrkit_0962
(
    ind_sit_0962,

    dat_cdm_0962,
    usr_cdm_0962
)
VALUES 
(
	 2,

     @data,
	 SUSER_NAME()
)


/****************************************************************************
2� PASSO: Devolve o codigo da importa��o 
****************************************************************************/
SET @cod_instc_ipc = SCOPE_IDENTITY()