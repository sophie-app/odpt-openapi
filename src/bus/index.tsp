import "@typespec/http";
import "@typespec/rest";
import "../common/class.tsp";
import "../common/error.tsp";

@service({
  title: "ODPT Bus API",
})
@server("https://api.odpt.org/api/v4", "API サーバー")
@doc("バスに関連するデータを提供するAPI")
@useAuth(ApiKeyAuth<ApiKeyLocation.query, "acl:consumerKey">)
namespace BusAPI;

using TypeSpec.Http;
using TypeSpec.Rest;

@doc("ISO8601 時刻形式")
scalar Time extends string;

enum BusDoorStatus {
  @doc("開いている")
  open,

  @doc("閉じている")
  close,

  @doc("半自動")
  self,
}

enum OccupancyStatus {
  @doc("車両はほぼ空席")
  `odpt.OccupancyStatus:Empty`,

  @doc("車両に多くの空席あり")
  `odpt.OccupancyStatus:ManySeatsAvailable`,

  @doc("車両に少々の空席あり")
  `odpt.OccupancyStatus:FewSeatsAvailable`,

  @doc("車両に空席なし。立っていれば乗車可能")
  `odpt.OccupancyStatus:StandingRoomOnly`,

  @doc("車両に空席なし。立っていてば乗車可能だが、場所は限られる")
  `odpt.OccupancyStatus:CrushedStandingRoomOnly`,

  @doc("ほぼ満員")
  `odpt.OccupancyStatus:FullRoomOnly`,

  @doc("乗車不可")
  `odpt.OccupancyStatus:NotAcceptingPassengers`,
}

@doc("バス車両の運行情報")
model Bus {
  @doc("JSON-LD仕様に基づく @context のURL")
  @example("http://vocab.odpt.org/context_odpt.jsonld")
  `@context`: URL;

  @doc("固有識別子")
  @example("string")
  `@id`: URN;

  @doc("バス運行情報のクラス名")
  @example("odpt:Bus")
  `@type`: "odpt:Bus";

  @doc("バス運行情報の固有識別子")
  @example("string")
  `owl:sameAs`: URL;

  @doc("バス車両番号")
  @example("string")
  `odpt:busNumber`: string;

  @doc("データ生成時刻")
  @example("2017-01-13T15:10:00+09:00")
  `dc:date`: DateTime;

  @doc("データ保証期限")
  @example("2017-01-13T15:10:00+09:00")
  `dct:valid`: DateTime;

  @doc("更新頻度(秒)、指定された秒数以降にリクエストを行うことで、最新値が取得される。")
  @example(60)
  `odpt:frequency`: integer;

  @doc("運行中の系統のID (odpt:BusroutePatternのowl:sameAs)")
  @example("string")
  `odpt:busroutePattern`: URL;

  @doc("運行中の便の時刻表のID (odpt:BusTimetableのowl:sameAs)")
  @example("string")
  `odpt:busTimetable`?: URL;

  @doc("運行会社のID (odpt:Operatorのowl:sameAs)")
  @example("string")
  `odpt:operator`: URL;

  @doc("運行中系統の始発バス停を表すID (odpt:BusstopPoleのowl:sameAs)")
  @example("string")
  `odpt:startingBusstopPole`?: URL;

  @doc("運行中系統の終着バス停を表すID (odpt:BusstopPoleのowl:sameAs)")
  @example("string")
  `odpt:terminalBusstopPole`?: URL;

  @doc("直近に通過した、あるいは停車中のバス停のID (odpt:BusstopPoleのowl:sameAs)")
  @example("string")
  `odpt:fromBusstopPole`?: URL;

  @doc("直近に通過したバス停を発車した時刻。odpt:fromBusstopPoleがnullならばodpt:fromBusstopPoleTimeもnullとなる")
  @example("2017-01-13T15:10:00+09:00")
  `odpt:fromBusstopPoleTime`?: DateTime;

  @doc("次に到着するバス停のID (odpt:BusstopPoleのowl:sameAs)")
  @example("string")
  `odpt:toBusstopPole`?: URL;

  @doc("Fromを0, Toを1とした際の現在位置 (割合)")
  @example(0.0)
  `odpt:progress`?: float;

  @doc("対象となるバスの経度 (10進表記、測地系はWGS84)")
  @example(139.1234)
  `geo:long`?: float;

  @doc("対象となるバスの緯度 (10進表記、測地系はWGS84)")
  @example(35.1234)
  `geo:lat`?: float;

  @doc("対象となるバスの速度 (km/h)")
  @example(0.0)
  `odpt:speed`?: float;

  @doc("対象となるバスの進行方向方位角を示す。単位は度(°)。北が0度で、時計回り(東回り)に増加する。")
  @example(90.0)
  `odpt:azimuth`?: float;

  @doc("対象となるバスの扉の開閉状態")
  @example(BusDoorStatus.open)
  `odpt:doorStatus`?: BusDoorStatus;

  @doc("車両の混雑度")
  @example(OccupancyStatus.`odpt.OccupancyStatus:Empty`)
  `odpt:occupancyStatus`?: OccupancyStatus;
}

@doc("バスの便の時刻表")
model BusTimetable {
  @doc("JSON-LD仕様に基づく @context のURL")
  @example("http://vocab.odpt.org/context_odpt.jsonld")
  `@context`: URL;

  @doc("固有識別子(ucode)")
  @example("urn:ucode:_00001C000000000000010000030FD7E5")
  `@id`: URN;

  @doc("バス時刻表のクラス名、\"odpt:BusTimetable\"が入る")
  @example("odpt:BusTimetable")
  `@type`: "odpt:BusTimetable";

  @doc("バス時刻表の固有識別子")
  @example("string")
  `owl:sameAs`: URL;

  @doc("データ生成時刻")
  @example("2017-01-13T15:10:00+09:00")
  `dc:date`?: DateTime;

  @doc("ダイヤ改正日")
  @example("2017-01-13")
  `dct:issued`?: Date;

  @doc("データ保証期限")
  @example("2017-01-13T15:10:00+09:00")
  `dct:valid`?: DateTime;

  @doc("バス路線名称(系統名等)")
  @example("string")
  `dc:title`?: string;

  @doc("バス路線名称のよみがな")
  @example("string")
  `odpt:kana`?: string;

  @doc("運行会社のID (odpt:Operatorのowl:sameAs)")
  @example("string")
  `odpt:operator`: URL;

  @doc("対応する運行系統のID (odpt:BusroutePatternのowl:sameAs)")
  @example("string")
  `odpt:busroutePattern`: URL;

  @doc("カレンダーのID (odpt:Calendarのowl:sameAs)")
  @example("string")
  `odpt:calendar`: URL;

  @doc("バス時刻表時分情報")
  @example(#[])
  `odpt:busTimetableObject`: BusTimetableObject[];
}

@doc("バス時刻表時分情報")
model BusTimetableObject {
  @doc("標柱通過順")
  @example(1)
  `odpt:index`: integer;

  @doc("バス停(標柱)のID (odpt:BusstopPoleのowl:sameAs)")
  @example("string")
  `odpt:busstopPole`: URL;

  @doc("バス到着時刻")
  @example("10:00")
  `odpt:arrivalTime`?: Time;

  @doc("バス出発時刻")
  @example("10:00")
  `odpt:departureTime`?: Time;

  @doc("行先(方向幕)情報")
  @example("string")
  `odpt:destinationSign`?: string;

  @doc("ノンステップバスの場合 true")
  @example(true)
  `odpt:isNonStepBus`?: boolean;

  @doc("深夜バスの場合 true")
  @example(true)
  `odpt:isMidnight`?: boolean;

  @doc("乗車可能な場合 true")
  @example(true)
  `odpt:canGetOn`?: boolean;

  @doc("降車可能な場合 true")
  @example(true)
  `odpt:canGetOff`?: boolean;

  @doc("注記")
  @example("string")
  `odpt:note`?: string;
}

@doc("""
  バス路線の系統情報
  `odpt:busstopPoleOrder` が、運行するバスの停車する停留所 (標柱) の順序を表現している。
  バス路線 ('王５７'等) は、通常、複数の系統情報から構成される。
  (e.g. 往路、復路、異なる停留所通過順のバリエーション)
  """)
model BusroutePattern {
  @doc("JSON-LD仕様に基づく @context のURL")
  @example("http://vocab.odpt.org/context_odpt.jsonld")
  `@context`: URL;

  @doc("固有識別子 (ucode)")
  @example("urn:ucode:_00001C000000000000010000030FD7E5")
  `@id`: URN;

  @doc("バス路線情報のクラス名、\"odpt:BusroutePattern\"が入る")
  @example("odpt:BusroutePattern")
  `@type`: "odpt:BusroutePattern";

  @doc("バス路線情報の固有識別子")
  @example("string")
  `owl:sameAs`: URL;

  @doc("データ生成時刻")
  @example("2017-01-13T15:10:00+09:00")
  `dc:date`: DateTime;

  @doc("データの保証期限")
  @example("2017-01-13T15:10:00+09:00")
  `dct:valid`?: DateTime;

  @doc("バス路線名称(系統名・系統番号等)")
  @example("string")
  `dc:title`: string;

  @doc("バス路線名称のよみがな")
  @example("string")
  `odpt:kana`?: string;

  @doc("運営会社を表すID (odpt:Operatorのowl:sameAs)")
  @example("string")
  `odpt:operator`: URL;

  @doc("系統を表すID")
  @example("string")
  `odpt:busroute`?: URL;

  @doc("系統パターン")
  @example("string")
  `odpt:pattern`?: string;

  @doc("方向")
  @example("string")
  `odpt:direction`?: string;

  @doc("停留所(標柱)の順序")
  @example(#[
    #{
      `odpt:busstopPole`: "string",
      `odpt:index`: 1,
      `odpt:openingDoorsToGetOn`: #[OpeningDoor.`odpt:OpeningDoor:FrontSide`],
      `odpt:openingDoorsToGetOff`: #[OpeningDoor.`odpt:OpeningDoor:FrontSide`],
      `odpt:note`: "string",
    }
  ])
  `odpt:busstopPoleOrder`: BussstopPoleOrder[];

  @doc("注記")
  @example("string")
  `odpt:note`?: string;

  @doc("バス位置情報を示すWebSiteのURL")
  @example("string")
  `odpt:busLocationURL`?: URL;
}

enum OpeningDoor {
  @doc("前扉")
  `odpt:OpeningDoor:FrontSide`,

  @doc("後扉")
  `odpt:OpeningDoor:RearSide`,
}

@doc("停留所(標柱)の順序")
model BussstopPoleOrder {
  @doc("停留所のID (odpt:BusstopPoleのowl:sameAs)")
  @example("string")
  `odpt:busstopPole`: URL;

  @doc("停留所通過順。通過順の昇順の値となる")
  @example(1)
  `odpt:index`: integer;

  @doc("乗車時に利用可能なドア")
  @example(#[OpeningDoor.`odpt:OpeningDoor:FrontSide`])
  `odpt:openingDoorsToGetOn`?: OpeningDoor[];

  @doc("降車時に利用可能なドア")
  @example(#[OpeningDoor.`odpt:OpeningDoor:FrontSide`])
  `odpt:openingDoorsToGetOff`?: OpeningDoor[];

  @doc("注記")
  @example("string")
  `odpt:note`?: string;
}

@doc("乗車バス停(標柱)、降車バス停(標柱)についての運賃情報")
model BusroutePatternFare {
  @doc("JSON-LD仕様に基づく @context のURL")
  @example("http://vocab.odpt.org/context_odpt.jsonld")
  `@context`: URL;

  @doc("固有識別子(ucode)")
  @example("urn:ucode:_00001C000000000000010000030FD7E5")
  `@id`: URN;

  @doc("バス運賃のクラス名、\"odpt:BusroutePatternFare\"が入る")
  @example("odpt:BusroutePatternFare")
  `@type`: "odpt:BusroutePatternFare";

  @doc("バス運賃の固有識別子")
  @example("string")
  `owl:sameAs`: URL;

  @doc("データ生成時刻")
  @example("2017-01-13T15:10:00+09:00")
  `dc:date`: DateTime;

  @doc("運賃改定日")
  @example("2017-01-13")
  `dct:issued`?: Date;

  @doc("データ保証期限")
  @example("2017-01-13T15:10:00+09:00")
  `dct:valid`?: DateTime;

  @doc("運行会社を表すID (odpt:Operatorのowl:sameAs)")
  @example("string")
  `odpt:operator`: URL;

  @doc("乗車系統パターンを表すID (odpt:BusroutePatternのowl:sameAs)")
  @example("string")
  `odpt:fromBusroutePattern`: URL;

  @doc("乗車停留所の系統パターン内の停留所 (標柱) 通過順。odpt:fromBusroutePattern の示す odpt:BusroutePattern の、 odpt:busstopPoleOrder の odpt:index と同じ値。")
  @example(0)
  `odpt:fromBusstopPoleOrder`: integer;

  @doc("乗車バス停を表すID。odpt:fromBusroutePattern, odpt:fromBusstopPoleOrder の示すバス停 (標柱) のIDと同じ。")
  @example("string")
  `odpt:fromBusstopPole`: URL;

  @doc("降車系統パターンを表すID (odpt:BusroutePatternのowl:sameAs)")
  @example("string")
  `odpt:toBusroutePattern`: URL;

  @doc("降車停留所の系統パターン内の停留所 (標柱) 通過順。odpt:toBusroutePattern の示す odpt:BusroutePattern の、 odpt:busstopPoleOrder の odpt:index と同じ値。")
  @example(0)
  `odpt:toBusstopPoleOrder`: integer;

  @doc("降車バス停を表すID (odpt:BusstopPoleのowl:sameAs)。 odpt:toBusroutePattern, odpt:toBusstopPoleOrder の示すバス停 (標柱) のIDと同じ。")
  @example("string")
  `odpt:toBusstopPole`: URL;

  @doc("切符利用時の運賃 (円)")
  @example(200)
  `odpt:ticketFare`: integer;

  @doc("切符利用時の子供運賃 (円)")
  @example(100)
  `odpt:childTicketFare`?: integer;

  @doc("ICカード利用時の運賃 (円)")
  @example(200)
  `odpt:icCardFare`?: integer;

  @doc("ICカード利用時の子供運賃 (円)")
  @example(100)
  `odpt:childIcCardFare`?: integer;
}

@doc("バス停情報 odpt:BusstopPoleは、バス停(標柱)の情報")
model BusstopPole {
  @doc("JSON-LD仕様に基づく @context のURL")
  @example("http://vocab.odpt.org/context_odpt.jsonld")
  `@context`: URL;

  @doc("固有識別子(ucode)")
  @example("urn:ucode:_00001C000000000000010000030FD7E5")
  `@id`: URN;

  @doc("バス停 (標柱) のクラス名、\"odpt:BusstopPole\"が入る")
  @example("odpt:BusstopPole")
  `@type`: "odpt:BusstopPole";

  @doc("バス停 (標柱) の固有識別子")
  @example("string")
  `owl:sameAs`: URL;

  @doc("データ生成時刻")
  @example("2017-01-13T15:10:00+09:00")
  `dc:date`: DateTime;

  @doc("データの保証期限")
  @example("2017-01-13T15:10:00+09:00")
  `dct:valid`?: DateTime;

  @doc("バス停名")
  @example("豊洲駅前")
  `dc:title`: string;

  @doc("バス停名のよみがな")
  @example("とよすえきまえ")
  `odpt:kana`?: string;

  @doc("バス停名(多言語対応)")
  @example(#{ ja: "豊洲駅前", `ja-Hrkt`: "とよすえきまえ", en: "Toyosu Sta." })
  title?: MultilingualTitle;

  @doc("標柱の経度(WGS84)")
  @example(139.1234)
  `geo:long`?: float;

  @doc("標柱の緯度(WGS84)")
  @example(35.1234)
  `geo:lat`?: float;

  @doc("入線する系統パターンのID (odpt:BusroutePatternのowl:sameAs) のリスト")
  @example(#["string"])
  `odpt:busroutePattern`?: URL[];

  @doc("入線するバスの運営会社を表すID (odpt:Operatorのowl:sameAs) のリスト")
  @example(#["string"])
  `odpt:operator`: URL[];

  @doc("標柱番号。同一停留所の別標柱を区別するものであり、のりば番号とは一致する保証はない")
  @example("string")
  `odpt:busstopPoleNumber`?: string;

  @doc("のりば番号")
  @example("string")
  `odpt:platformNumber`?: string;

  @doc("バス停(標柱)時刻表のID (odpt:BusstopPoleTimetableのowl:sameAs) のリスト")
  @example(#["string"])
  `odpt:busstopPoleTimetable`?: URL[];
}

@doc("バス停(標柱)時刻表 odpt:busstopPole で示されたバス停(標柱)の時刻表")
model BusstopPoleTimetable {
  @doc("JSON-LD仕様に基づく @context のURL")
  @example("http://vocab.odpt.org/context_odpt.jsonld")
  `@context`: URL;

  @doc("固有識別子(ucode)")
  @example("urn:ucode:_00001C000000000000010000030FD7E5")
  `@id`: URN;

  @doc("バス停(標柱)時刻表のクラス名、\"odpt:BusstopPoleTimetable\"が入る")
  @example("odpt:BusstopPoleTimetable")
  `@type`: "odpt:BusstopPoleTimetable";

  @doc("バス停(標柱)時刻表の固有識別子")
  @example("string")
  `owl:sameAs`: URL;

  @doc("データ生成時刻")
  @example("2017-01-13T15:10:00+09:00")
  `dc:date`: DateTime;

  @doc("ダイヤ改正日")
  @example("2017-01-13")
  `dct:issued`?: Date;

  @doc("データ保証期限。ISO8601形式。期限が存在する場合のみ格納する。")
  @example("2017-01-13T15:10:00+09:00")
  `dct:valid`?: DateTime;

  @doc("バス路線名称(系統名等)")
  @example("string")
  `dc:title`?: string;

  @doc("バス停(標柱)を表すID (odpt:BusstopPoleのowl:sameAs)")
  @example("string")
  `odpt:busstopPole`: URL;

  @doc("方面を表すID。array となる場合もある。")
  @example("string")
  `odpt:busDirection`: string | string[];

  @doc("路線を表すID。array となる場合もある。(複数路線を含む時刻表の場合等)")
  @example("string")
  `odpt:busroute`: string | string[];

  @doc("運行会社を表すID (odpt:Operatorのowl:sameAs)")
  @example("string")
  `odpt:operator`: string | string[];

  @doc("運行する曜日・日付 (odpt:Calendarのowl:sameAs)")
  @example("string")
  `odpt:calendar`: URL;

  @doc("バス停(標柱)時刻表の時分情報")
  @example(#[
    #{
      `odpt:arrivalTime`: "10:00",
      `odpt:departureTime`: "10:00",
      `odpt:destinationBusstopPole`: "string",
      `odpt:destinationSign`: "string",
      `odpt:busroutePattern`: "string",
      `odpt:busroutePatternOrder`: 0,
      `odpt:isNonStepBus`: true,
      `odpt:isMidnight`: true,
      `odpt:canGetOn`: true,
      `odpt:canGetOff`: true,
      `odpt:note`: "string",
    }
  ])
  `odpt:busstopPoleTimetableObject`?: BusstopPoleTimetableObject[];
}

@doc("バス停(標柱)時刻表の時分情報")
model BusstopPoleTimetableObject {
  @doc("バス到着時刻")
  @example("10:00")
  `odpt:arrivalTime`?: Time;

  @doc("バス出発時刻")
  @example("10:00")
  `odpt:departureTime`: Time;

  @doc("行先バス停(標柱)のID (odpt:BusstopPoleのowl:sameAs)")
  @example("string")
  `odpt:destinationBusstopPole`?: URL;

  @doc("行先(方向幕)情報")
  @example("string")
  `odpt:destinationSign`?: string;

  @doc("バス路線のID (odpt:BusroutePatternのowl:sameAs)")
  @example("string")
  `odpt:busroutePattern`?: URL;

  @doc("系統パターン内の停留所(標柱)通過順。odpt:busroutePattern の示す odpt:BusroutePattern の odpt:busstopPoleOrder の odpt:index と同じ値。")
  @example(0)
  `odpt:busroutePatternOrder`?: integer;

  @doc("ノンステップバスの場合 true")
  @example(true)
  `odpt:isNonStepBus`?: boolean;

  @doc("深夜バスの場合 true")
  @example(true)
  `odpt:isMidnight`?: boolean;

  @doc("乗車可能な場合 true")
  @example(true)
  `odpt:canGetOn`?: boolean;

  @doc("降車可能な場合 true")
  @example(true)
  `odpt:canGetOff`?: boolean;

  @doc("注記")
  @example("string")
  `odpt:note`?: string;
}

@route("/odpt:Bus")
interface BusOperation {
  @summary("バス車両の運行情報")
  @doc("バス車両の運行情報を取得する")
  @get
  getBuses(
    @query
    @doc("開発者サイトにて提供されるアクセストークン")
    `acl:consumerKey`: ConsumerKey,

    @query
    @doc("データに付与された固有識別子")
    `@id`?: URN,

    @query
    @doc("データに付与された固有識別子の別名")
    `owl:sameAs`?: URL,

    @query
    @doc("バス車両の運行系統のID")
    `odpt:busroutePattern`?: URL,

    @query
    @doc("事業者のID")
    `odpt:operator`?: URL,

    @query
    @doc("直近に通過した、あるいは停車中のバス停のID")
    `odpt:fromBusstopPole`?: URL,

    @query
    @doc("次に到着するバス停のID")
    `odpt:toBusstopPole`?: URL,
  ): Bus[] | Common.Error;
}

@route("/odpt:BusTimetable")
interface BusTimetableOperations {
  @summary("バスの便の時刻表")
  @doc("バスの便の時刻表を取得する")
  @get
  getBusTimetables(
    @query
    @doc("開発者サイトにて提供されるアクセストークン")
    `acl:consumerKey`: ConsumerKey,

    @query
    @doc("データに付与された固有識別子")
    `@id`?: URN,

    @query
    @doc("データに付与された固有識別子の別名")
    `owl:sameAs`?: URL,

    @query
    @doc("事業者のID")
    `odpt:operator`: URL,

    @query
    @doc("対応する系統のID")
    `odpt:busroutePattern`?: URL,

    @query
    @doc("バス路線名称")
    `dc:title`?: string,

    @query
    @doc("カレンダーのID")
    `odpt:calendar`?: URL,
  ): BusTimetable[] | Common.Error;
}

@route("/odpt:BusroutePattern")
interface BusroutePatternOperations {
  @summary("運行系統情報")
  @doc("運行系統情報を取得する")
  @get
  getBusroutePatterns(
    @query
    @doc("開発者サイトにて提供されるアクセストークン")
    `acl:consumerKey`: ConsumerKey,

    @query
    @doc("データに付与された固有識別子")
    `@id`?: URN,

    @query
    @doc("データに付与された固有識別子の別名")
    `owl:sameAs`?: URL,

    @query
    @doc("路線・系統名称")
    `dc:title`?: string,

    @query
    @doc("事業者のID")
    `odpt:operator`?: URL,

    @query
    @doc("路線のID")
    `odpt:busroute`?: string,
  ): BusroutePattern[] | Common.Error;
}

@route("/odpt:BusroutePatternFare")
interface BusroutePatternFareOperations {
  @summary("運賃情報")
  @doc("運賃情報を取得する")
  @get
  getBusroutePatternFares(
    @query
    @doc("開発者サイトにて提供されるアクセストークン")
    `acl:consumerKey`: ConsumerKey,

    @query
    @doc("データに付与された固有識別子")
    `@id`?: URN,

    @query
    @doc("データに付与された固有識別子の別名")
    `owl:sameAs`?: URL,

    @query
    @doc("事業者のID")
    `odpt:operator`?: URL,

    @query
    @doc("乗車バス停(標柱)のID")
    `odpt:fromBusstopPole`?: URL,

    @query
    @doc("降車バス停(標柱)のID")
    `odpt:toBusstopPole`?: URL,

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
  @doc("バス停情報を取得する")
  @get
  getBusstopPoles(
    @query
    @doc("開発者サイトにて提供されるアクセストークン")
    `acl:consumerKey`: ConsumerKey,

    @query
    @doc("データに付与された固有識別子")
    `@id`?: URN,

    @query
    @doc("データに付与された固有識別子の別名")
    `owl:sameAs`?: URL,

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
    `odpt:busroutePattern`?: URL,

    @query
    @doc("事業者のID")
    `odpt:operator`?: URL,
  ): BusstopPole[] | Common.Error;
}

@route("/odpt:BusstopPoleTimetable")
interface BusstopPoleTimetableOperations {
  @summary("バス停(標柱)時刻表")
  @doc("バス停(標柱)時刻表を取得する")
  @get
  getBusstopPoleTimetables(
    @query
    @doc("開発者サイトにて提供されるアクセストークン")
    `acl:consumerKey`: ConsumerKey,

    @query
    @doc("データに付与された固有識別子")
    `@id`?: URN,

    @query
    @doc("データに付与された固有識別子の別名")
    `owl:sameAs`?: URL,

    @query
    @doc("バス停(標柱)のID")
    `odpt:busstopPole`?: URL,

    @query
    @doc("方面のID")
    `odpt:busDirection`?: string,

    @query
    @doc("路線のID")
    `odpt:busroute`?: string,

    @query
    @doc("事業者のID")
    `odpt:operator`?: URL,

    @query
    @doc("カレンダーのID")
    `odpt:calendar`?: URL,

    @query
    @doc("データ生成日付")
    `dc:date`?: DateTime,
  ): BusstopPoleTimetable[] | Common.Error;
}
