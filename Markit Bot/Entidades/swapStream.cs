using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class swapStream        // Father: swap
    {
        // Attributes do Node

        [XmlAttribute("id")]
        public string? id { get; set; }

        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("payerPartyReference")]
        public payerPartyReference? payerPartyReference { get; set; }       // Leaf

        [XmlElement("receiverPartyReference")]
        public receiverPartyReference? receiverPartyReference { get; set; }     // Leaf

        [XmlElement("calculationPeriodDates")]
        public calculationPeriodDates? calculationPeriodDates { get; set; }

        [XmlElement("paymentDates")]
        public paymentDates? paymentDates { get; set; }

        [XmlElement("resetDates")]
        public resetDates? resetDates { get; set; }

        [XmlElement("calculationPeriodAmount")]
        public calculationPeriodAmount? calculationPeriodAmount { get; set; }

        [XmlElement("cashflows")]
        public cashflows? cashflows { get; set; }


        // Constructor

        public swapStream()
        {
            payerPartyReference = new payerPartyReference();
            receiverPartyReference = new receiverPartyReference();
            calculationPeriodDates = new calculationPeriodDates();
            paymentDates = new paymentDates();
            resetDates = new resetDates();
            calculationPeriodAmount = new calculationPeriodAmount();
            cashflows = new cashflows();
        }
    }
}
