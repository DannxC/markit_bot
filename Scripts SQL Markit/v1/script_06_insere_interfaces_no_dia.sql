/************************************************************
	Insere novas interfaces no dia
************************************************************/
Declare @data date
Declare @resultadoInterf varchar(100)
Set @data = GETDATE()

EXECUTE [bd_106_bbmfront].[dbo].[UP_Insere_Interface] 
   @data = @data
  ,@resultado = @resultadoInterf OUTPUT