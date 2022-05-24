using ETHScoring.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using Microsoft.Net.Http.Headers;
using System.Text.Json;

namespace ETHScoring.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ScoringController : ControllerBase
    {
        private readonly ILogger<ScoringController> _logger;
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly ApiKey _apiKey;

        private const string ETHERSCAN_ADDRESS = "https://api.etherscan.io/api";

        public ScoringController(
            ILogger<ScoringController> logger,
            IHttpClientFactory httpClientFactory,
            IOptions<ApiKey> apiKeyOptions)
        {
            _logger = logger;
            _httpClientFactory = httpClientFactory;
            _apiKey = apiKeyOptions.Value;
        }

        [HttpGet]
        public async Task<IActionResult> ScoreAsync(
            [FromQuery] string address, 
            [FromQuery] string shopAddress,
            CancellationToken ct = default)
        {
            var transactions = await GetTransactions(address, ct);
            // Full year of transactions (more than 100, more than 70, more than 50)
            // Transactions for the particular shop (more than 5, more than 2, 1)
            // Not only input transactions (input/output: 50/50, 25/75, 75/25)
            // Сделать займ, а передавать покупку только после полной оплаты
            return Ok(transactions);
        }

        private async Task<List<TransactionItem>> GetTransactions(string address, CancellationToken ct)
        {
            var requestAddress = $"{ETHERSCAN_ADDRESS}?module=account&action=txlist&address={address}&startblock=11967948&endblock=99999999&page=1&offset=100&sort=desc&apikey={_apiKey.Value}";

            var request = new HttpRequestMessage(
                HttpMethod.Get,
                requestAddress) {};

            var httpClient = _httpClientFactory.CreateClient();
            var response = await httpClient.SendAsync(request, ct);
            var transactions = new List<TransactionItem>();
            if (response.IsSuccessStatusCode)
            {
                var d = new JsonSerializerOptions()
                {
                    PropertyNameCaseInsensitive = true
                };
                using var contentStream = await response.Content.ReadAsStreamAsync();
                var transactionsResponse = await JsonSerializer.DeserializeAsync<TransactionResponse>(contentStream, d);
                transactions = transactionsResponse?.Result;
            }

            return transactions;
        }
    }
}
