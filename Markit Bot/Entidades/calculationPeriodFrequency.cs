using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class calculationPeriodFrequency         // Father: calculationPeriodDates
    {
        [XmlElement("periodMultiplier")]
        public long? periodMultiplier { get; set; }      // Leaf

        public string? period { get; set; }     // Leaf

        public string? rollConvention { get; set; }     // Leaf
    }
}
