import "../models/bus.tsp";

using TypeSpec.Http;

namespace OdptAPI;

@route("/odpt:Bus")
interface BusOperation {
  @summary("バス車両の運行情報")
  @get
  getBuses(
    @query
    @doc("開発者サイトにて提供されるアクセストークン")
    `acl:consumerKey`: ConsumerKey,

    @query
    @doc("データに付与された固有識別子")
    `@id`?: `odpt.urn`,

    @query
    @doc("データに付与された固有識別子の別名")
    `owl:sameAs`?: `odpt.url`,

    @query
    @doc("バス車両の運行系統のID")
    `odpt:busroutePattern`?: `odpt.url`,

    @query
    @doc("事業者のID")
    `odpt:operator`?: `odpt.url`,

    @query
    @doc("直近に通過した、あるいは停車中のバス停のID")
    `odpt:fromBusstopPole`?: `odpt.url`,

    @query
    @doc("次に到着するバス停のID")
    `odpt:toBusstopPole`?: `odpt.url`,
  ): Bus[] | Common.Error;
}

@route("/odpt:BusTimetable")
interface BusTimetableOperations {
  @summary("バスの便の時刻表")
  @get
  getBusTimetables(
    @query
    @doc("開発者サイトにて提供されるアクセストークン")
    `acl:consumerKey`: ConsumerKey,

    @query
    @doc("データに付与された固有識別子")
    `@id`?: `odpt.urn`,

    @query
    @doc("データに付与された固有識別子の別名")
    `owl:sameAs`?: `odpt.url`,

    @query
    @doc("事業者のID")
    `odpt:operator`: `odpt.url`,

    @query
    @doc("対応する系統のID")
    `odpt:busroutePattern`?: `odpt.url`,

    @query
    @doc("バス路線名称")
    `dc:title`?: string,

    @query
    @doc("カレンダーのID")
    `odpt:calendar`?: `odpt.url`,
  ): BusTimetable[] | Common.Error;
}

@route("/odpt:BusroutePattern")
interface BusroutePatternOperations {
  @summary("運行系統情報")
  @get
  getBusroutePatterns(
    @query
    @doc("開発者サイトにて提供されるアクセストークン")
    `acl:consumerKey`: ConsumerKey,

    @query
    @doc("データに付与された固有識別子")
    `@id`?: `odpt.urn`,

    @query
    @doc("データに付与された固有識別子の別名")
    `owl:sameAs`?: `odpt.url`,

    @query
    @doc("路線・系統名称")
    `dc:title`?: string,

    @query
    @doc("事業者のID")
    `odpt:operator`?: `odpt.url`,

    @query
    @doc("路線のID")
    `odpt:busroute`?: string,
  ): BusroutePattern[] | Common.Error;
}

@route("/odpt:BusroutePatternFare")
interface BusroutePatternFareOperations {
  @summary("運賃情報")
  @get
  getBusroutePatternFares(
    @query
    @doc("開発者サイトにて提供されるアクセストークン")
    `acl:consumerKey`: ConsumerKey,

    @query
    @doc("データに付与された固有識別子")
    `@id`?: `odpt.urn`,

    @query
    @doc("データに付与された固有識別子の別名")
    `owl:sameAs`?: `odpt.url`,

    @query
    @doc("事業者のID")
    `odpt:operator`?: `odpt.url`,

    @query
    @doc("乗車バス停(標柱)のID")
    `odpt:fromBusstopPole`?: `odpt.url`,

    @query
    @doc("降車バス停(標柱)のID")
    `odpt:toBusstopPole`?: `odpt.url`,

    @query
    @doc("切符利用時の運賃")
    `odpt:ticketFare`?: integer,

    @query
    @doc("切符利用時の子供運賃")
    `odpt:childTicketFare`?: integer,

    @query
    @doc("ICカード利用時の運賃")
    `odpt:icCardFare`?: integer,

    @query
    @doc("ICカード利用時の子供運賃")
    `odpt:childIcCardFare`?: integer,
  ): BusroutePatternFare[] | Common.Error;
}

@route("/odpt:BusstopPole")
interface BusstopPoleOperations {
  @summary("バス停情報")
  @get
  getBusstopPoles(
    @query
    @doc("開発者サイトにて提供されるアクセストークン")
    `acl:consumerKey`: ConsumerKey,

    @query
    @doc("データに付与された固有識別子")
    `@id`?: `odpt.urn`,

    @query
    @doc("データに付与された固有識別子の別名")
    `owl:sameAs`?: `odpt.url`,

    @query
    @doc("バス停名")
    `dc:title`?: string,

    @query
    @doc("標柱番号")
    `odpt:busstopPoleNumber`?: string,

    @query
    @doc("のりば番号")
    `odpt:platformNumber`?: string,

    @query
    @doc("標柱で発着する系統のID")
    `odpt:busroutePattern`?: `odpt.url`,

    @query
    @doc("事業者のID")
    `odpt:operator`?: `odpt.url`,
  ): BusstopPole[] | Common.Error;
}

@route("/odpt:BusstopPoleTimetable")
interface BusstopPoleTimetableOperations {
  @summary("バス停(標柱)時刻表")
  @get
  getBusstopPoleTimetables(
    @query
    @doc("開発者サイトにて提供されるアクセストークン")
    `acl:consumerKey`: ConsumerKey,

    @query
    @doc("データに付与された固有識別子")
    `@id`?: `odpt.urn`,

    @query
    @doc("データに付与された固有識別子の別名")
    `owl:sameAs`?: `odpt.url`,

    @query
    @doc("バス停(標柱)のID")
    `odpt:busstopPole`?: `odpt.url`,

    @query
    @doc("方面のID")
    `odpt:busDirection`?: string,

    @query
    @doc("路線のID")
    `odpt:busroute`?: string,

    @query
    @doc("事業者のID")
    `odpt:operator`?: `odpt.url`,

    @query
    @doc("カレンダーのID")
    `odpt:calendar`?: `odpt.url`,

    @query
    @doc("データ生成日付")
    `dc:date`?: DateTime,
  ): BusstopPoleTimetable[] | Common.Error;
}
