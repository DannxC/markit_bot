using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class calculationPeriodDates        // Father: swapStream
    {
        [XmlElement("effectiveDate")]
        public effectiveDate? effectiveDate { get; set; }

        [XmlElement("terminationDate")]
        public terminationDate? terminationDate { get; set; }

        [XmlElement("calculationPeriodDatesAdjustments")]
        public calculationPeriodDatesAdjustments? calculationPeriodDatesAdjustments { get; set; }

        [XmlElement("calculationPeriodFrequency")]
        public calculationPeriodFrequency? calculationPeriodFrequency { get; set; }

        // Constructor
        public calculationPeriodDates()
        {
            effectiveDate = new effectiveDate();
            terminationDate = new terminationDate();
            calculationPeriodDatesAdjustments = new calculationPeriodDatesAdjustments();
            calculationPeriodFrequency = new calculationPeriodFrequency();
        }
    }
}
