import "../models/file.tsp";
import "../common/error.tsp";

using TypeSpec.Http;

namespace OdptAPI;

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
