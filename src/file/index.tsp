import "@typespec/http";
import "@typespec/rest";
import "../common/class.tsp";
import "../common/error.tsp";

@service({
  title: "ODPT File API",
})
@server("https://api.odpt.org/api/v4", "API サーバー")
@doc("配布されるファイルを取得するためのAPI")
@useAuth(ApiKeyAuth<ApiKeyLocation.query, "acl:consumerKey">)
namespace BusAPI;

using TypeSpec.Http;
using TypeSpec.Rest;

@doc("ファイルリンクへのリダイレクト")
model FileRedirect {
  @statusCode _: 302;
}

@doc("各社提供ファイル取得用API")
@route("/files/{filePath}")
interface FilesOperations {
  @summary("ファイルを取得する")
  @get
  getFiles(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @path @doc("ファイルパス") filePath: string,
  ): FileRedirect | Common.Error;
}
