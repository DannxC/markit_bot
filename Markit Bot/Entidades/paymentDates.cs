using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class paymentDates        // Father: swapStream
    {
        // Declarando filhos como Attributes e como XmlElements
        
        [XmlElement("calculationPeriodDatesReference")]
        public calculationPeriodDatesReference? calculationPeriodDatesReference { get; set; }       // Leaf

        [XmlElement("paymentFrequency")]
        public paymentFrequency? paymentFrequency { get; set; }

        [XmlElement("payRelativeTo")]
        public string? payRelativeTo { get; set; }      // Leaf

        [XmlElement("paymentDaysOffset")]
        public paymentDaysOffset? paymentDaysOffset { get; set; }

        [XmlElement("paymentDatesAdjustments")]
        public paymentDatesAdjustments? paymentDatesAdjustments { get; set; }

        // Constructor

        public paymentDates()
        {
            calculationPeriodDatesReference = new calculationPeriodDatesReference();
            paymentFrequency = new paymentFrequency();
            paymentDaysOffset = new paymentDaysOffset();
            paymentDatesAdjustments = new paymentDatesAdjustments();
        }
    }
}
