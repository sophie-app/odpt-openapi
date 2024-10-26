import "@typespec/http";
import "@typespec/rest";
import "../common/class.tsp";
import "../common/error.tsp";

@service({
  title: "ODPT Airplane API",
})
@server("https://api.odpt.org/api/v4", "API サーバー")
@doc("航空機に関連するデータを提供するAPI")
@useAuth(ApiKeyAuth<ApiKeyLocation.query, "acl:consumerKey">)
namespace AirplaneAPI;

using TypeSpec.Http;
using TypeSpec.Rest;

@doc("ISO8601 時刻形式")
scalar Time extends string;

@doc("空港の情報")
model Airport {
  @doc("JSON-LD仕様に基づく @context のURL")
  `@context`: URL;

  @doc("固有識別子(ucode)")
  `@id`: URN;

  @doc("クラス名")
  `@type`: "odpt:Airport";

  @doc("データ生成日時")
  `dc:date`?: DateTime;

  @doc("固有識別子")
  `owl:sameAs`: URL;

  @doc("空港名（日本語）")
  `dc:title`?: string;

  @doc("空港名（多言語対応）")
  `odpt:airportTitle`?: MultilingualTitle;

  @doc("空港のターミナルを表す ID のリスト")
  `odpt:airportTerminal`?: URL[];

  @doc("代表点の経度")
  `geo:long`?: decimal;

  @doc("代表点の緯度")
  `geo:lat`?: decimal;

  @doc("GeoJSON形式による地物情報")
  `ug:region`?: Record<unknown>;
}

@doc("空港のターミナルの情報")
model AirportTerminal {
  @doc("JSON-LD仕様に基づく @context のURL")
  `@context`: URL;

  @doc("固有識別子(ucode)")
  `@id`: URN;

  @doc("クラス名")
  `@type`: "odpt:AirportTerminal";

  @doc("データ生成日時")
  `dc:date`?: DateTime;

  @doc("固有識別子")
  `owl:sameAs`: URL;

  @doc("空港ターミナル名（日本語）")
  `dc:title`?: string;

  @doc("空港ターミナル名（多言語対応）")
  `odpt:airportTerminalTitle`?: MultilingualTitle;

  @doc("空港を示すID")
  `odpt:airport`: URL;

  @doc("代表点の経度")
  `geo:long`?: decimal;

  @doc("代表点の緯度")
  `geo:lat`?: decimal;

  @doc("GeoJSON形式による地物情報")
  `ug:region`?: Record<unknown>;
}

@doc("フライト到着情報")
model FlightInformationArrival {
  @doc("JSON-LD仕様に基づく @context のURL")
  `@context`: URL;

  @doc("固有識別子(ucode又はuuid)")
  `@id`: URN;

  @doc("クラス指定")
  `@type`: "odpt:FlightInformationArrival";

  @doc("データ生成日時")
  `dc:date`: DateTime;

  @doc("データ保証期限")
  `dct:valid`?: DateTime;

  @doc("固有識別子")
  `owl:sameAs`: URL;

  @doc("フライト到着情報を提供する事業者を示すID")
  `odpt:operator`: URL;

  @doc("エアラインの運行会社を表すID")
  `odpt:airline`?: URL;

  @doc("フライト番号のリスト")
  `odpt:flightNumber`: string[];

  @doc("フライト状況を表すID")
  `odpt:flightStatus`?: URL;

  @doc("運行情報の要約（多言語対応）")
  `odpt:flightInformationSummary`?: MultilingualTitle;

  @doc("運行情報の詳細（多言語対応）")
  `odpt:flightInformationText`?: MultilingualTitle;

  @doc("定刻の到着時刻")
  `odpt:scheduledArrivalTime`?: Time;

  @doc("変更後到着時刻")
  `odpt:estimatedArrivalTime`?: Time;

  @doc("実際の到着時刻")
  `odpt:actualArrivalTime`?: Time;

  @doc("到着空港を示すID")
  `odpt:arrivalAirport`: URL;

  @doc("到着空港のターミナルを表すID")
  `odpt:arrivalAirportTerminal`?: URL;

  @doc("到着空港のゲート番号")
  `odpt:arrivalGate`?: string;

  @doc("到着空港の預け手荷物受取所")
  `odpt:baggageClaim`?: string;

  @doc("出発地の空港を示すID")
  `odpt:originAirport`?: URL;

  @doc("経由地の空港を表すIDのリスト")
  `odpt:viaAirport`?: URL[];

  @doc("航空機の機種")
  `odpt:aircraftType`?: string;
}

@doc("フライト出発情報")
model FlightInformationDeparture {
  @doc("JSON-LD仕様に基づく @context のURL")
  `@context`: URL;

  @doc("固有識別子(ucode又はuuid)")
  `@id`: URN;

  @doc("クラス指定")
  `@type`: "odpt:FlightInformationDeparture";

  @doc("データ生成日時")
  `dc:date`: DateTime;

  @doc("データ保証期限")
  `dct:valid`?: DateTime;

  @doc("固有識別子")
  `owl:sameAs`: URL;

  @doc("フライト出発情報を提供する事業者を示すID")
  `odpt:operator`: URL;

  @doc("エアラインの運行会社を表すID")
  `odpt:airline`?: URL;

  @doc("フライト番号のリスト")
  `odpt:flightNumber`: string[];

  @doc("フライト状況を表すID")
  `odpt:flightStatus`?: URL;

  @doc("運行情報の要約（多言語対応）")
  `odpt:flightInformationSummary`?: MultilingualTitle;

  @doc("運行情報の詳細（多言語対応）")
  `odpt:flightInformationText`?: MultilingualTitle;

  @doc("定刻の出発時刻")
  `odpt:scheduledDepartureTime`?: Time;

  @doc("変更後出発時刻")
  `odpt:estimatedDepartureTime`?: Time;

  @doc("実際の出発時刻")
  `odpt:actualDepartureTime`?: Time;

  @doc("出発空港を示すID")
  `odpt:departureAirport`: URL;

  @doc("出発空港のターミナルを示すID")
  `odpt:departureAirportTerminal`?: URL;

  @doc("出発空港のゲート番号")
  `odpt:departureGate`?: string;

  @doc("出発空港のチェックインカウンターのリスト")
  `odpt:checkInCounter`?: string[];

  @doc("目的地の空港を示すID")
  `odpt:destinationAirport`?: URL;

  @doc("経由地の空港を表すIDのリスト")
  `odpt:viaAirport`?: URL[];

  @doc("航空機の機種")
  `odpt:aircraftType`?: string;
}

@doc("フライトスケジュールオブジェクト")
model FlightScheduleObject {
  @doc("エアラインの運行会社のID")
  `odpt:airline`: URL;

  @doc("フライト番号のリスト")
  `odpt:flightNumber`: string[];

  @doc("出発予定時刻")
  `odpt:originTime`: Time;

  @doc("出発日とカレンダー情報の日数差")
  `odpt:originDayDifference`?: int32;

  @doc("到着予定時刻")
  `odpt:destinationTime`: Time;

  @doc("到着日とカレンダー情報の日数差")
  `odpt:destinationDayDifference`?: int32;

  @doc("経由地の空港を表すIDのリスト")
  `odpt:viaAirport`?: URL[];

  @doc("航空機の機種")
  `odpt:aircraftType`?: string;

  @doc("データ適用開始日時")
  `odpt:isValidFrom`?: DateTime;

  @doc("データ適用終了日時")
  `odpt:isValidTo`?: DateTime;

  @doc("注釈情報（多言語対応）")
  `odpt:note`?: MultilingualTitle;
}

@doc("フライト時刻表")
model FlightSchedule {
  @doc("JSON-LD仕様に基づく @context のURL")
  `@context`: URL;

  @doc("固有識別子(ucode)")
  `@id`: URN;

  @doc("クラス指定")
  `@type`: "odpt:FlightSchedule";

  @doc("データ生成日時")
  `dc:date`?: DateTime;

  @doc("固有識別子")
  `owl:sameAs`: URL;

  @doc("フライト時刻表を提供する事業者を示すID")
  `odpt:operator`: URL;

  @doc("カレンダー情報を示すID")
  `odpt:calendar`: URL;

  @doc("出発地の空港のID")
  `odpt:originAirport`: URL;

  @doc("目的地の空港のID")
  `odpt:destinationAirport`: URL;

  @doc("時刻表オブジェクト")
  `odpt:flightScheduleObject`?: FlightScheduleObject[];
}

@doc("フライト状況")
model FlightStatus {
  @doc("JSON-LD仕様に基づく @context のURL")
  `@context`: URL;

  @doc("固有識別子(ucode)")
  `@id`: URN;

  @doc("クラス名")
  `@type`: "odpt:FlightStatus";

  @doc("データ生成日時")
  `dc:date`?: DateTime;

  @doc("固有識別子")
  `owl:sameAs`: URL;

  @doc("フライト状況（日本語）")
  `dc:title`?: string;

  @doc("フライト状況（多言語対応）")
  `odpt:flightStatusTitle`?: MultilingualTitle;
}
@route("/odpt:Airport")
interface AirportOperations {
  @summary("空港情報の取得")
  @doc("空港の情報を取得する")
  @get
  getAirports(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子") `@id`?: URN,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: URL,
  ): Airport[] | Common.Error;
}

@route("/odpt:AirportTerminal")
interface AirportTerminalOperations {
  @summary("空港ターミナル情報の取得")
  @doc("空港のターミナルの情報を取得する")
  @get
  getAirportTerminals(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子") `@id`?: URN,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: URL,
    @query @doc("空港を示すID") `odpt:airport`?: URL,
  ): AirportTerminal[] | Common.Error;
}

@route("/odpt:FlightInformationArrival")
interface FlightInformationArrivalOperations {
  @summary("フライト到着情報の取得")
  @doc("フライト到着情報を取得する")
  @get
  getFlightInformationArrivals(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: URL,
    @query @doc("空港事業者または航空事業者を示すID") `odpt:operator`?: URL,
    @query @doc("エアラインの運行会社を示すID") `odpt:airline`?: URL,
    @query @doc("フライト状況を示すID") `odpt:flightStatus`?: URL,
    @query @doc("到着空港を示すID") `odpt:arrivalAirport`?: URL,
    @query @doc("到着空港ターミナルを示すID") `odpt:arrivalAirportTerminal`?: URL,
    @query @doc("到着空港ゲート番号") `odpt:arrivalGate`?: string,
    @query @doc("出発地の空港を示すID") `odpt:originAirport`?: URL,
  ): FlightInformationArrival[] | Common.Error;
}

@route("/odpt:FlightInformationDeparture")
interface FlightInformationDepartureOperations {
  @summary("フライト出発情報の取得")
  @doc("フライト出発情報を取得する")
  @get
  getFlightInformationDepartures(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: URL,
    @query @doc("空港事業者または航空事業者を示すID") `odpt:operator`?: URL,
    @query @doc("エアラインの運行会社を示すID") `odpt:airline`?: URL,
    @query @doc("フライト状況を示すID") `odpt:flightStatus`?: URL,
    @query @doc("出発空港を示すID") `odpt:departureAirport`?: URL,
    @query @doc("出発空港ターミナルを示すID") `odpt:departureAirportTerminal`?: URL,
    @query @doc("出発空港ゲート番号") `odpt:departureGate`?: string,
    @query @doc("目的地の空港を示すID") `odpt:destinationAirport`?: URL,
  ): FlightInformationDeparture[] | Common.Error;
}

@route("/odpt:FlightSchedule")
interface FlightScheduleOperations {
  @summary("フライト時刻表の取得")
  @doc("フライト時刻表を取得する")
  @get
  getFlightSchedules(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子") `@id`?: URN,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: URL,
    @query @doc("空港事業者または航空事業者を示すID") `odpt:operator`?: URL,
    @query @doc("運行日を示すID") `odpt:calendar`?: URL,
    @query @doc("出発地の空港を示すID") `odpt:originAirport`?: URL,
    @query @doc("目的地の空港を示すID") `odpt:destinationAirport`?: URL,
  ): FlightSchedule[] | Common.Error;
}

@route("/odpt:FlightStatus")
interface FlightStatusOperations {
  @summary("フライト状況定義の取得")
  @doc("フライト状況の定義を取得する")
  @get
  getFlightStatuses(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子") `@id`?: URN,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: URL,
  ): FlightStatus[] | Common.Error;
}
