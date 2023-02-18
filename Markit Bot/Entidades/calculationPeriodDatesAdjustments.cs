using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class calculationPeriodDatesAdjustments        // Father: calculationPeriodDates
    {
        [XmlElement("businessDayConvention")]
        public string? businessDayConvention { get; set; }      // Leaf
    }
}
