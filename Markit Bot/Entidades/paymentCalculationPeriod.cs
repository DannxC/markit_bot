using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class paymentCalculationPeriod        // Father: cashflows
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("unadjustedPaymentDate")]
        public DateTime? unadjustedPaymentDate { get; set; }        // Leaf

        [XmlElement("fixedPaymentAmount")]
        public double? fixedPaymentAmount { get; set; }     // Leaf

    }
}
