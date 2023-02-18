using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Reflection;
using Entidades;

namespace Markit.Utils
{
    public class LinearizadorXMLObj
    {
        // Retorna os valores requisitados do xmlObject complexo de forma linearizada num único objeto.

        public static XMLDadosLinearizados Linearizador(SWML xmlObject)
        {
            // Cria instância de XMLDadosLinearizados, que será retornado futuramente pela função

            XMLDadosLinearizados xmlDados = new XMLDadosLinearizados();
            
            try
            {
                // Variável de apoio

                string tmp;



                /* -------------------------------------------------------- */
                /* Populando xmlDados manualmente de acordo com o interesse */
                /* -------------------------------------------------------- */


                // header

                xmlDados.header_Trade_ID = xmlObject?.swHeader?.tradeId; 

                xmlDados.header_Trade_Version = xmlObject?.swHeader?.swTradeVersionId;

                xmlDados.header_Trade_Version_Timestamp = xmlObject?.swHeader?.swTradeVersionTimestamp; 

                xmlDados.header_Trade_Date = xmlObject?.swStructuredTradeDetails?.FpML?.trade?.tradeHeader?.tradeDate;     

                xmlDados.header_Trade_Status = xmlObject?.swHeader?.swTradeStatus;   

                xmlDados.header_Master_Agreement_Type = xmlObject?.swStructuredTradeDetails?.FpML?.trade?.documentation?.masterAgreement?.masterAgreementType;  

                if(xmlObject?.swStructuredTradeDetails?.FpML?.trade?.documentation?.contractualDefinitions != null)
                {
                    tmp = "";
                    for (int i = 0; i < xmlObject?.swStructuredTradeDetails?.FpML?.trade?.documentation?.contractualDefinitions?.Count; i++)
                    {
                        if (i == 0)
                            tmp = xmlObject?.swStructuredTradeDetails?.FpML?.trade?.documentation?.contractualDefinitions?[i];
                        else
                            tmp = tmp + ";" + xmlObject?.swStructuredTradeDetails?.FpML?.trade?.documentation?.contractualDefinitions?[i];
                    }
                    xmlDados.header_Contractual_Definitions = tmp;    
                }

                // loop + attribute so swTrader para saber se é Party_A ou Party_B.
                foreach (swTrader? swTrader_Iterator in xmlObject?.swHeader?.swNegotiationParties?.swTrader)
                {
                    if (swTrader_Iterator.id == "traderA")
                        xmlDados.header_Party_A = swTrader_Iterator?.swParticipantId;        

                    if (swTrader_Iterator.id == "traderB")
                        xmlDados.header_Party_B = swTrader_Iterator?.swParticipantId;        
                }

                xmlDados.header_Product_Type = xmlObject?.swStructuredTradeDetails?.swProductType;       

                xmlDados.header_Template_Name = xmlObject?.swStructuredTradeDetails?.swTemplateName;     


                // Fixed Leg e Floating Leg

                // loop + attribute "id" do swapStream para decidir se é fixedLeg ou floatLeg
                foreach (swapStream? swapStream_Iterator in xmlObject?.swStructuredTradeDetails?.FpML?.trade?.swap?.swapStream)
                {
                    // Fixed Leg

                    if (swapStream_Iterator?.id == "fixedLeg")
                    {
                        xmlDados.fixedLeg_Payer = swapStream_Iterator?.payerPartyReference?.href;      

                        xmlDados.fixedLeg_Receiver = swapStream_Iterator?.receiverPartyReference?.href;

                        xmlDados.fixedLeg_Effective_Date = swapStream_Iterator?.calculationPeriodDates?.effectiveDate?.unadjustedDate;       

                        xmlDados.fixedLeg_Effective_Date_Adjustments = swapStream_Iterator?.calculationPeriodDates?.effectiveDate?.dateAdjustments?.businessDayConvention;        

                        xmlDados.fixedLeg_Termination_Date = swapStream_Iterator?.calculationPeriodDates?.terminationDate?.unadjustedDate;      

                        xmlDados.fixedLeg_Termination_Date_Adjustments = swapStream_Iterator?.calculationPeriodDates?.terminationDate?.dateAdjustments?.businessDayConvention;    

                        xmlDados.fixedLeg_Calculation_Period_Dates_Adjustments = swapStream_Iterator?.calculationPeriodDates?.calculationPeriodDatesAdjustments?.businessDayConvention;  

                        xmlDados.fixedLeg_Calculation_Period_Frequency_Multiplier = swapStream_Iterator?.calculationPeriodDates?.calculationPeriodFrequency?.periodMultiplier; 

                        xmlDados.fixedLeg_Calculation_Period_Frequency = swapStream_Iterator?.calculationPeriodDates?.calculationPeriodFrequency?.period;

                        xmlDados.fixedLeg_Calculation_Period_Frequency_Roll_Convention = swapStream_Iterator?.calculationPeriodDates?.calculationPeriodFrequency?.rollConvention;

                        xmlDados.fixedLeg_Payment_Frequency_Period_Multiplier = swapStream_Iterator?.paymentDates?.paymentFrequency?.periodMultiplier; 

                        xmlDados.fixedLeg_Payment_Frequency_Period = swapStream_Iterator?.paymentDates?.paymentFrequency?.period; 

                        xmlDados.fixedLeg_Payment_Dates_PayRelativeTo = swapStream_Iterator?.paymentDates?.payRelativeTo;      

                        xmlDados.fixedLeg_Payment_Dates_Business_Convention = swapStream_Iterator?.paymentDates?.paymentDatesAdjustments?.businessDayConvention;    

                        if(swapStream_Iterator?.paymentDates?.paymentDatesAdjustments?.businessCenters?.businessCenter != null)
                        {
                            tmp = "";
                            for (int i = 0; i < swapStream_Iterator?.paymentDates?.paymentDatesAdjustments?.businessCenters?.businessCenter?.Count; i++)
                            {
                                if (i == 0)
                                    tmp = swapStream_Iterator?.paymentDates?.paymentDatesAdjustments?.businessCenters?.businessCenter?[i];
                                else
                                    tmp = tmp + ";" + swapStream_Iterator?.paymentDates?.paymentDatesAdjustments?.businessCenters?.businessCenter?[i];
                            }
                            xmlDados.fixedLeg_Payment_Dates_Business_Convention_Business_Centers = tmp;
                        }

                        xmlDados.fixedLeg_Payments_Day_Offset_Multiplier = swapStream_Iterator?.paymentDates?.paymentDaysOffset?.periodMultiplier; 

                        xmlDados.fixedLeg_Payments_Day_Offset_Period = swapStream_Iterator?.paymentDates?.paymentDaysOffset?.period;       

                        xmlDados.fixedLeg_Payments_Day_Offset_Day_Type = swapStream_Iterator?.paymentDates?.paymentDaysOffset?.dayType;    

                        xmlDados.fixedLeg_Notional_Amount = swapStream_Iterator?.calculationPeriodAmount?.calculation?.notionalSchedule?.notionalStepSchedule?.initialValue;  

                        xmlDados.fixedLeg_Notional_Amount_Currency = swapStream_Iterator?.calculationPeriodAmount?.calculation?.notionalSchedule?.notionalStepSchedule?.currency;

                        xmlDados.fixedLeg_Fixed_Rate = swapStream_Iterator?.calculationPeriodAmount?.calculation?.fixedRateSchedule?.initialValue; 

                        xmlDados.fixedLeg_Fixed_Rate_Day_Count_Fraction = swapStream_Iterator?.calculationPeriodAmount?.calculation?.dayCountFraction;  

                        xmlDados.fixedLeg_CashFlows_Match_Parameters = swapStream_Iterator?.cashflows?.cashflowsMatchParameters;    

                        xmlDados.fixedLeg_CashFlows_Payment_Unadjusted_Payment_Date = swapStream_Iterator?.cashflows?.paymentCalculationPeriod?.unadjustedPaymentDate;

                        xmlDados.fixedLeg_CashFlows_Payment_Fixed_Payment_Amount = swapStream_Iterator?.cashflows?.paymentCalculationPeriod?.fixedPaymentAmount;      
                    }


                    // Floating Leg

                    if (swapStream_Iterator?.id == "floatingLeg")
                    {
                        xmlDados.floatingLeg_Payer = swapStream_Iterator?.payerPartyReference?.href;   

                        xmlDados.floatingLeg_Receiver = swapStream_Iterator?.receiverPartyReference?.href;    

                        xmlDados.floatingLeg_Effective_Date = swapStream_Iterator?.calculationPeriodDates?.effectiveDate?.unadjustedDate;    

                        xmlDados.floatingLeg_Effective_Date_Adjustments = swapStream_Iterator?.calculationPeriodDates?.effectiveDate?.dateAdjustments?.businessDayConvention;   

                        xmlDados.floatingLeg_Termination_Date = swapStream_Iterator?.calculationPeriodDates?.terminationDate?.unadjustedDate; 

                        xmlDados.floatingLeg_Termination_Date_Adjustments = swapStream_Iterator?.calculationPeriodDates?.terminationDate?.dateAdjustments?.businessDayConvention;       

                        xmlDados.floatingLeg_Calculation_Period_Dates_Adjustments = swapStream_Iterator?.calculationPeriodDates?.calculationPeriodDatesAdjustments?.businessDayConvention;   

                        xmlDados.floatingLeg_Calculation_Period_Frequency_Multiplier = swapStream_Iterator?.calculationPeriodDates?.calculationPeriodFrequency?.periodMultiplier;   

                        xmlDados.floatingLeg_Calculation_Period_Frequency = swapStream_Iterator?.calculationPeriodDates?.calculationPeriodFrequency?.period; 

                        xmlDados.floatingLeg_Calculation_Period_Frequency_Roll_Convention = swapStream_Iterator?.calculationPeriodDates?.calculationPeriodFrequency?.rollConvention; 

                        xmlDados.floatingLeg_Payment_Frequency_Period_Multiplier = swapStream_Iterator?.paymentDates?.paymentFrequency?.periodMultiplier;

                        xmlDados.floatingLeg_Payment_Frequency_Period = swapStream_Iterator?.paymentDates?.paymentFrequency?.period;

                        xmlDados.floatingLeg_Payment_Dates_PayRelativeTo = swapStream_Iterator?.paymentDates?.payRelativeTo;      

                        xmlDados.floatingLeg_Payment_Dates_Business_Convention = swapStream_Iterator?.paymentDates?.paymentDatesAdjustments?.businessDayConvention;       

                        if(swapStream_Iterator?.paymentDates?.paymentDatesAdjustments?.businessCenters?.businessCenter != null)
                        {
                            tmp = "";
                            for (int i = 0; i < swapStream_Iterator?.paymentDates?.paymentDatesAdjustments?.businessCenters?.businessCenter?.Count; i++)
                            {
                                if (i == 0)
                                    tmp = swapStream_Iterator?.paymentDates?.paymentDatesAdjustments?.businessCenters?.businessCenter?[i];
                                else
                                    tmp = tmp + ";" + swapStream_Iterator?.paymentDates?.paymentDatesAdjustments?.businessCenters?.businessCenter?[i];
                            }
                            xmlDados.floatingLeg_Payment_Dates_Business_Convention_Business_Centers = tmp;  
                        }

                        xmlDados.floatingLeg_Payments_Day_Offset_Multiplier = swapStream_Iterator?.paymentDates?.paymentDaysOffset?.periodMultiplier;    

                        xmlDados.floatingLeg_Payments_Day_Offset_Period = swapStream_Iterator?.paymentDates?.paymentDaysOffset?.period;

                        xmlDados.floatingLeg_Payments_Day_Offset_Day_Type = swapStream_Iterator?.paymentDates?.paymentDaysOffset?.dayType;  

                        xmlDados.floatingLeg_Fixing_Reset_Related_To = swapStream_Iterator?.resetDates?.resetRelativeTo;

                        xmlDados.floatingLeg_Fixing_Dates_Multiplier = swapStream_Iterator?.resetDates?.fixingDates?.periodMultiplier; 

                        xmlDados.floatingLeg_Fixing_Dates_Period = swapStream_Iterator?.resetDates?.fixingDates?.period;       

                        xmlDados.floatingLeg_Fixing_Day_Convention = swapStream_Iterator?.resetDates?.fixingDates?.businessDayConvention;       

                        if(swapStream_Iterator?.resetDates?.fixingDates?.businessCenters?.businessCenter != null)
                        {
                            tmp = "";
                            for (int i = 0; i < swapStream_Iterator?.resetDates?.fixingDates?.businessCenters?.businessCenter?.Count; i++)
                            {
                                if (i == 0)
                                    tmp = swapStream_Iterator?.resetDates?.fixingDates?.businessCenters?.businessCenter?[i];
                                else
                                    tmp = tmp + ";" + swapStream_Iterator?.resetDates?.fixingDates?.businessCenters?.businessCenter?[i];
                            }
                            xmlDados.floatingLeg_Fixing_Day_Business_Center = tmp;     
                        }

                        xmlDados.floatingLeg_Reset_Frequency_Multiplier = swapStream_Iterator?.resetDates?.resetFrequency?.periodMultiplier;        

                        xmlDados.floatingLeg_Reset_Frequency_Period = swapStream_Iterator?.resetDates?.resetFrequency?.period;      

                        xmlDados.floatingLeg_Reset_Date_Adjustment = swapStream_Iterator?.resetDates?.resetDatesAdjustments?.businessDayConvention;    

                        if(swapStream_Iterator?.resetDates?.resetDatesAdjustments?.businessCenters?.businessCenter != null)
                        {
                            tmp = "";
                            for (int i = 0; i < swapStream_Iterator?.resetDates?.resetDatesAdjustments?.businessCenters?.businessCenter?.Count; i++)
                            {
                                if (i == 0)
                                    tmp = swapStream_Iterator?.resetDates?.resetDatesAdjustments?.businessCenters?.businessCenter?[i];
                                else
                                    tmp = tmp + ";" + swapStream_Iterator?.resetDates?.resetDatesAdjustments?.businessCenters?.businessCenter?[i];
                            }
                            xmlDados.floatingLeg_Reset_Date_Business_Center = tmp;     
                        }

                        xmlDados.floatingLeg_Notional_Amount = swapStream_Iterator?.calculationPeriodAmount?.calculation?.notionalSchedule?.notionalStepSchedule?.initialValue; 

                        xmlDados.floatingLeg_Notional_Amount_Currency = swapStream_Iterator?.calculationPeriodAmount?.calculation?.notionalSchedule?.notionalStepSchedule?.currency;

                        // tipo1

                        xmlDados.floatingLeg_floatingRateCalculation_Index = swapStream_Iterator?.calculationPeriodAmount?.calculation?.floatingRateCalculation?.floatingRateIndex; 

                        xmlDados.floatingLeg_floatingRateCalculation_Index_Frequency_Multiplier = swapStream_Iterator?.calculationPeriodAmount?.calculation?.floatingRateCalculation?.indexTenor?.periodMultiplier;   

                        xmlDados.floatingLeg_floatingRateCalculation_Index_Frequency_Period = swapStream_Iterator?.calculationPeriodAmount?.calculation?.floatingRateCalculation?.indexTenor?.period; 

                        xmlDados.floatingLeg_floatingRateCalculation_Index_Source = null;

                        xmlDados.floatingLeg_floatingRateCalculation_Inflation_Rate_Interpolation_Method = null;   

                        xmlDados.floatingLeg_floatingRateCalculation_Inflation_Rate_Level = null;       

                        xmlDados.floatingLeg_floatingRateCalculation_DayCountFraction = swapStream_Iterator?.calculationPeriodAmount?.calculation?.dayCountFraction;   

                        xmlDados.floatingLeg_floatingRateCalculation_Spread = swapStream_Iterator?.calculationPeriodAmount?.calculation?.floatingRateCalculation?.spreadSchedule?.initialValue;

                        // tipo 2

                        xmlDados.floatingLeg_inflationRateCalculation_Index = swapStream_Iterator?.calculationPeriodAmount?.calculation?.inflationRateCalculation?.floatingRateIndex;

                        xmlDados.floatingLeg_inflationRateCalculation_Index_Frequency_Multiplier = swapStream_Iterator?.calculationPeriodAmount?.calculation?.inflationRateCalculation?.inflationLag?.periodMultiplier;

                        xmlDados.floatingLeg_inflationRateCalculation_Index_Frequency_Period = swapStream_Iterator?.calculationPeriodAmount?.calculation?.inflationRateCalculation?.inflationLag?.period;

                        xmlDados.floatingLeg_inflationRateCalculation_Index_Source = swapStream_Iterator?.calculationPeriodAmount?.calculation?.inflationRateCalculation?.indexSource?.text;

                        xmlDados.floatingLeg_inflationRateCalculation_Inflation_Rate_Interpolation_Method = swapStream_Iterator?.calculationPeriodAmount?.calculation?.inflationRateCalculation?.interpolationMethod;

                        xmlDados.floatingLeg_inflationRateCalculation_Inflation_Rate_Level = swapStream_Iterator?.calculationPeriodAmount?.calculation?.inflationRateCalculation?.initialIndexLevel; 

                        xmlDados.floatingLeg_inflationRateCalculation_DayCountFraction = null;   

                        xmlDados.floatingLeg_inflationRateCalculation_Spread = swapStream_Iterator?.calculationPeriodAmount?.calculation?.inflationRateCalculation?.spreadSchedule?.initialValue;  
                    }
                }

                // payment

                xmlDados.payment_Payer = xmlObject?.swStructuredTradeDetails?.FpML?.trade?.swap?.additionalPayment?.payerPartyReference?.href; 

                xmlDados.payment_Receiver = xmlObject?.swStructuredTradeDetails?.FpML?.trade?.swap?.additionalPayment?.receiverPartyReference?.href;     

                xmlDados.payment_Payment_Amount = xmlObject?.swStructuredTradeDetails?.FpML?.trade?.swap?.additionalPayment?.paymentAmount?.amount;      

                xmlDados.payment_Payment_Currency = xmlObject?.swStructuredTradeDetails?.FpML?.trade?.swap?.additionalPayment?.paymentAmount?.currency;  

                xmlDados.payment_Payment_Date = xmlObject?.swStructuredTradeDetails?.FpML?.trade?.swap?.additionalPayment?.paymentDate?.unadjustedDate;  

                xmlDados.payment_Payment_Day_Business_Day_Convention = xmlObject?.swStructuredTradeDetails?.FpML?.trade?.swap?.additionalPayment?.paymentDate?.dateAdjustments?.businessDayConvention;

                if(xmlObject?.swStructuredTradeDetails?.FpML?.trade?.swap?.additionalPayment?.paymentDate?.dateAdjustments?.businessCenters?.businessCenter?.Count > 0)
                {
                    tmp = "";
                    for (int i = 0; i < xmlObject?.swStructuredTradeDetails?.FpML?.trade?.swap?.additionalPayment?.paymentDate?.dateAdjustments?.businessCenters?.businessCenter?.Count; i++)
                    {
                        if (i == 0)
                            tmp = xmlObject?.swStructuredTradeDetails?.FpML?.trade?.swap?.additionalPayment?.paymentDate?.dateAdjustments?.businessCenters?.businessCenter?[i];
                        else
                            tmp = tmp + ";" + xmlObject?.swStructuredTradeDetails?.FpML?.trade?.swap?.additionalPayment?.paymentDate?.dateAdjustments?.businessCenters?.businessCenter?[i];
                    }
                    xmlDados.payment_Payment_Day_Business_Day = tmp; 
                }

                List<String> teste = xmlObject?.swStructuredTradeDetails?.FpML?.trade?.swap?.additionalPayment?.paymentDate?.dateAdjustments?.businessCenters?.businessCenter;
                if (teste != null)
                {
                    tmp = String.Join(";", xmlObject?.swStructuredTradeDetails?.FpML?.trade?.swap?.additionalPayment?.paymentDate?.dateAdjustments?.businessCenters?.businessCenter?.ToArray());

                }



                xmlDados.payment_Reason = xmlObject?.swStructuredTradeDetails?.FpML?.trade?.swap?.additionalPayment?.paymentDate?.paymentType;     


                // exchange

                xmlDados.exchange_Client_Clearing = xmlObject?.swStructuredTradeDetails?.swExtendedTradeDetails?.swTradeHeader?.swClientClearing;   

                xmlDados.exchange_Bilateral_Clearing_House = xmlObject?.swStructuredTradeDetails?.swExtendedTradeDetails?.swTradeHeader?.swClearingHouse?.partyId;  


                // swStructuredTradeDetails

                foreach(party? party_Iterator in xmlObject?.swStructuredTradeDetails?.FpML?.party)
                {
                    if (party_Iterator.id == "partyA")
                    {
                        xmlDados.swStructuredTradeDetails_Party_A_Alocation_ID = party_Iterator.partyId;
                        xmlDados.swStructuredTradeDetails_Party_A_Alocation_Name = party_Iterator.partyName;
                    }

                    if (party_Iterator.id == "partyB")
                    {
                        xmlDados.swStructuredTradeDetails_Party_B_Alocation_ID = party_Iterator.partyId;
                        xmlDados.swStructuredTradeDetails_Party_B_Alocation_Name = party_Iterator.partyName;
                    }
                }

            }
            catch (Exception e)
            {
                throw e;
            }

            // Retorno dos dados linearizados

            return xmlDados;
        }
    }
}
