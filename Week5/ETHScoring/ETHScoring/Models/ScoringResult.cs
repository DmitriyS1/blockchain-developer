namespace ETHScoring.Models
{
    public class ScoringResult
    {
        public int CountOfTransactions { get; set; }

        public bool IsShopCustomer { get; set; }

        public int ShoppingTransactionsCount { get; set; }

        public int MeanShoppingTransaction { get; set; }



        public bool IsCreditApproved { get; set; }
        public int Score { get; set; }
    }
}
