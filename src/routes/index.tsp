import "@typespec/http";
import "../common/class.tsp";
import "../common/error.tsp";

import "./train.tsp";
import "./bus.tsp";
import "./airplane.tsp";
import "./file.tsp";
import "./search.tsp";

using TypeSpec.Http;

namespace OdptAPI;

@route("/odpt/Calendar")
interface CalendarOperations {
  @doc("曜日・日付区分(odpt:Calendar)の内容を取得する")
  @get
  getCalendars(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子") `@id`?: URN,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: url,
  ): Calendar[] | Common.Error;
}

@route("/Operator")
interface OperatorOperations {
  @doc("公共交通機関の事業者(odpt:Operator)の内容を取得する")
  @get
  getOperators(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子") `@id`?: URN,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: url,
  ): Operator[] | Common.Error;
}
