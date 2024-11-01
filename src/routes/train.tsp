import "../models/train.tsp";

using TypeSpec.Http;

namespace OdptAPI;

@route("/odpt:PassengerSurvey")
interface PassengerSurveyOperations {
  @summary("駅の乗降人員数を取得する")
  @get
  getPassengerSurveys(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子") `@id`?: `odpt.urn`,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: `odpt.url`,
    @query @doc("事業者を表すID") `odpt:operator`?: `odpt.url`,
    @query @doc("駅を表すID") `odpt:station`?: `odpt.url`,
    @query @doc("路線を表すID") `odpt:railway`?: `odpt.url`,
  ): PassengerSurvey[] | Common.Error;
}

@route("/odpt:RailDirection")
interface RailDirectionOperations {
  @summary("進行方向の定義を取得する")
  @get
  getRailDirections(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子") `@id`?: `odpt.urn`,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: `odpt.url`,
  ): RailDirection[] | Common.Error;
}

@route("/odpt:Railway")
interface RailwayOperations {
  @summary("路線情報を取得する")
  @get
  getRailways(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子") `@id`?: `odpt.urn`,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: `odpt.url`,
    @query @doc("路線名") `dc:title`?: string,
    @query @doc("事業者を表すID") `odpt:operator`?: `odpt.url`,
    @query @doc("路線コード、路線シンボル表記") `odpt:lineCode`?: string,
  ): Railway[] | Common.Error;
}

@route("/odpt:RailwayFare")
interface RailwayFareOperations {
  @summary("2駅間の運賃を取得する")
  @get
  getRailwayFares(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子") `@id`?: `odpt.urn`,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: `odpt.url`,
    @query @doc("事業者を表すID") `odpt:operator`?: `odpt.url`,
    @query @doc("出発駅のID") `odpt:fromStation`?: `odpt.url`,
    @query @doc("到着駅のID") `odpt:toStation`?: `odpt.url`,
  ): RailwayFare[] | Common.Error;
}

@route("/odpt:Station")
interface StationOperations {
  @summary("駅情報を取得する")
  @get
  getStations(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子") `@id`?: `odpt.urn`,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: `odpt.url`,
    @query @doc("駅名") `dc:title`?: string,
    @query @doc("事業者を表すID") `odpt:operator`?: `odpt.url`,
    @query @doc("駅が存在する路線ID") `odpt:railway`?: `odpt.url`,
    @query @doc("駅ナンバリング") `odpt:stationCode`?: string,
  ): Station[] | Common.Error;
}

@route("/odpt:StationTimetable")
interface StationTimetableOperations {
  @summary("駅時刻表を取得する")
  @get
  getStationTimetables(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子") `@id`?: `odpt.urn`,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: `odpt.url`,
    @query @doc("駅を表すID") `odpt:station`?: `odpt.url`,
    @query @doc("路線を表すID") `odpt:railway`?: `odpt.url`,
    @query @doc("事業者を表すID") `odpt:operator`?: `odpt.url`,
    @query @doc("進行方向を表すID") `odpt:railDirection`?: `odpt.url`,
    @query @doc("実施日を表すID") `odpt:calendar`?: `odpt.url`,
    @query @doc("特定日付の時刻表を取得") `dc:date`?: DateTime,
  ): StationTimetable[] | Common.Error;
}

@route("/odpt:Train")
interface TrainOperations {
  @summary("列車情報(列車の位置情報)を取得する")
  @get
  getTrains(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: `odpt.url`,
    @query @doc("列車情報を配信する事業者のID") `odpt:operator`?: `odpt.url`,
    @query @doc("当該列車が運行している路線のID") `odpt:railway`?: `odpt.url`,
  ): Train[] | Common.Error;
}

@route("/odpt:TrainInformation")
interface TrainInformationOperations {
  @summary("列車運行情報を取得する")
  @get
  getTrainInformation(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: `odpt.url`,
    @query @doc("運行情報を配信する事業者のID") `odpt:operator`?: `odpt.url`,
    @query @doc("運行情報が発生した路線のID") `odpt:railway`?: `odpt.url`,
  ): TrainInformation[] | Common.Error;
}

@route("/odpt:TrainTimetable")
interface TrainTimetableOperations {
  @summary("列車時刻表を取得する")
  @get
  getTrainTimetables(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("固有識別子") `@id`?: `odpt.urn`,
    @query @doc("固有識別子別名") `owl:sameAs`?: `odpt.url`,
    @query @doc("列車番号") `odpt:trainNumber`?: string,
    @query @doc("路線のID") `odpt:railway`?: `odpt.url`,
    @query @doc("運行事業者のID") `odpt:operator`?: `odpt.url`,
    @query @doc("列車種別ID") `odpt:trainType`?: `odpt.url`,
    @query @doc("該当する列車ID") `odpt:train`?: `odpt.url`,
    @query @doc("特定のカレンダー情報ID") `odpt:calendar`?: `odpt.url`,
  ): TrainTimetable[] | Common.Error;
}

@route("/odpt:TrainType")
interface TrainTypeOperations {
  @summary("列車種別の定義を取得する")
  @get
  getTrainTypes(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子") `@id`?: `odpt.urn`,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: `odpt.url`,
    @query @doc("事業者を表すID") `odpt:operator`?: `odpt.url`,
  ): TrainType[] | Common.Error;
}
