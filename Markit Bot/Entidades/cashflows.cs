using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class cashflows        // Father: swapStream
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("cashflowsMatchParameters")]
        public bool? cashflowsMatchParameters { get; set; }     // Leaf

        [XmlElement("paymentCalculationPeriod")]
        public paymentCalculationPeriod? paymentCalculationPeriod { get; set; }

        // Constructor

        public cashflows()
        {
            paymentCalculationPeriod = new paymentCalculationPeriod();
        }
    }
}
