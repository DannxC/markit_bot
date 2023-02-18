using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class calculationPeriodDatesReference        // Father: paymentDates
    {
        // Attributes do Node

        [XmlAttribute("href")]
        public string? href { get; set; }
    }
}
