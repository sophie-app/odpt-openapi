import "@typespec/http";
import "./routes/index.tsp";

using TypeSpec.Http;

@service({
  title: "ODPT API",
})
@server("https://api.odpt.org/api/v4", "公共交通のオープンデータ API")
@server(
  "https://api-challenge2024.odpt.org/api/v4",
  "公共交通のオープンデータ API (チャレンジ2024専用)"
)
@useAuth(ApiKeyAuth<ApiKeyLocation.query, "acl:consumerKey">)
namespace OdptAPI;
