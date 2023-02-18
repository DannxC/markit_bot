using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class terminationDate        // Father: calculationPeriodDates
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("unadjustedDate")]
        public DateTime? unadjustedDate { get; set; }       // Leaf

        [XmlElement("dateAdjustments")]
        public dateAdjustments? dateAdjustments { get; set; }

        // Constructor
        public terminationDate()
        {
            dateAdjustments = new dateAdjustments();
        }
    }
}
