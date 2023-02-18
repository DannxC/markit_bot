using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class payerPartyReference        // Father1: swapStream - Father2: receiverPartyReference
    {
        // Attributes do Node
        
        [XmlAttribute]
        public string? href { get; set; }

        // Constructor
    }
}
