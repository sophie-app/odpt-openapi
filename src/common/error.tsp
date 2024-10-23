import "@typespec/http";

using TypeSpec.Http;

namespace Common;

@doc("パラメータ不正")
model BadRequestResponse {
  @statusCode _: 400;
}

@doc("acl:consumerKeyが誤っている")
model UnauthorizedResponse {
  @statusCode _: 401;
}

@doc("権限なし")
model ForbiddenResponse {
  @statusCode _: 403;
}

@doc("該当データ無し")
model NotFoundResponse {
  @statusCode _: 404;
}

@doc("サーバー内部エラー")
model InternalServerErrorResponse {
  @statusCode _: 500;
}

@doc("サービス利用不可")
model ServiceUnavailableResponse {
  @statusCode _: 503;
}

alias Error =
  | BadRequestResponse
  | UnauthorizedResponse
  | ForbiddenResponse
  | NotFoundResponse
  | InternalServerErrorResponse
  | ServiceUnavailableResponse;
