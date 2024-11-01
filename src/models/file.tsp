import "../common/class.tsp";

using TypeSpec.Http;

@doc("ファイルリンクへのリダイレクト")
model FileRedirect {
  @statusCode _: 302;
}
