using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class resetDatesAdjustments     // Father: resetDates
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("businessDayConvention")]
        public string? businessDayConvention { get; set; }      // Leaf

        [XmlElement("businessCenters")]
        public businessCenters? businessCenters { get; set; }

        // Constructor

        public resetDatesAdjustments()
        {
            businessCenters = new businessCenters();
        }
    }
}
