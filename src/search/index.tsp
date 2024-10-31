import "@typespec/http";
import "@typespec/rest";
import "../common/class.tsp";
import "../common/error.tsp";

@service({
  title: "ODPT Search API",
})
@server("https://api.odpt.org/api/v4", "API サーバー")
@doc("ODPTの各種データ検索のためのAPI")
@useAuth(ApiKeyAuth<ApiKeyLocation.query, "acl:consumerKey">)
namespace SearchAPI;

using TypeSpec.Http;
using TypeSpec.Rest;

@doc("データ検索APIのレスポンス")
model DataSearchResponse {
  @doc("JSON-LD仕様に基づく @context のURL")
  @example("http://vocab.odpt.org/context_odpt_Train.jsonld")
  `@context`: url;

  @doc("固有識別子(ucode)")
  @example("urn:ucode:_00001C000000000000010000030FD5D6")
  `@id`: URN;

  @doc("クラス名")
  @example("odpt:Train")
  `@type`: string;

  @doc("データ生成日時")
  @example("2017-11-28T11:02:15+09:00")
  `dc:date`: DateTime;

  @doc("データの保証期限")
  @example("2017-11-28T11:02:45+09:00")
  `dct:valid`: DateTime;

  @doc("更新頻度(秒)、指定された秒数以降にリクエストを行うことで、最新値が取得される。")
  @example(30)
  `odpt:frequency`: integer;

  @doc("路線を表すID")
  @example("odpt.Railway:TokyoMetro.Yurakucho")
  `odpt:railway`: `odpt.url`;

  @doc("固有識別子 odpt.Train:会社名.路線名.列車番号")
  @example("odpt.Train:TokyoMetro.Yurakucho.B1045S")
  `owl:sameAs`: `odpt.url`;

  @doc("列車番号")
  @example("B1045S")
  `odpt:trainNumber`: string;

  @doc("列車種別")
  @example("odpt.TrainType:TokyoMetro.Local")
  `odpt:trainType`: `odpt.url`;

  @doc("遅延時間(秒)")
  @example(0)
  `odpt:delay`?: integer;

  @doc("列車の始発駅のIDのリスト")
  @example(#["odpt.Station:TokyoMetro.Yurakucho.ShinKiba"])
  `odpt:originStation`: `odpt.url`[];

  @doc("列車の終着駅のIDのリスト")
  @example(#["odpt.Station:TokyoMetro.Yurakucho.Wakoshi"])
  `odpt:destinationStation`: `odpt.url`[];

  @doc("列車が直前に出た駅、あるいは停車中の駅を表すID")
  @example("odpt.Station:TokyoMetro.Yurakucho.ChikatetsuNarimasu")
  `odpt:fromStation`: `odpt.url`;

  @doc("列車が向かっている駅を表すID")
  @example("odpt.Station:TokyoMetro.Yurakucho.Wakoshi")
  `odpt:toStation`: `odpt.url`;

  @doc("進行方向を表すID")
  @example("odpt.RailDirection:TokyoMetro.Wakoshi")
  `odpt:railDirection`: `odpt.url`;

  @doc("運行会社を表すID")
  @example("odpt.Operator:TokyoMetro")
  `odpt:operator`: `odpt.url`;
}

@doc("データダンプAPIのレスポンス")
model DumpResponse {
  @doc("JSON-LD仕様に基づく @context のURL")
  @example("http://vocab.odpt.org/context_odpt.jsonld")
  `@context`: url;

  @doc("固有識別子(ucode)")
  @example("urn:ucode:_00001C000000000000010000031028E6")
  `@id`: URN;

  @doc("クラス名")
  @example("odpt:Station")
  `@type`: string;

  @doc("駅名（��本語）")
  @example("東京")
  `dc:title`: string;

  @doc("固有識別子 odpt.Station:会社名.路線名.駅名")
  @example("odpt.Station:JR-East.Yamanote.Tokyo")
  `owl:sameAs`: `odpt.url`;
}

@doc("データ取得APIのレスポンス")
model RetrieveResponse {
  @doc("JSON-LD仕様に基づく @context のURL")
  @example("http://vocab.odpt.org/context_odpt_Station.jsonld")
  `@context`: url;

  @doc("固有識別子(ucode)")
  @example("urn:ucode:_00001C000000000000010000030C46CA")
  `@id`: URN;

  @doc("クラス名")
  @example("odpt:Station")
  `@type`: string;

  @doc("データ生成日時")
  @example("2024-06-27T08:00:00+09:00")
  `dc:date`: DateTime;

  @doc("駅名（日本語）")
  @example("上野")
  `dc:title`: string;

  @doc("緯度")
  @example(35.711835)
  `geo:lat`: float;

  @doc("経度")
  @example(139.775625)
  `geo:long`: float;

  @doc("固有識別子 odpt.Station:会社名.路線名.駅名")
  @example("odpt.Station:TokyoMetro.Ginza.Ueno")
  `owl:sameAs`: `odpt.url`;

  @doc("路線を表すID")
  @example("odpt.Railway:TokyoMetro.Ginza")
  `odpt:railway`: `odpt.url`;

  @doc("運行会社を表すID")
  @example("odpt.Operator:TokyoMetro")
  `odpt:operator`: `odpt.url`;

  @doc("駅コード")
  @example("G16")
  `odpt:stationCode`: string;

  @doc("駅名の多言語表記")
  @example(#{
    en: "Ueno",
    ja: "上野",
    ko: "우에노",
    `ja-Hrkt`: "うえの",
    `zh-Hans`: "上野",
    `zh-Hant`: "上野",
  })
  `odpt:stationTitle`: MultilingualTitle;

  @doc("駅乗降人員数を表すIDのリスト")
  @example(#["odpt.PassengerSurvey:TokyoMetro.Ueno"])
  `odpt:passengerSurvey`: `odpt.url`[];

  @doc("駅時刻表を表すIDのリスト")
  @example(#["odpt.StationTimetable:TokyoMetro.Ginza.Ueno.TokyoMetro.Shibuya.Weekday"])
  `odpt:stationTimetable`: `odpt.url`[];

  @doc("乗り換え可能路線のIDのリスト")
  @example(#["odpt.Railway:TokyoMetro.Hibiya", "odpt.Railway:JR-East.AkitaShinkansen"])
  `odpt:connectingRailway`: `odpt.url`[];

  @doc("乗り換え可能駅のIDのリスト")
  @example(#["odpt.Station:TokyoMetro.Hibiya.Ueno", "odpt.Station:JR-East.AkitaShinkansen.Ueno"])
  `odpt:connectingStation`: `odpt.url`[];
}

@doc("地物情報検索APIのレスポンス")
model PlaceSearchResponse {
  @doc("JSON-LD仕様に基づく @context のURL")
  @example("http://vocab.odpt.org/context_odpt_Station.jsonld")
  `@context`: url;

  @doc("固有識別子(ucode)")
  @example("urn:ucode:_00001C00000000000001000003102C88")
  `@id`: URN;

  @doc("クラス名")
  @example("odpt:Station")
  `@type`: string;

  @doc("データ生成日時")
  @example("2024-03-27T09:00:00+09:00")
  `dc:date`: DateTime;

  @doc("駅名（日本語）")
  @example("日本橋")
  `dc:title`: string;

  @doc("緯度")
  @example(35.681796)
  `geo:lat`: float;

  @doc("経度")
  @example(139.775814)
  `geo:long`: float;

  @doc("固有識別子 odpt.Station:会社名.路線名.駅名")
  @example("odpt.Station:Toei.Asakusa.Nihombashi")
  `owl:sameAs`: `odpt.url`;

  @doc("路線を表すID")
  @example("odpt.Railway:Toei.Asakusa")
  `odpt:railway`: `odpt.url`;

  @doc("運行会社を表すID")
  @example("odpt.Operator:Toei")
  `odpt:operator`: `odpt.url`;

  @doc("駅コード")
  @example("A-13")
  `odpt:stationCode`: string;

  @doc("駅名の多言語表記")
  @example(#{ en: "Nihombashi", ja: "日本橋" })
  `odpt:stationTitle`: MultilingualTitle;

  @doc("駅乗降人員数を表すIDのリスト")
  @example(#["odpt.PassengerSurvey:Toei.Nihombashi"])
  `odpt:passengerSurvey`: `odpt.url`[];

  @doc("駅時刻表を表すIDのリスト")
  @example(#[
    "odpt.StationTimetable:Toei.Asakusa.Nihombashi.Southbound.Weekday",
    "odpt.StationTimetable:Toei.Asakusa.Nihombashi.Southbound.SaturdayHoliday"
  ])
  `odpt:stationTimetable`: `odpt.url`[];

  @doc("乗り換え可能路線のIDのリスト")
  @example(#["odpt.Railway:TokyoMetro.Ginza", "odpt.Railway:TokyoMetro.Tozai"])
  `odpt:connectingRailway`: `odpt.url`[];

  @doc("乗り換え可能駅のIDのリスト")
  @example(#[
    "odpt.Station:TokyoMetro.Ginza.Nihombashi",
    "odpt.Station:TokyoMetro.Tozai.Nihombashi"
  ])
  `odpt:connectingStation`: `odpt.url`[];
}

@doc("データタンプAPI対象のデータ種別")
enum DumpRDFType {
  @doc("曜日・日付区分")
  `odpt:Calendar`,

  @doc("事業者")
  `odpt:Operator`,

  @doc("駅情報")
  `odpt:Station`,

  @doc("駅時刻表")
  `odpt:StationTimetable`,

  @doc("列車時刻表")
  `odpt:TrainTimetable`,

  @doc("列車種別")
  `odpt:TrainType`,

  @doc("進行方向")
  `odpt:RailDirection`,

  @doc("路線情報")
  `odpt:Railway`,

  @doc("運賃情報")
  `odpt:RailwayFare`,

  @doc("駅別乗降人員")
  `odpt:PassengerSurvey`,

  @doc("バス時刻表")
  `odpt:BusTimetable`,

  @doc("バス運行路線情報")
  `odpt:BusroutePattern`,

  @doc("バス運賃情報")
  `odpt:BusroutePatternFare`,

  @doc("バス停標柱情報")
  `odpt:BusstopPole`,

  @doc("バス停標柱時刻表")
  `odpt:BusstopPoleTimetable`,

  @doc("空港情報")
  `odpt:Airport`,

  @doc("空港ターミナル情報")
  `odpt:AirportTerminal`,

  @doc("フライト時刻表")
  `odpt:FlightSchedule`,

  @doc("フライト状況")
  `odpt:FlightStatus`,
}

@doc("地物情報検索対象のデータ種別")
enum PlaceRDFType {
  @doc("駅情報")
  `odpt:Station`,

  @doc("バス停標柱情報")
  `odpt:BusstopPole`,
}

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
