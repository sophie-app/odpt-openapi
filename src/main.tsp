import "@typespec/http";
import "@typespec/openapi";
import "./routes/index.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

@service({
  title: "ODPT API",
})
@server("https://api.odpt.org/api/v4", "公共交通のオープンデータ API")
@server(
  "https://api-challenge2024.odpt.org/api/v4",
  "公共交通のオープンデータ API (チャレンジ2024専用)"
)
@info({
  license: {
    name: "公共交通オープンデータ基本ライセンス, 公共交通オープンデータチャレンジ限定ライセンス",
    url: "https://developer.odpt.org/terms",
  },
})
@useAuth(ApiKeyAuth<ApiKeyLocation.query, "acl:consumerKey">)
namespace OdptAPI;
