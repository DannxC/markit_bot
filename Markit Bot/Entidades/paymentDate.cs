using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class paymentDate        // Father: additionalPayment
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("unadjustedDate")]
        public DateTime? unadjustedDate { get; set; }       // Leaf

        [XmlElement("dateAdjustments")]
        public dateAdjustments? dateAdjustments { get; set; }

        [XmlElement("paymentType")]
        public string? paymentType { get; set; }        // Leaf

        // Constructor

        public paymentDate()
        {
            dateAdjustments = new dateAdjustments();
        }
    }
}
