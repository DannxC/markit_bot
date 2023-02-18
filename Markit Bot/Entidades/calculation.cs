using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class calculation        // Father: calculationPeriodAmount
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("notionalSchedule")]
        public notionalSchedule? notionalSchedule { get; set; }

        [XmlElement("fixedRateSchedule")]
        public fixedRateSchedule? fixedRateSchedule { get; set; }

        [XmlElement("floatingRateCalculation")]     // tipo 1
        public floatingRateCalculation? floatingRateCalculation { get; set; }

        [XmlElement("inflationRateCalculation")]    // tipo 2
        public inflationRateCalculation? inflationRateCalculation { get; set; }

        [XmlElement("dayCountFraction")]
        public string? dayCountFraction { get; set; }       // Leaf

        // Constructor

        public calculation()
        {
            notionalSchedule = new notionalSchedule();
            fixedRateSchedule = new fixedRateSchedule();
            floatingRateCalculation = new floatingRateCalculation();
            inflationRateCalculation = new inflationRateCalculation();
        }
    }
}
