using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Entidades
{
    [Serializable]
    public class additionalPayment        // Father: swap
    {
        // Declarando filhos como Attributes e como XmlElements

        [XmlElement("payerPartyReference")]
        public payerPartyReference? payerPartyReference { get; set; }       // Leaf

        [XmlElement("receiverPartyReference")]
        public receiverPartyReference? receiverPartyReference { get; set; }       // Leaf

        [XmlElement("paymentAmount")]
        public paymentAmount? paymentAmount { get; set; }

        [XmlElement("paymentDate")]
        public paymentDate? paymentDate { get; set; }

        // Constructor

        public additionalPayment()
        {
            payerPartyReference = new payerPartyReference();
            receiverPartyReference = new receiverPartyReference();
            paymentAmount = new paymentAmount();
            paymentDate = new paymentDate();
        }
    }
}
