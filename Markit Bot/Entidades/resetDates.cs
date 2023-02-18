using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class resetDates     // Father: swapStream
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("resetRelativeTo")]
        public string? resetRelativeTo { get; set; }        // Leaf

        [XmlElement("fixingDates")]
        public fixingDates? fixingDates { get; set; }

        [XmlElement("resetFrequency")]
        public resetFrequency? resetFrequency { get; set; }

        [XmlElement("resetDatesAdjustments")]
        public resetDatesAdjustments? resetDatesAdjustments { get; set; }

        // Constructor

        public resetDates()
        {
            fixingDates = new fixingDates();
            resetFrequency = new resetFrequency();
            resetDatesAdjustments = new resetDatesAdjustments();
        }
    }
}
