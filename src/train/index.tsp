import "@typespec/http";
import "@typespec/rest";
import "../common/class.tsp";
import "../common/error.tsp";

@service({
  title: "ODPT Train API",
})
@server("https://api.odpt.org/api/v4", "API サーバー")
@doc("電車に関連するデータを提供するAPI")
namespace TrainAPI;

using TypeSpec.Http;
using TypeSpec.Rest;
