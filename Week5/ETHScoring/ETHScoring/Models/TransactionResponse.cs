using System.Text.Json.Serialization;

namespace ETHScoring.Models
{
    public class TransactionItem
    {
        public uint BlockNumber { get; set; }

        public uint TimeStamp { get; set; }

        public string Hash { get; set; }

        public uint Nonce { get; set; }

        public string BlockHash { get; set; }

        public string TransactionIndex { get; set; }

        public string From { get; set; }

        public string To { get; set; }

        public string Value { get; set; }

        public uint Gas { get; set; }

        public uint GasPrice { get; set; }

        public uint IsError { get; set; }

        [JsonPropertyName("txreceipt_status")]
        public string TxReceiptStatus { get; set; }

        public string Input { get; set; }

        public string ContractAddress { get; set; }

        public string CumulativeGasUsed { get; set; }

        public string GasUsed { get; set; }

        public uint Confirmations { get; set; }
    }

    public class TransactionResponse {
        public string Status { get; set; }

        public string Message { get; set; }

        public List<TransactionItem> Result { get; set; }
    }
}
