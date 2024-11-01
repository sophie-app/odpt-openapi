import "../models/airplane.tsp";

using TypeSpec.Http;

namespace OdptAPI;

@route("/odpt:Airport")
interface AirportOperations {
  @summary("空港情報の取得")
  @get
  getAirports(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子") `@id`?: `odpt.urn`,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: `odpt.url`,
  ): Airport[] | Common.Error;
}

@route("/odpt:AirportTerminal")
interface AirportTerminalOperations {
  @summary("空港ターミナル情報の取得")
  @get
  getAirportTerminals(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子") `@id`?: `odpt.urn`,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: `odpt.url`,
    @query @doc("空港を示すID") `odpt:airport`?: url,
  ): AirportTerminal[] | Common.Error;
}

@route("/odpt:FlightInformationArrival")
interface FlightInformationArrivalOperations {
  @summary("フライト到着情報の取得")
  @get
  getFlightInformationArrivals(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: `odpt.url`,
    @query @doc("空港事業者または航空事業者を示すID") `odpt:operator`?: url,
    @query @doc("エアラインの運行会社を示すID") `odpt:airline`?: url,
    @query @doc("フライト状況を示すID") `odpt:flightStatus`?: url,
    @query @doc("到着空港を示すID") `odpt:arrivalAirport`?: url,
    @query @doc("到着空港ターミナルを示すID") `odpt:arrivalAirportTerminal`?: url,
    @query @doc("到着空港ゲート番号") `odpt:arrivalGate`?: string,
    @query @doc("出発地の空港を示すID") `odpt:originAirport`?: url,
  ): FlightInformationArrival[] | Common.Error;
}

@route("/odpt:FlightInformationDeparture")
interface FlightInformationDepartureOperations {
  @summary("フライト出発情報の取得")
  @get
  getFlightInformationDepartures(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: `odpt.url`,
    @query @doc("空港事業者または航空事業者を示すID") `odpt:operator`?: url,
    @query @doc("エアラインの運行会社を示すID") `odpt:airline`?: url,
    @query @doc("フライト状況を示すID") `odpt:flightStatus`?: url,
    @query @doc("出発空港を示すID") `odpt:departureAirport`?: url,
    @query @doc("出発空港ターミナルを示すID") `odpt:departureAirportTerminal`?: url,
    @query @doc("出発空港ゲート番号") `odpt:departureGate`?: string,
    @query @doc("目的地の空港を示すID") `odpt:destinationAirport`?: url,
  ): FlightInformationDeparture[] | Common.Error;
}

@route("/odpt:FlightSchedule")
interface FlightScheduleOperations {
  @summary("フライト時刻表の取得")
  @get
  getFlightSchedules(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子") `@id`?: `odpt.urn`,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: `odpt.url`,
    @query @doc("空港事業者または航空事業者を示すID") `odpt:operator`?: url,
    @query @doc("運行日を示すID") `odpt:calendar`?: url,
    @query @doc("出発地の空港を示すID") `odpt:originAirport`?: url,
    @query @doc("目的地の空港を示すID") `odpt:destinationAirport`?: url,
  ): FlightSchedule[] | Common.Error;
}

@route("/odpt:FlightStatus")
interface FlightStatusOperations {
  @summary("フライト状況定義の取得")
  @get
  getFlightStatuses(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子") `@id`?: `odpt.urn`,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: `odpt.url`,
  ): FlightStatus[] | Common.Error;
}
