using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Configuration;
using Entidades;
using Markit.Utils;
using System.Data.SqlTypes;
using System.Data.SqlClient;        // nuGet

namespace Markit.DAL
{
    public class BulkInsertRepository : Conexao
    {
        public void BulkInsert(int codInstcIpc, DataTable dataTable)
        {
            try
            {
                // Abre conecção com o servidor

                AbreConexao();


                // Define objeto de SqlBulkCopy

                SqlBulkCopy bulkCopy = new SqlBulkCopy(
                    con,
                    SqlBulkCopyOptions.TableLock |
                    SqlBulkCopyOptions.FireTriggers |
                    SqlBulkCopyOptions.UseInternalTransaction,
                    null
                );


                // Define a tabela a receber os dados

                bulkCopy.DestinationTableName = "dbo.dd_mrkit_irs_temp_0963";



                // Código de Importacao

                bulkCopy.ColumnMappings.Add(nameof(codInstcIpc), "cod_instc_ipc_0963");


                /* XML Dados */

                // Header

                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.header_Trade_ID), "mrkit_header_Trade_ID_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.header_Trade_Version), "mrkit_header_Trade_Version_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.header_Trade_Version_Timestamp), "mrkit_header_Trade_Version_Timestamp_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.header_Trade_Date), "mrkit_header_Trade_Date_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.header_Trade_Status), "mrkit_header_Trade_Status_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.header_Master_Agreement_Type), "mrkit_header_Master_Agreement_Type_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.header_Contractual_Definitions), "mrkit_header_Contractual_Definitions_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.header_Party_A), "mrkit_header_Party_A_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.header_Party_B), "mrkit_header_Party_B_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.header_Product_Type), "mrkit_header_Product_Type_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.header_Template_Name), "mrkit_header_Template_Name_0963");


                // Fixed Leg

                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.fixedLeg_Payer), "mrkit_fixedLeg_Payer_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.fixedLeg_Receiver), "mrkit_fixedLeg_Receiver_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.fixedLeg_Effective_Date), "mrkit_fixedLeg_Effective_Date_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.fixedLeg_Effective_Date_Adjustments), "mrkit_fixedLeg_Effective_Date_Adjustments_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.fixedLeg_Termination_Date), "mrkit_fixedLeg_Termination_Date_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.fixedLeg_Termination_Date_Adjustments), "mrkit_fixedLeg_Termination_Date_Adjustments_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.fixedLeg_Calculation_Period_Dates_Adjustments), "mrkit_fixedLeg_Calculation_Period_Dates_Adjustments_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.fixedLeg_Calculation_Period_Frequency_Multiplier), "mrkit_fixedLeg_Calculation_Period_Frequency_Multiplier_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.fixedLeg_Calculation_Period_Frequency), "mrkit_fixedLeg_Calculation_Period_Frequency_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.fixedLeg_Calculation_Period_Frequency_Roll_Convention), "mrkit_fixedLeg_Calculation_Period_Frequency_Roll_Convention_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.fixedLeg_Payment_Frequency_Period_Multiplier), "mrkit_fixedLeg_Payment_Frequency_Period_Multiplier_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.fixedLeg_Payment_Frequency_Period), "mrkit_fixedLeg_Payment_Frequency_Period_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.fixedLeg_Payment_Dates_PayRelativeTo), "mrkit_fixedLeg_Payment_Dates_PayRelativeTo_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.fixedLeg_Payment_Dates_Business_Convention), "mrkit_fixedLeg_Payment_Dates_Business_Convention_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.fixedLeg_Payment_Dates_Business_Convention_Business_Centers), "mrkit_fixedLeg_Payment_Dates_Business_Convention_Business_Centers_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.fixedLeg_Payments_Day_Offset_Multiplier), "mrkit_fixedLeg_Payments_Day_Offset_Multiplier_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.fixedLeg_Payments_Day_Offset_Period), "mrkit_fixedLeg_Payments_Day_Offset_Period_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.fixedLeg_Payments_Day_Offset_Day_Type), "mrkit_fixedLeg_Payments_Day_Offset_Day_Type_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.fixedLeg_Notional_Amount), "mrkit_fixedLeg_Notional_Amount_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.fixedLeg_Notional_Amount_Currency), "mrkit_fixedLeg_Notional_Amount_Currency_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.fixedLeg_Fixed_Rate), "mrkit_fixedLeg_Fixed_Rate_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.fixedLeg_Fixed_Rate_Day_Count_Fraction), "mrkit_fixedLeg_Fixed_Rate_Day_Count_Fraction_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.fixedLeg_CashFlows_Match_Parameters), "mrkit_fixedLeg_CashFlows_Match_Parameters_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.fixedLeg_CashFlows_Payment_Unadjusted_Payment_Date), "mrkit_fixedLeg_CashFlows_Payment_Unadjusted_Payment_Date_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.fixedLeg_CashFlows_Payment_Fixed_Payment_Amount), "mrkit_fixedLeg_CashFlows_Payment_Fixed_Payment_Amount_0963");


                // Floating Leg

                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_Payer), "mrkit_floatingLeg_Payer_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_Receiver), "mrkit_floatingLeg_Receiver_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_Effective_Date), "mrkit_floatingLeg_Effective_Date_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_Effective_Date_Adjustments), "mrkit_floatingLeg_Effective_Date_Adjustments_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_Termination_Date), "mrkit_floatingLeg_Termination_Date_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_Termination_Date_Adjustments), "mrkit_floatingLeg_Termination_Date_Adjustments_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_Calculation_Period_Dates_Adjustments), "mrkit_floatingLeg_Calculation_Period_Dates_Adjustments_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_Calculation_Period_Frequency_Multiplier), "mrkit_floatingLeg_Calculation_Period_Frequency_Multiplier_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_Calculation_Period_Frequency), "mrkit_floatingLeg_Calculation_Period_Frequency_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_Calculation_Period_Frequency_Roll_Convention), "mrkit_floatingLeg_Calculation_Period_Frequency_Roll_Convention_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_Payment_Frequency_Period_Multiplier), "mrkit_floatingLeg_Payment_Frequency_Period_Multiplier_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_Payment_Frequency_Period), "mrkit_floatingLeg_Payment_Frequency_Period_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_Payment_Dates_PayRelativeTo), "mrkit_floatingLeg_Payment_Dates_PayRelativeTo_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_Payment_Dates_Business_Convention), "mrkit_floatingLeg_Payment_Dates_Business_Convention_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_Payment_Dates_Business_Convention_Business_Centers), "mrkit_floatingLeg_Payment_Dates_Business_Convention_Business_Centers_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_Payments_Day_Offset_Multiplier), "mrkit_floatingLeg_Payments_Day_Offset_Multiplier_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_Payments_Day_Offset_Period), "mrkit_floatingLeg_Payments_Day_Offset_Period_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_Payments_Day_Offset_Day_Type), "mrkit_floatingLeg_Payments_Day_Offset_Day_Type_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_Fixing_Reset_Related_To), "mrkit_floatingLeg_Fixing_Reset_Related_To_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_Fixing_Dates_Multiplier), "mrkit_floatingLeg_Fixing_Dates_Multiplier_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_Fixing_Dates_Period), "mrkit_floatingLeg_Fixing_Dates_Period_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_Fixing_Day_Convention), "mrkit_floatingLeg_Fixing_Day_Convention_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_Fixing_Day_Business_Center), "mrkit_floatingLeg_Fixing_Day_Business_Center_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_Reset_Frequency_Multiplier), "mrkit_floatingLeg_Reset_Frequency_Multiplier_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_Reset_Frequency_Period), "mrkit_floatingLeg_Reset_Frequency_Period_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_Reset_Date_Adjustment), "mrkit_floatingLeg_Reset_Date_Adjustment_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_Reset_Date_Business_Center), "mrkit_floatingLeg_Reset_Date_Business_Center_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_Notional_Amount), "mrkit_floatingLeg_Notional_Amount_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_Notional_Amount_Currency), "mrkit_floatingLeg_Notional_Amount_Currency_0963");
                // tipo 1
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_floatingRateCalculation_Index), "mrkit_floatingLeg_floatingRateCalculation_Index_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_floatingRateCalculation_Index_Frequency_Multiplier), "mrkit_floatingLeg_floatingRateCalculation_Index_Frequency_Multiplier_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_floatingRateCalculation_Index_Frequency_Period), "mrkit_floatingLeg_floatingRateCalculation_Index_Frequency_Period_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_floatingRateCalculation_Index_Source), "mrkit_floatingLeg_floatingRateCalculation_Index_Source_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_floatingRateCalculation_Inflation_Rate_Interpolation_Method), "mrkit_floatingLeg_floatingRateCalculation_Inflation_Rate_Interpolation_Method_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_floatingRateCalculation_Inflation_Rate_Level), "mrkit_floatingLeg_floatingRateCalculation_Inflation_Rate_Level_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_floatingRateCalculation_DayCountFraction), "mrkit_floatingLeg_floatingRateCalculation_DayCountFraction_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_floatingRateCalculation_Spread), "mrkit_floatingLeg_floatingRateCalculation_Spread_0963");
                // tipo 2
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_inflationRateCalculation_Index), "mrkit_floatingLeg_inflationRateCalculation_Index_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_inflationRateCalculation_Index_Frequency_Multiplier), "mrkit_floatingLeg_inflationRateCalculation_Index_Frequency_Multiplier_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_inflationRateCalculation_Index_Frequency_Period), "mrkit_floatingLeg_inflationRateCalculation_Index_Frequency_Period_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_inflationRateCalculation_Index_Source), "mrkit_floatingLeg_inflationRateCalculation_Index_Source_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_inflationRateCalculation_Inflation_Rate_Interpolation_Method), "mrkit_floatingLeg_inflationRateCalculation_Inflation_Rate_Interpolation_Method_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_inflationRateCalculation_Inflation_Rate_Level), "mrkit_floatingLeg_inflationRateCalculation_Inflation_Rate_Level_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_inflationRateCalculation_DayCountFraction), "mrkit_floatingLeg_inflationRateCalculation_DayCountFraction_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.floatingLeg_inflationRateCalculation_Spread), "mrkit_floatingLeg_inflationRateCalculation_Spread_0963");


                // Payment

                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.payment_Payer), "mrkit_payment_Payer_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.payment_Receiver), "mrkit_payment_Receiver_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.payment_Payment_Amount), "mrkit_payment_Payment_Amount_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.payment_Payment_Currency), "mrkit_payment_Payment_Currency_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.payment_Payment_Date), "mrkit_payment_Payment_Date_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.payment_Payment_Day_Business_Day_Convention), "mrkit_payment_Payment_Day_Business_Day_Convention_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.payment_Payment_Day_Business_Day), "mrkit_payment_Payment_Day_Business_Day_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.payment_Reason), "mrkit_payment_Reason_0963");


                // Exchange

                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.exchange_Client_Clearing), "mrkit_exchange_Client_Clearing_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.exchange_Bilateral_Clearing_House), "mrkit_exchange_Bilateral_Clearing_House_0963");

                // swExtendedTradeDetails

                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.swStructuredTradeDetails_Party_A_Alocation_ID), "mrkit_swStructuredTradeDetails_Party_A_Alocation_ID_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.swStructuredTradeDetails_Party_A_Alocation_Name), "mrkit_swStructuredTradeDetails_Party_A_Alocation_Name_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.swStructuredTradeDetails_Party_B_Alocation_ID), "mrkit_swStructuredTradeDetails_Party_B_Alocation_ID_0963");
                bulkCopy.ColumnMappings.Add(nameof(XMLDadosLinearizados.swStructuredTradeDetails_Party_B_Alocation_Name), "mrkit_swStructuredTradeDetails_Party_B_Alocation_Name_0963");


                /* Extensao Tabela */

                bulkCopy.ColumnMappings.Add(nameof(ExtensaoTabela.ind_sit), "ind_sit_0963");
                bulkCopy.ColumnMappings.Add(nameof(ExtensaoTabela.dat_cdm), "dat_cdm_0963");
                bulkCopy.ColumnMappings.Add(nameof(ExtensaoTabela.usr_cdm), "usr_cdm_0963");


                //Escreve os dados da tabela no bd

                bulkCopy.WriteToServer(dataTable);

                return;
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                // Fecha conexão com o servidor

                FechaConexao();
            }
        }
    }
}
