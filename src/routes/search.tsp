import "../models/search.tsp";
import "../common/error.tsp";

using TypeSpec.Http;

namespace OdptAPI;

@route("/{RDF_TYPE}")
interface DataSearchOperations {
  @summary("データ検索API")
  @get
  search(
    @path
    @doc("取得するデータの種別 odpt:クラス名")
    RDF_TYPE: `odpt.url`,

    @query
    @doc("rdf:typeで指定したクラスの持つプロパティを指定して、フィルタリングを行う")
    PREDICATE?: string,
  ): DataSearchResponse[] | Common.Error;
}

@route("/{RDF_TYPE}.json")
interface DataDumpOperations {
  @summary("データダンプAPI")
  @get
  dump(
    @path @doc("取得するデータの種別 odpt:クラス名") RDF_TYPE: DumpRDFType,
  ): DumpResponse[] | Common.Error;
}

@route("/datapoints/{DATA_URI}")
interface DataRetrieveOperations {
  @summary("データ取得API")
  @get
  retrieve(
    @path @doc("取得するデータのURI") DATA_URI: URN | `odpt.url`,
  ): RetrieveResponse[] | Common.Error;
}

@route("/places/{RDF_TYPE}")
interface PlaceSearchOperations {
  @summary("地物情報検索API")
  @get
  search(
    @path @doc("取得するデータの種別") RDF_TYPE: PlaceRDFType,
    @query @doc("取得する範囲の中心緯度、10進数表記、測地系はWGS84") lat: float,
    @query @doc("取得する範囲の中心経度、10進数表記、測地系はWGS84") lon: float,
    @query @doc("取得する範囲の半径をメートルで指定、0-4000mの範囲") radius: integer,

    @query
    @doc("rdf:typeで指定したクラスの持つプロパティを指定して、フィルタリングを行う")
    PREDICATE?: string,
  ): PlaceSearchResponse[] | Common.Error;
}
