using ETHScoring.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
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

        private const string ETHERSCAN_ADDRESS = "https://api.etherscan.io/api";

        public ScoringController(
            ILogger<ScoringController> logger,
            IHttpClientFactory httpClientFactory)
        {
            _logger = logger;
            _httpClientFactory = httpClientFactory;
        }

        [HttpGet]
        public async Task<IActionResult> ScoreAsync(
            [FromRoute] string address, 
            [FromQuery] string shopAddress,
            CancellationToken ct = default)
        {
            var transactions = await GetTransactions(address, ct);
        }

        private async Task<List<TransactionItem>> GetTransactions(string address, CancellationToken ct)
        {
            var requestAddress = $@"{ETHERSCAN_ADDRESS}?module=account
   &action=txlist
   &address={address}
   &startblock=11967948
   &endblock=99999999
   &page=1
   &offset=100
   &sort=desc
   &apikey={444}";

            var request = new HttpRequestMessage(
                HttpMethod.Get,
                requestAddress)
            {
                Headers =
                {
                    { HeaderNames.UserAgent, "" }
                }
            };

            var httpClient = _httpClientFactory.CreateClient();
            var response = await httpClient.SendAsync(request, ct);
            var transactions = new List<TransactionItem>();
            if (response.IsSuccessStatusCode)
            {
                using var contentStream = await response.Content.ReadAsStreamAsync();
                var transactionsResponse = await JsonSerializer.DeserializeAsync<TransactionResponse>(contentStream);
                transactions = transactionsResponse.Result;
            }

            return transactions;
        }
    }
}
