using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class businessCenters        // Father1: paymentDatesAdjustments - Father2: fixingDates - Father3: resetDatesAdjustments -- Father 4? dateAdjustments
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("businessCenter")]
        public List<string>? businessCenter { get; set; }       // Leaf

        // Constructor

        public businessCenters()
        {
            businessCenter = new List<string>();
        }
    }
}
