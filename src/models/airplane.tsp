import "../common/class.tsp";

@doc("空港の情報")
model Airport {
  @doc("JSON-LD仕様に基づく @context のURL")
  `@context`: url;

  @doc("固有識別子(ucode)")
  `@id`: `odpt.urn`;

  @doc("クラス名")
  `@type`: "odpt:Airport";

  @doc("データ生成日時")
  `dc:date`?: DateTime;

  @doc("固有識別子")
  `owl:sameAs`: `odpt.url`;

  @doc("空港名(日本語)")
  `dc:title`?: string;

  @doc("空港名(多言語対応)")
  `odpt:airportTitle`?: MultilingualTitle;

  @doc("空港のターミナルを表す ID のリスト")
  `odpt:airportTerminal`?: url[];

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
  `@context`: url;

  @doc("固有識別子(ucode)")
  `@id`: `odpt.urn`;

  @doc("クラス名")
  `@type`: "odpt:AirportTerminal";

  @doc("データ生成日時")
  `dc:date`?: DateTime;

  @doc("固有識別子")
  `owl:sameAs`: `odpt.url`;

  @doc("空港ターミナル名(日本語)")
  `dc:title`?: string;

  @doc("空港ターミナル名(多言語対応)")
  `odpt:airportTerminalTitle`?: MultilingualTitle;

  @doc("空港を示すID")
  `odpt:airport`: url;

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
  `@context`: url;

  @doc("固有識別子(ucode又はuuid)")
  `@id`: `odpt.urn`;

  @doc("クラス指定")
  `@type`: "odpt:FlightInformationArrival";

  @doc("データ生成日時")
  `dc:date`: DateTime;

  @doc("データ保証期限")
  `dct:valid`?: DateTime;

  @doc("固有識別子")
  `owl:sameAs`: `odpt.url`;

  @doc("フライト到着情報を提供する事業者を示すID")
  `odpt:operator`: url;

  @doc("エアラインの運行会社を表すID")
  `odpt:airline`?: url;

  @doc("フライト番号のリスト")
  `odpt:flightNumber`: string[];

  @doc("フライト状況を表すID")
  `odpt:flightStatus`?: url;

  @doc("運行情報の要約(多言語対応)")
  `odpt:flightInformationSummary`?: MultilingualTitle;

  @doc("運行情報の詳細(多言語対応)")
  `odpt:flightInformationText`?: MultilingualTitle;

  @doc("定刻の到着時刻")
  `odpt:scheduledArrivalTime`?: Time;

  @doc("変更後到着時刻")
  `odpt:estimatedArrivalTime`?: Time;

  @doc("実際の到着時刻")
  `odpt:actualArrivalTime`?: Time;

  @doc("到着空港を示すID")
  `odpt:arrivalAirport`: url;

  @doc("到着空港のターミナルを表すID")
  `odpt:arrivalAirportTerminal`?: url;

  @doc("到着空港のゲート番号")
  `odpt:arrivalGate`?: string;

  @doc("到着空港の預け手荷物受取所")
  `odpt:baggageClaim`?: string;

  @doc("出発地の空港を示すID")
  `odpt:originAirport`?: url;

  @doc("経由地の空港を表すIDのリスト")
  `odpt:viaAirport`?: url[];

  @doc("航空機の機種")
  `odpt:aircraftType`?: string;
}

@doc("フライト出発情報")
model FlightInformationDeparture {
  @doc("JSON-LD仕様に基づく @context のURL")
  `@context`: url;

  @doc("固有識別子(ucode又はuuid)")
  `@id`: `odpt.urn`;

  @doc("クラス指定")
  `@type`: "odpt:FlightInformationDeparture";

  @doc("データ生成日時")
  `dc:date`: DateTime;

  @doc("データ保証期限")
  `dct:valid`?: DateTime;

  @doc("固有識別子")
  `owl:sameAs`: `odpt.url`;

  @doc("フライト出発情報を提供する事業者を示すID")
  `odpt:operator`: url;

  @doc("エアラインの運行会社を表すID")
  `odpt:airline`?: url;

  @doc("フライト番号のリスト")
  `odpt:flightNumber`: string[];

  @doc("フライト状況を表すID")
  `odpt:flightStatus`?: url;

  @doc("運行情報の要約(多言語対応)")
  `odpt:flightInformationSummary`?: MultilingualTitle;

  @doc("運行情報の詳細(多言語対応)")
  `odpt:flightInformationText`?: MultilingualTitle;

  @doc("定刻の出発時刻")
  `odpt:scheduledDepartureTime`?: Time;

  @doc("変更後出発時刻")
  `odpt:estimatedDepartureTime`?: Time;

  @doc("実際の出発時刻")
  `odpt:actualDepartureTime`?: Time;

  @doc("出発空港を示すID")
  `odpt:departureAirport`: url;

  @doc("出発空港のターミナルを示すID")
  `odpt:departureAirportTerminal`?: url;

  @doc("出発空港のゲート番号")
  `odpt:departureGate`?: string;

  @doc("出発空港のチェックインカウンターのリスト")
  `odpt:checkInCounter`?: string[];

  @doc("目的地の空港を示すID")
  `odpt:destinationAirport`?: url;

  @doc("経由地の空港を表すIDのリスト")
  `odpt:viaAirport`?: url[];

  @doc("航空機の機種")
  `odpt:aircraftType`?: string;
}

@doc("フライトスケジュールオブジェクト")
model FlightScheduleObject {
  @doc("エアラインの運行会社のID")
  `odpt:airline`: url;

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
  `odpt:viaAirport`?: url[];

  @doc("航空機の機種")
  `odpt:aircraftType`?: string;

  @doc("データ適用開始日時")
  `odpt:isValidFrom`?: DateTime;

  @doc("データ適用終了日時")
  `odpt:isValidTo`?: DateTime;

  @doc("注釈情報(多言語対応)")
  `odpt:note`?: MultilingualTitle;
}

@doc("フライト時刻表")
model FlightSchedule {
  @doc("JSON-LD仕様に基づく @context のURL")
  `@context`: url;

  @doc("固有識別子(ucode)")
  `@id`: `odpt.urn`;

  @doc("クラス指定")
  `@type`: "odpt:FlightSchedule";

  @doc("データ生成日時")
  `dc:date`?: DateTime;

  @doc("固有識別子")
  `owl:sameAs`: `odpt.url`;

  @doc("フライト時刻表を提供する事業者を示すID")
  `odpt:operator`: url;

  @doc("カレンダー情報を示すID")
  `odpt:calendar`: url;

  @doc("出発地の空港のID")
  `odpt:originAirport`: url;

  @doc("目的地の空港のID")
  `odpt:destinationAirport`: url;

  @doc("時刻表オブジェクト")
  `odpt:flightScheduleObject`?: FlightScheduleObject[];
}

@doc("フライト状況")
model FlightStatus {
  @doc("JSON-LD仕様に基づく @context のURL")
  `@context`: url;

  @doc("固有識別子(ucode)")
  `@id`: `odpt.urn`;

  @doc("クラス名")
  `@type`: "odpt:FlightStatus";

  @doc("データ生成日時")
  `dc:date`?: DateTime;

  @doc("固有識別子")
  `owl:sameAs`: `odpt.url`;

  @doc("フライト状況(日本語)")
  `dc:title`?: string;

  @doc("フライト状況(多言語対応)")
  `odpt:flightStatusTitle`?: MultilingualTitle;
}
