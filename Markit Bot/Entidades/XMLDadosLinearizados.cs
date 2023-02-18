using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class XMLDadosLinearizados
    {
        /* Leafs que serão importadas de fato */

        // header

        public long? header_Trade_ID { get; set; }

        public long? header_Trade_Version { get; set; }

        public DateTime? header_Trade_Version_Timestamp { get; set; }

        public DateTime? header_Trade_Date { get; set; }

        public string? header_Trade_Status { get; set; }

        public string? header_Master_Agreement_Type { get; set; }

        public string? header_Contractual_Definitions
        { 
            get { return _header_Contractual_Definitions; }
            set
            {
                if (value == "")
                    _header_Contractual_Definitions = null;
                else
                    _header_Contractual_Definitions = value;
            }
        }
        public string? _header_Contractual_Definitions;

        public string? header_Party_A { get; set; }

        public string? header_Party_B { get; set; }

        public string? header_Product_Type { get; set; }

        public string? header_Template_Name { get; set; }


        // fixedLeg

        public string? fixedLeg_Payer { get; set; }

        public string? fixedLeg_Receiver { get; set; }

        public DateTime? fixedLeg_Effective_Date { get; set; }

        public string? fixedLeg_Effective_Date_Adjustments { get; set; }

        public DateTime? fixedLeg_Termination_Date { get; set; }

        public string? fixedLeg_Termination_Date_Adjustments { get; set; }

        public string? fixedLeg_Calculation_Period_Dates_Adjustments { get; set; }

        public long? fixedLeg_Calculation_Period_Frequency_Multiplier { get; set; }

        public string? fixedLeg_Calculation_Period_Frequency { get; set; }

        public string? fixedLeg_Calculation_Period_Frequency_Roll_Convention { get; set; }

        public long? fixedLeg_Payment_Frequency_Period_Multiplier { get; set; }

        public string? fixedLeg_Payment_Frequency_Period { get; set; }

        public string? fixedLeg_Payment_Dates_PayRelativeTo { get; set; }

        public string? fixedLeg_Payment_Dates_Business_Convention { get; set; }

        public string? fixedLeg_Payment_Dates_Business_Convention_Business_Centers
        {
            get { return _fixedLeg_Payment_Dates_Business_Convention_Business_Centers; }
            set
            {
                if (value == "")
                    _fixedLeg_Payment_Dates_Business_Convention_Business_Centers = null;
                else
                    _fixedLeg_Payment_Dates_Business_Convention_Business_Centers = value;
            }
        }
        public string? _fixedLeg_Payment_Dates_Business_Convention_Business_Centers;

        public long? fixedLeg_Payments_Day_Offset_Multiplier { get; set; }

        public string? fixedLeg_Payments_Day_Offset_Period { get; set; }

        public string? fixedLeg_Payments_Day_Offset_Day_Type { get; set; }

        public long? fixedLeg_Notional_Amount { get; set; }

        public string? fixedLeg_Notional_Amount_Currency { get; set; }

        public double? fixedLeg_Fixed_Rate { get; set; }

        public string? fixedLeg_Fixed_Rate_Day_Count_Fraction { get; set; }

        public bool? fixedLeg_CashFlows_Match_Parameters { get; set; }

        public DateTime? fixedLeg_CashFlows_Payment_Unadjusted_Payment_Date { get; set; }

        public double? fixedLeg_CashFlows_Payment_Fixed_Payment_Amount { get; set; }


        // floatingLeg

        public string? floatingLeg_Payer { get; set; }

        public string? floatingLeg_Receiver { get; set; }

        public DateTime? floatingLeg_Effective_Date { get; set; }

        public string? floatingLeg_Effective_Date_Adjustments { get; set; }

        public DateTime? floatingLeg_Termination_Date { get; set; }

        public string? floatingLeg_Termination_Date_Adjustments { get; set; }

        public string? floatingLeg_Calculation_Period_Dates_Adjustments { get; set; }

        public long? floatingLeg_Calculation_Period_Frequency_Multiplier { get; set; }

        public string? floatingLeg_Calculation_Period_Frequency { get; set; }

        public string? floatingLeg_Calculation_Period_Frequency_Roll_Convention { get; set; }

        public long? floatingLeg_Payment_Frequency_Period_Multiplier { get; set; }

        public string? floatingLeg_Payment_Frequency_Period { get; set; }

        public string? floatingLeg_Payment_Dates_PayRelativeTo { get; set; }

        public string? floatingLeg_Payment_Dates_Business_Convention { get; set; }

        public string? floatingLeg_Payment_Dates_Business_Convention_Business_Centers
        {
            get { return _floatingLeg_Payment_Dates_Business_Convention_Business_Centers; }
            set
            {
                if (value == "")
                    _floatingLeg_Payment_Dates_Business_Convention_Business_Centers = null;
                else
                    _floatingLeg_Payment_Dates_Business_Convention_Business_Centers = value;
            }
        }
        public string? _floatingLeg_Payment_Dates_Business_Convention_Business_Centers;

        public long? floatingLeg_Payments_Day_Offset_Multiplier { get; set; }

        public string? floatingLeg_Payments_Day_Offset_Period { get; set; }

        public string? floatingLeg_Payments_Day_Offset_Day_Type { get; set; }

        public string? floatingLeg_Fixing_Reset_Related_To { get; set; }

        public long? floatingLeg_Fixing_Dates_Multiplier { get; set; }

        public string? floatingLeg_Fixing_Dates_Period { get; set; }

        public string? floatingLeg_Fixing_Day_Convention { get; set; }

        public string? floatingLeg_Fixing_Day_Business_Center
        {
            get { return _floatingLeg_Fixing_Day_Business_Center; }
            set {
                if (value == "")
                    _floatingLeg_Fixing_Day_Business_Center = null;
                else
                    _floatingLeg_Fixing_Day_Business_Center = value;
            }
        }
        public string? _floatingLeg_Fixing_Day_Business_Center;

        public long? floatingLeg_Reset_Frequency_Multiplier { get; set; }

        public string? floatingLeg_Reset_Frequency_Period { get; set; }

        public string? floatingLeg_Reset_Date_Adjustment { get; set; }

        public string? floatingLeg_Reset_Date_Business_Center
        {
            get { return _floatingLeg_Reset_Date_Business_Center; }
            set
            {
                if (value == "")
                    _floatingLeg_Reset_Date_Business_Center = null;
                else
                    _floatingLeg_Reset_Date_Business_Center = value;
            }
        }
        public string? _floatingLeg_Reset_Date_Business_Center;

        public long? floatingLeg_Notional_Amount { get; set; }

        public string? floatingLeg_Notional_Amount_Currency { get; set; }


        // A partir daqui temos 2 layouts (tipos)

        // tipo 1 - Produto = "SingleCurrencyInterestRateSwap" ou "OIS"

        public string? floatingLeg_floatingRateCalculation_Index { get; set; }

        public long? floatingLeg_floatingRateCalculation_Index_Frequency_Multiplier { get; set; }

        public string? floatingLeg_floatingRateCalculation_Index_Frequency_Period { get; set; }  

        public string? floatingLeg_floatingRateCalculation_Index_Source { get; set; } 

        public string? floatingLeg_floatingRateCalculation_Inflation_Rate_Interpolation_Method { get; set; } 

        public double? floatingLeg_floatingRateCalculation_Inflation_Rate_Level { get; set; }

        public string? floatingLeg_floatingRateCalculation_DayCountFraction { get; set; }    

        public double? floatingLeg_floatingRateCalculation_Spread { get; set; }

        // tipo2 - Produto = "ZC Inflation Swap"

        public string? floatingLeg_inflationRateCalculation_Index { get; set; } 

        public long? floatingLeg_inflationRateCalculation_Index_Frequency_Multiplier { get; set; }  

        public string? floatingLeg_inflationRateCalculation_Index_Frequency_Period { get; set; }    

        public string? floatingLeg_inflationRateCalculation_Index_Source { get; set; } 

        public string? floatingLeg_inflationRateCalculation_Inflation_Rate_Interpolation_Method { get; set; } 

        public double? floatingLeg_inflationRateCalculation_Inflation_Rate_Level { get; set; } 

        public string? floatingLeg_inflationRateCalculation_DayCountFraction { get; set; }     

        public double? floatingLeg_inflationRateCalculation_Spread { get; set; }    


        // payment

        public string? payment_Payer { get; set; } 

        public string? payment_Receiver { get; set; }

        public decimal? payment_Payment_Amount { get; set; }  

        public string? payment_Payment_Currency { get; set; } 

        public DateTime? payment_Payment_Date { get; set; }   

        public string? payment_Payment_Day_Business_Day_Convention { get; set; } 

        public string? payment_Payment_Day_Business_Day 
        {
            get { return _payment_Payment_Day_Business_Day; }
            set
            {
                if (value == "")
                    _payment_Payment_Day_Business_Day = null;
                else
                    _payment_Payment_Day_Business_Day = value;
            }
        }
        public string? _payment_Payment_Day_Business_Day;

        public string? payment_Reason { get; set; }


        // exchange

        public bool? exchange_Client_Clearing { get; set; }    

        public string? exchange_Bilateral_Clearing_House { get; set; }


        // swStructuredTradeDetails

        public string? swStructuredTradeDetails_Party_A_Alocation_ID { get; set; }
        
        public string? swStructuredTradeDetails_Party_A_Alocation_Name { get; set; }
        
        public string? swStructuredTradeDetails_Party_B_Alocation_ID { get; set; }

        public string? swStructuredTradeDetails_Party_B_Alocation_Name { get; set; }

    }
}
