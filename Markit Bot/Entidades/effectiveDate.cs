using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class effectiveDate        // Father: calculationPeriodDates
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("unadjustedDate")]
        public DateTime? unadjustedDate { get; set; }       // Leaf

        [XmlElement("dateAdjustments")]
        public dateAdjustments? dateAdjustments { get; set; }

        // Constructor

        public effectiveDate()
        {
            dateAdjustments = new dateAdjustments();
        }
    }
}
