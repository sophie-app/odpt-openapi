import "@typespec/http";
import "@typespec/rest";
import "../common/class.tsp";
import "../common/error.tsp";

@service({
  title: "ODPT Train API",
})
@server("https://api.odpt.org/api/v4", "API サーバー")
@doc("鉄道に関連するデータを提供するAPI")
@useAuth(ApiKeyAuth<ApiKeyLocation.query, "acl:consumerKey">)
namespace TrainAPI;

using TypeSpec.Http;
using TypeSpec.Rest;

@doc("ISO8601 時刻形式")
scalar Time extends string;

@doc("駅の乗降人員数または乗車人員数")
model PassengerSurvey {
  @doc("JSON-LD仕様に基づく @context のURL")
  @example("http://vocab.odpt.org/context_odpt.jsonld")
  `@context`: url;

  @doc("固有識別子(ucode)")
  @example("urn:ucode:_00001C000000000000010000030FD7E5")
  `@id`: URN;

  @doc("クラス名")
  @example("odpt:PassengerSurvey")
  `@type`: "odpt:PassengerSurvey";

  @doc("データ生成日時")
  @example("2017-01-13T15:10:00+09:00")
  `dc:date`: DateTime;

  @doc("固有識別子 odpt.PassengerSurvey:会社名.駅名 または odpt.PassengerSurvey:会社名.路線名.駅名")
  @example("odpt.PassengerSurvey:JR-East.Tokyo")
  `owl:sameAs`: `odpt:URL`;

  @doc("運行会社を表すID")
  @example("odpt.Operator:JR-East")
  `odpt:operator`: `odpt:URL`;

  @doc("駅を表すIDのリスト")
  @example(#["odpt.Station:JR-East.Yamanote.Tokyo", "odpt.Station:JR-East.ChuoRapid.Tokyo"])
  `odpt:station`: `odpt:URL`[];

  @doc("路線を表すIDのリスト")
  @example(#["odpt.Railway:JR-East.Yamanote", "odpt.Railway:JR-East.ChuoRapid"])
  `odpt:railway`: `odpt:URL`[];

  @doc("乗降人員(降車を含む)の場合はtrue、乗車人員(降車を含まない)の場合はfalse")
  @example(true)
  `odpt:includeAlighting`: boolean;

  @doc("調査年度と平均乗降人員数(または乗車人員数)の組のリスト")
  @example(#[#{ `odpt:surveyYear`: 2017, `odpt:passengerJourneys`: 12345 }])
  `odpt:passengerSurveyObject`: PassengerSurveyObject[];
}

@doc("調査年度と平均乗降人員数(または乗車人員数)の組")
model PassengerSurveyObject {
  @doc("調査年度")
  @example(2017)
  `odpt:surveyYear`: integer;

  @doc("駅の1日あたりの平均乗降人員数(または乗車人員数)")
  @example(12345)
  `odpt:passengerJourneys`: integer;
}

@doc("列車の進行方向")
model RailDirection {
  @doc("JSON-LD仕様に基づく @context のURL")
  @example("http://vocab.odpt.org/context_odpt.jsonld")
  `@context`: url;

  @doc("固有識別子(ucode)")
  @example("urn:ucode:_00001C000000000000010000030FD7E5")
  `@id`: URN;

  @doc("クラス名")
  @example("odpt:RailDirection")
  `@type`: "odpt:RailDirection";

  @doc("進行方向情報の生成時刻")
  @example("2017-01-13T15:10:00+09:00")
  `dc:date`?: DateTime;

  @doc("固有識別子 odpt.RailDirection:進行方向 または odpt.RailDirection:会社名.進行方向 ")
  @example("odpt.RailDirection:Inbound")
  `owl:sameAs`: `odpt:URL`;

  @doc("進行方向（日本語）")
  @example("上り")
  `dc:title`?: string;

  @doc("進行方向（多言語対応）")
  @example(#{ ja: "上り", en: "Inbound" })
  `odpt:railDirectionTitle`?: MultilingualTitle;
}

@doc("鉄道路線（運行系統）の情報")
model Railway {
  @doc("JSON-LD仕様に基づく @context のURL")
  @example("http://vocab.odpt.org/context_odpt.jsonld")
  `@context`: url;

  @doc("固有識別子(ucode)")
  @example("urn:ucode:_00001C000000000000010000030FD7E5")
  `@id`: URN;

  @doc("クラス名")
  @example("odpt:Railway")
  `@type`: "odpt:Railway";

  @doc("データ生成日時")
  @example("2017-01-13T15:10:00+09:00")
  `dc:date`: DateTime;

  @doc("固有識別子 odpt.Railway:会社名.路線名")
  @example("odpt.Railway:JR-East.Yamanote")
  `owl:sameAs`: `odpt:URL`;

  @doc("路線名（日本語）")
  @example("山手線")
  `dc:title`: string;

  @doc("路線名（多言語対応）")
  @example(#{ ja: "山手線", en: "Yamanote Line" })
  `odpt:railwayTitle`?: MultilingualTitle;

  @doc("路線名のよみがな（ひらがな表記）")
  @example("やまのてせん")
  `odpt:kana`?: string;

  @doc("運行会社を表すID")
  @example("odpt.Operator:JR-East")
  `odpt:operator`: `odpt:URL`;

  @doc("路線コード、路線シンボル表記 e.g. 丸ノ内線=>M")
  @example("M")
  `odpt:lineCode`?: string;

  @doc("路線のラインカラー")
  @example("#80C241")
  `odpt:color`?: string;

  @doc("GeoJSON形式による地物情報")
  `ug:region`?: Record<unknown>;

  @doc("昇順の進行方向を表すID")
  @example("odpt.RailDirection:Outbound")
  `odpt:ascendingRailDirection`?: `odpt:URL`;

  @doc("降順の進行方向を表すID")
  @example("odpt.RailDirection:Inbound")
  `odpt:descendingRailDirection`?: `odpt:URL`;

  @doc("駅の順序を表すリスト")
  @example(#[#{ `odpt:station`: "odpt.Station:JR-East.Yamanote.Tokyo", `odpt:index`: 1 }])
  `odpt:stationOrder`: StationOrder[];
}

@doc("駅の順序")
model StationOrder {
  @doc("駅を表すID")
  @example("odpt.Station:TokyoMetro.Marunouchi.Tokyo")
  `odpt:station`: `odpt:URL`;

  @doc("駅名（多言語対応）")
  @example(#{ ja: "東京", en: "Tokyo" })
  `odpt:stationTitle`?: MultilingualTitle;

  @doc("駅の順序を示す整数値 原則として、列車は進行方向に応じて、この値の昇順または降順に停車する。環状線などの場合は、同一の駅が複数回記載される場合がある。")
  @example(1)
  `odpt:index`: integer;
}

@doc("2駅間の運賃情報")
model RailwayFare {
  @doc("JSON-LD仕様に基づく @context のURL")
  @example("http://vocab.odpt.org/context_odpt.jsonld")
  `@context`: url;

  @doc("固有識別子(ucode)")
  @example("urn:ucode:_00001C000000000000010000030FD7E5")
  `@id`: URN;

  @doc("クラス名")
  @example("odpt:RailwayFare")
  `@type`: "odpt:RailwayFare";

  @doc("データ生成日時")
  @example("2017-01-13T15:10:00+09:00")
  `dc:date`: DateTime;

  @doc("運賃改定日")
  @example("2017-01-13")
  `dct:issued`?: Date;

  @doc("データの保証期限")
  @example("2017-01-13T15:10:00+09:00")
  `dct:valid`?: DateTime;

  @doc("固有識別子 odpt.RailwayFare:出発駅の会社名.出発駅の路線名.出発駅名.到着駅の会社名.到着駅の路線名.到着駅名")
  @example("odpt.RailwayFare:TokyoMetro.Marunouchi.Tokyo.TokyoMetro.Tozai.Nakano")
  `owl:sameAs`: `odpt:URL`;

  @doc("運行会社を表すID")
  @example("odpt.Operator:TokyoMetro")
  `odpt:operator`: `odpt:URL`;

  @doc("出発駅のID")
  @example("odpt.Station:TokyoMetro.Marunouchi.Tokyo")
  `odpt:fromStation`: `odpt:URL`;

  @doc("到着駅のID")
  @example("odpt.Station:TokyoMetro.Tozai.Nakano")
  `odpt:toStation`: `odpt:URL`;

  @doc("切符利用時の運賃")
  @example(200)
  `odpt:ticketFare`: integer;

  @doc("ICカード利用時の運賃")
  @example(196)
  `odpt:icCardFare`?: integer;

  @doc("切符利用時の子供運賃")
  @example(100)
  `odpt:childTicketFare`?: integer;

  @doc("ICカード利用時の子供運賃")
  @example(98)
  `odpt:childIcCardFare`?: integer;

  @doc("運賃計算上の経由駅を表すIDのリスト")
  @example(#["odpt.Station:TokyoMetro.Tozai.NishiFunabashi"])
  `odpt:viaStation`?: `odpt:URL`[];

  @doc("運賃計算上の経由路線を表すIDのリスト")
  @example(#["odpt.Railway:TokyoMetro.Tozai"])
  `odpt:viaRailway`?: `odpt:URL`[];

  @doc("チケット種別")
  @example("string")
  `odpt:ticketType`?: string;

  @doc("支払い方法のリスト")
  @example(#["string"])
  `odpt:paymentMethod`?: string[];
}

@doc("駅情報")
model Station {
  @doc("JSON-LD仕様に基づく @context のURL")
  @example("http://vocab.odpt.org/context_odpt.jsonld")
  `@context`: url;

  @doc("固有識別子(ucode)")
  @example("urn:ucode:_00001C000000000000010000030FD7E5")
  `@id`: URN;

  @doc("クラス名")
  @example("odpt:Station")
  `@type`: "odpt:Station";

  @doc("データ生成日時")
  @example("2017-01-13T15:10:00+09:00")
  `dc:date`: DateTime;

  @doc("固有識別子 odpt.Station:会社名.路線名.駅名")
  @example("odpt.Station:JR-East.Yamanote.Tokyo")
  `owl:sameAs`: `odpt:URL`;

  @doc("駅名（日本語）")
  @example("東京")
  `dc:title`?: string;

  @doc("駅名（多言語対応）")
  @example(#{ ja: "東京", en: "Tokyo" })
  `odpt:stationTitle`?: MultilingualTitle;

  @doc("運行会社を表すID")
  @example("odpt.Operator:JR-East")
  `odpt:operator`: `odpt:URL`;

  @doc("路線を表すID")
  @example("odpt.Railway:JR-East.Yamanote")
  `odpt:railway`: `odpt:URL`;

  @doc("駅コード")
  @example("JY01")
  `odpt:stationCode`?: string;

  @doc("代表点の経度")
  @example(139.1234)
  `geo:long`?: float;

  @doc("代表点の緯度")
  @example(35.1234)
  `geo:lat`?: float;

  @doc("GeoJSON形式による地物情報")
  `ug:region`?: Record<unknown>;

  @doc("駅出入口を表すIDのリスト IDにはug:Poiの@idの値を利用")
  @example(#["string"])
  `odpt:exit`?: string[];

  @doc("乗り換え可能路線のIDのリスト")
  @example(#["odpt.Railway:JR-East.ChuoRapid", "odpt.Railway:TokyoMetro.Marunouchi"])
  `odpt:connectingRailway`?: `odpt:URL`[];

  @doc("乗り換え可能駅のIDのリスト")
  @example(#["odpt.Station:JR-East.ChuoRapid.Tokyo", "odpt.Station:TokyoMetro.Marunouchi.Tokyo"])
  `odpt:connectingStation`?: `odpt:URL`[];

  @doc("駅時刻表を表すIDのリスト")
  @example(#["odpt.StationTimetable:JR-East.Yamanote.Tokyo.Outbound.Weekday"])
  `odpt:stationTimetable`?: `odpt:URL`[];

  @doc("駅乗降人員数を表すIDのリスト")
  @example(#["odpt.PassengerSurvey:JR-East.Tokyo"])
  `odpt:passengerSurvey`?: `odpt:URL`[];
}

@doc("駅時刻表情報")
model StationTimetable {
  @doc("JSON-LD仕様に基づく @context のURL")
  @example("http://vocab.odpt.org/context_odpt.jsonld")
  `@context`: url;

  @doc("固有識別子(ucode)")
  @example("urn:ucode:_00001C000000000000010000030FD7E5")
  `@id`: URN;

  @doc("クラス名")
  @example("odpt:StationTimetable")
  `@type`: "odpt:StationTimetable";

  @doc("データ生成日時")
  @example("2017-01-13T15:10:00+09:00")
  `dc:date`: DateTime;

  @doc("ダイヤ改正日")
  @example("2017-01-13")
  `dct:issued`?: Date;

  @doc("データの保証期限")
  @example("2017-01-13T15:10:00+09:00")
  `dct:valid`?: DateTime;

  @doc("固有識別子 odpt.StationTimetable:会社名.路線名.駅名.方面名.曜日種別")
  @example("odpt.StationTimetable:JR-East.ChuoRapid.Tokyo.Outbound.Weekday")
  `owl:sameAs`: `odpt:URL`;

  @doc("運行会社を表すID")
  @example("odpt.Operator:JR-East")
  `odpt:operator`: `odpt:URL`;

  @doc("路線を表すID")
  @example("odpt.Railway:JR-East.ChuoRapid")
  `odpt:railway`: `odpt:URL`;

  @doc("路線名（多言語対応）")
  @example(#{ ja: "中央線快速", en: "Chuo Rapid" })
  `odpt:railwayTitle`?: MultilingualTitle;

  @doc("駅を表すID")
  @example("odpt.Station:JR-East.ChuoRapid.Tokyo")
  `odpt:station`?: `odpt:URL`;

  @doc("駅名（多言語対応）")
  @example(#{ ja: "東京", en: "Tokyo" })
  `odpt:stationTitle`?: MultilingualTitle;

  @doc("方面を表すID")
  @example("odpt.RailDirection:Outbound")
  `odpt:railDirection`?: `odpt:URL`;

  @doc("運行を行う曜日・日付情報のID")
  @example("odpt.Calendar:Weekday")
  `odpt:calendar`?: `odpt:URL`;

  @doc("出発時刻、終着（行先）駅等の組のリスト")
  @example(#[#{ `odpt:departureTime`: "06:00" }, #{ `odpt:departureTime`: "07:00" }])
  `odpt:stationTimetableObject`: StationTimetableObject[];

  @doc("注釈情報（多言語対応）")
  @example(#{ ja: "日本語での注釈情報", en: "Note in English" })
  `odpt:note`?: MultilingualTitle;
}

@doc("駅時刻表オブジェクト")
model StationTimetableObject {
  @doc("到着時刻")
  @example("05:08")
  `odpt:arrivalTime`?: Time;

  @doc("出発時刻")
  @example("05:09")
  `odpt:departureTime`?: Time;

  @doc("始発駅を表すIDのリスト")
  @example(#["odpt.Station:JR-East.ChuoRapid.Tokyo"])
  `odpt:originStation`?: `odpt:URL`[];

  @doc("終着駅を表すIDのリスト")
  @example(#["odpt.Station:JR-East.ChuoRapid.Takao"])
  `odpt:destinationStation`?: `odpt:URL`[];

  @doc("経由駅を表すIDのリスト")
  @example(#["odpt.Station:TokyoMetro.Tozai.NishiFunabashi"])
  `odpt:viaStation`?: `odpt:URL`[];

  @doc("経由路線を表すIDのリスト")
  @example(#["odpt.Railway:TokyoMetro.Tozai"])
  `odpt:viaRailway`?: `odpt:URL`[];

  @doc("到着または出発する列車ID")
  @example("odpt.Train:JR-East.Yamanote.123M")
  `odpt:train`?: `odpt:URL`;

  @doc("列車番号")
  @example("123M")
  `odpt:trainNumber`?: string;

  @doc("列車種別のID")
  @example("odpt.TrainType:JR-East.Local")
  `odpt:trainType`?: `odpt:URL`;

  @doc("編成の名称・愛称のリスト")
  @example(#[#{ ja: "むさし", en: "Musashi" }])
  `odpt:trainName`?: MultilingualTitle[];

  @doc("車両の所属会社を表すID")
  @example("odpt.Operator:JR-East")
  `odpt:trainOwner`?: `odpt:URL`;

  @doc("最終電車かどうか")
  @example(true)
  `odpt:isLast`?: boolean;

  @doc("始発駅かどうか")
  @example(true)
  `odpt:isOrigin`?: boolean;

  @doc("プラットフォームの番号")
  @example("1")
  `odpt:platformNumber`?: string;

  @doc("プラットフォームの名称")
  @example(#{ ja: "日本語名称", en: "English Name" })
  `odpt:platformName`?: MultilingualTitle;

  @doc("車両数")
  @example(8)
  `odpt:carComposition`?: integer;

  @doc("注釈情報")
  @example(#{ ja: "日本語での注釈情報", en: "Note in English" })
  `odpt:note`?: MultilingualTitle;
}
@doc("列車情報")
model Train {
  @doc("JSON-LD仕様に基づく @context のURL")
  @example("http://vocab.odpt.org/context_odpt.jsonld")
  `@context`: url;

  @doc("固有識別子(ucode又はuuid)")
  @example("urn:ucode:_00001C000000000000010000030FD7E5")
  `@id`: URN;

  @doc("クラス名")
  @example("odpt:Train")
  `@type`: "odpt:Train";

  @doc("データ生成日時")
  @example("2017-01-13T15:10:00+09:00")
  `dc:date`: DateTime;

  @doc("データ保証期限")
  @example("2017-01-13T15:15:00+09:00")
  `dct:valid`?: DateTime;

  @doc("固有識別子 odpt.Train:会社名.路線名.列車番号")
  @example("odpt.Train:JR-East.Yamanote.123M")
  `owl:sameAs`: `odpt:URL`;

  @doc("運行会社を表すID")
  @example("odpt.Operator:JR-East")
  `odpt:operator`: `odpt:URL`;

  @doc("鉄道路線を表すID")
  @example("odpt.Railway:JR-East.Yamanote")
  `odpt:railway`: `odpt:URL`;

  @doc("進行方向を表すID")
  @example("odpt.RailDirection:Outbound")
  `odpt:railDirection`?: `odpt:URL`;

  @doc("列車番号")
  @example("123M")
  `odpt:trainNumber`: string;

  @doc("列車種別")
  @example("odpt.TrainType:JR-East.Local")
  `odpt:trainType`?: `odpt:URL`;

  @doc("編成の名称・愛称のリスト")
  @example(#[#{ ja: "むさし", en: "Musashi" }])
  `odpt:trainName`?: MultilingualTitle[];

  @doc("列車が直前に出た駅、あるいは停車中の駅を表すID")
  @example("odpt.Station:JR-East.ChuoRapid.Tokyo")
  `odpt:fromStation`?: `odpt:URL`;

  @doc("列車が向かっている駅を表すID")
  @example("odpt.Station:JR-East.ChuoRapid.Tokyo")
  `odpt:toStation`?: `odpt:URL`;

  @doc("列車の始発駅を表すIDのリスト")
  @example(#["odpt.Station:JR-East.ChuoRapid.Tokyo"])
  `odpt:originStation`?: `odpt:URL`[];

  @doc("列車の終着駅を表すIDのリスト")
  @example(#["odpt.Station:JR-East.ChuoRapid.Takao"])
  `odpt:destinationStation`?: `odpt:URL`[];

  @doc("列車の経由駅を表すIDのリスト")
  @example(#["odpt.Station:TokyoMetro.Tozai.NishiFunabashi"])
  `odpt:viaStation`?: `odpt:URL`[];

  @doc("列車の経由路線を表すIDのリスト")
  @example(#["odpt.Railway:TokyoMetro.Tozai"])
  `odpt:viaRailway`?: `odpt:URL`[];

  @doc("車両の所属会社を表すID")
  @example("odpt.Operator:JR-East")
  `odpt:trainOwner`?: `odpt:URL`;

  @doc("路線内の列車順序")
  @example(1)
  `odpt:index`?: integer;

  @doc("遅延時間（秒）")
  @example(60)
  `odpt:delay`?: integer;

  @doc("車両数")
  @example(8)
  `odpt:carComposition`?: integer;

  @doc("注釈情報")
  @example(#{ ja: "日本語での注釈情報", en: "Note in English" })
  `odpt:note`?: MultilingualTitle;
}

@doc("列車運行情報")
model TrainInformation {
  @doc("JSON-LD仕様に基づく @context のURL")
  @example("http://vocab.odpt.org/context_odpt.jsonld")
  `@context`: url;

  @doc("固有識別子(ucode又はuuid)")
  @example("urn:ucode:_00001C000000000000010000030FD7E5")
  `@id`: URN;

  @doc("クラス名")
  @example("odpt:TrainInformation")
  `@type`: "odpt:TrainInformation";

  @doc("データ生成日時")
  @example("2017-01-13T15:10:00+09:00")
  `dc:date`: DateTime;

  @doc("データ保証期限")
  @example("2017-01-13T15:15:00+09:00")
  `dct:valid`?: DateTime;

  @doc("固有識別子 odpt.TrainInformation:会社名.路線名 または odpt.TrainInformation:会社名")
  @example("odpt.TrainInformation:JR-East.Yamanote")
  `owl:sameAs`: `odpt:URL`;

  @doc("発生時刻")
  @example("2017-01-13T15:15:00+09:00")
  `odpt:timeOfOrigin`: DateTime;

  @doc("運行会社を表すID")
  @example("odpt.Operator:JR-East")
  `odpt:operator`: `odpt:URL`;

  @doc("発生路線を表すID")
  @example("odpt.Railway:JR-East.Yamanote")
  `odpt:railway`?: `odpt:URL`;

  @doc("運行情報ステータス")
  @example(#{ ja: "日本語テキスト", en: "Text in English" })
  `odpt:trainInformationStatus`?: MultilingualTitle;

  @doc("運行情報テキスト")
  @example(#{ ja: "日本語テキスト", en: "Text in English" })
  `odpt:trainInformationText`: MultilingualTitle;

  @doc("運行情報の適用される方向を表すID")
  @example("odpt.RailDirection:Outbound")
  `odpt:railDirection`?: `odpt:URL`;

  @doc("発生エリア")
  @example(#{ ja: "日本語テキスト", en: "Text in English" })
  `odpt:trainInformationArea`?: MultilingualTitle;

  @doc("鉄道種類")
  @example(#{ ja: "日本語テキスト", en: "Text in English" })
  `odpt:trainInformationKind`?: MultilingualTitle;

  @doc("発生場所起点")
  @example("odpt.Station:JR-East.Yamanote.Tokyo")
  `odpt:stationFrom`?: `odpt:URL`;

  @doc("発生場所終点")
  @example("odpt.Station:JR-East.Yamanote.Tokyo")
  `odpt:stationTo`?: `odpt:URL`;

  @doc("発生区間")
  @example(#{ ja: "日本語テキスト", en: "Text in English" })
  `odpt:trainInformationRange`?: MultilingualTitle;

  @doc("発生理由")
  @example(#{ ja: "日本語テキスト", en: "Text in English" })
  `odpt:trainInformationCause`?: MultilingualTitle;

  @doc("振替路線一覧のリスト")
  @example(#["odpt.Railway:JR-East.Yamanote"])
  `odpt:transferRailways`?: `odpt:URL`[];

  @doc("復旧見込み時刻")
  @example("2017-01-13T15:15:00+09:00")
  `odpt:resumeEstimate`?: DateTime;
}

@doc("列車時刻表")
model TrainTimetable {
  @doc("JSON-LD仕様に基づく @context のURL")
  @example("http://vocab.odpt.org/context_odpt.jsonld")
  `@context`: url;

  @doc("固有識別子(ucode)")
  @example("urn:ucode:_00001C000000000000010000030FD7E5")
  `@id`: URN;

  @doc("クラス名")
  @example("odpt:TrainTimetable")
  `@type`: "odpt:TrainTimetable";

  @doc("データ生成日時")
  @example("2017-01-13T15:10:00+09:00")
  `dc:date`: DateTime;

  @doc("ダイヤ改正日")
  @example("2017-01-13")
  `dct:issued`?: Date;

  @doc("データの保証期限")
  @example("2017-01-13T15:10:00+09:00")
  `dct:valid`?: DateTime;

  @doc("固有識別子 odpt.TrainTimetable:会社名.路線名.列車番号.曜日種別 である。前記の命名ルールで重複が生じる場合は、末尾に .1, .2, .3, … をつけて区別")
  @example("odpt.TrainTimetable:JR-East.ChuoRapid.123M.Weekday")
  `owl:sameAs`: `odpt:URL`;

  @doc("運行会社を表すID")
  @example("odpt.Operator:JR-East")
  `odpt:operator`: `odpt:URL`;

  @doc("路線のID")
  @example("odpt.Railway:JR-East.Yamanote")
  `odpt:railway`: `odpt:URL`;

  @doc("進行方向を表すID")
  @example("odpt.RailDirection:Outbound")
  `odpt:railDirection`?: `odpt:URL`;

  @doc("運行を行う曜日・日付情報のID")
  @example("odpt.Calendar:Weekday")
  `odpt:calendar`?: `odpt:URL`;

  @doc("列車のID")
  @example("odpt.Train:JR-East.Yamanote.123M")
  `odpt:train`?: `odpt:URL`;

  @doc("列車番号")
  @example("123M")
  `odpt:trainNumber`: string;

  @doc("列車種別のID")
  @example("odpt.TrainType:JR-East.Local")
  `odpt:trainType`?: `odpt:URL`;

  @doc("編成の名称・愛称のリスト")
  @example(#[#{ ja: "むさし", en: "Musashi" }])
  `odpt:trainName`?: MultilingualTitle[];

  @doc("車両の所属会社を表すID")
  @example("odpt.Operator:JR-East")
  `odpt:trainOwner`?: `odpt:URL`;

  @doc("列車の始発駅を表すIDのリスト")
  @example(#["odpt.Station:JR-East.ChuoRapid.Tokyo"])
  `odpt:originStation`?: `odpt:URL`[];

  @doc("列車の終着駅を表すIDのリスト")
  @example(#["odpt.Station:JR-East.ChuoRapid.Takao"])
  `odpt:destinationStation`?: `odpt:URL`[];

  @doc("列車の経由駅を表すIDのリスト")
  @example(#["odpt.Station:TokyoMetro.Tozai.NishiFunabashi"])
  `odpt:viaStation`?: `odpt:URL`[];

  @doc("列車の経由路線を表すIDのリスト")
  @example(#["odpt.Railway:TokyoMetro.Tozai"])
  `odpt:viaRailway`?: `odpt:URL`[];

  @doc("直前の列車時刻表を表すIDのリスト")
  @example(#["odpt.TrainTimetable:JR-East.ChuoRapid.123M.Weekday"])
  `odpt:previousTrainTimetable`?: `odpt:URL`[];

  @doc("直後の列車時刻表を表すIDのリスト")
  @example(#["odpt.TrainTimetable:JR-East.ChuoRapid.123M.Weekday"])
  `odpt:nextTrainTimetable`?: `odpt:URL`[];

  @doc("出発時刻と出発駅の組か、到着時刻と到着駅の組のリスト")
  @example(#[
    #{
      `odpt:departureTime`: "06:00",
      `odpt:departureStation`: "odpt.Station:JR-East.ChuoRapid.Tokyo",
    },
    #{ `odpt:arrivalTime`: "07:00", `odpt:arrivalStation`: "odpt.Station:JR-East.ChuoRapid.Takao" }
  ])
  `odpt:trainTimetableObject`: TrainTimetableObject[];

  @doc("乗車券の他に別料金が必要か")
  @example(true)
  `odpt:needExtraFee`?: boolean;

  @doc("注釈情報")
  @example(#{ ja: "日本語での注釈情報", en: "Note in English" })
  `odpt:note`?: MultilingualTitle;
}

@doc("列車時刻表オブジェクト")
model TrainTimetableObject {
  @doc("到着時刻")
  @example("05:08")
  `odpt:arrivalTime`?: Time;

  @doc("到着駅のID")
  @example("odpt.Station:JR-East.ChuoRapid.Tokyo")
  `odpt:arrivalStation`?: `odpt:URL`;

  @doc("出発時刻")
  @example("05:09")
  `odpt:departureTime`?: Time;

  @doc("出発駅のID")
  @example("odpt.Station:JR-East.ChuoRapid.Tokyo")
  `odpt:departureStation`?: `odpt:URL`;

  @doc("プラットフォームの番号")
  @example("1")
  `odpt:platformNumber`?: string;

  @doc("プラットフォームの名称")
  @example(#{ ja: "日本語名称", en: "English Name" })
  `odpt:platformName`?: MultilingualTitle;

  @doc("注釈情報")
  @example(#{ ja: "日本語での注釈情報", en: "Note in English" })
  `odpt:note`?: MultilingualTitle;
}

@doc("列車種別")
model TrainType {
  @doc("JSON-LD仕様に基づく @context のURL")
  @example("http://vocab.odpt.org/context_odpt.jsonld")
  `@context`: url;

  @doc("固有識別子(ucode)")
  @example("urn:ucode:_00001C000000000000010000030FD7E5")
  `@id`: URN;

  @doc("クラス名")
  @example("odpt:TrainType")
  `@type`: "odpt:TrainType";

  @doc("データ生成日時")
  @example("2017-01-13T15:10:00+09:00")
  `dc:date`?: DateTime;

  @doc("固有識別子 odpt.TrainType:会社名.列車種別")
  @example("odpt:JR-East.Local")
  `owl:sameAs`: `odpt:URL`;

  @doc("運行会社を表すID")
  @example("odpt.Operator:JR-East")
  `odpt:operator`: `odpt:URL`;

  @doc("列車種別（日本語）")
  @example("普通")
  `dc:title`?: string;

  @doc("列車種別（多言語対応）")
  @example(#{ ja: "普通", en: "Local" })
  `odpt:trainTypeTitle`?: MultilingualTitle;
}

@route("/odpt:PassengerSurvey")
interface PassengerSurveyOperations {
  @summary("駅の乗降人員数を取得する")
  @get
  getPassengerSurveys(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子") `@id`?: URN,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: `odpt:URL`,
    @query @doc("事業者を表すID") `odpt:operator`?: `odpt:URL`,
    @query @doc("駅を表すID") `odpt:station`?: `odpt:URL`,
    @query @doc("路線を表すID") `odpt:railway`?: `odpt:URL`,
  ): PassengerSurvey[] | Common.Error;
}

@route("/odpt:RailDirection")
interface RailDirectionOperations {
  @summary("進行方向の定義を取得する")
  @get
  getRailDirections(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子") `@id`?: URN,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: `odpt:URL`,
  ): RailDirection[] | Common.Error;
}

@route("/odpt:Railway")
interface RailwayOperations {
  @summary("路線情報を取得する")
  @get
  getRailways(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子") `@id`?: URN,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: `odpt:URL`,
    @query @doc("路線名") `dc:title`?: string,
    @query @doc("事業者を表すID") `odpt:operator`?: `odpt:URL`,
    @query @doc("路線コード、路線シンボル表記") `odpt:lineCode`?: string,
  ): Railway[] | Common.Error;
}

@route("/odpt:RailwayFare")
interface RailwayFareOperations {
  @summary("2駅間の運賃を取得する")
  @get
  getRailwayFares(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子") `@id`?: URN,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: `odpt:URL`,
    @query @doc("事業者を表すID") `odpt:operator`?: `odpt:URL`,
    @query @doc("出発駅のID") `odpt:fromStation`?: `odpt:URL`,
    @query @doc("到着駅のID") `odpt:toStation`?: `odpt:URL`,
  ): RailwayFare[] | Common.Error;
}

@route("/odpt:Station")
interface StationOperations {
  @summary("駅情報を取得する")
  @get
  getStations(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子") `@id`?: URN,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: `odpt:URL`,
    @query @doc("駅名") `dc:title`?: string,
    @query @doc("事業者を表すID") `odpt:operator`?: `odpt:URL`,
    @query @doc("駅が存在する路線ID") `odpt:railway`?: `odpt:URL`,
    @query @doc("駅ナンバリング") `odpt:stationCode`?: string,
  ): Station[] | Common.Error;
}

@route("/odpt:StationTimetable")
interface StationTimetableOperations {
  @summary("駅時刻表を取得する")
  @get
  getStationTimetables(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子") `@id`?: URN,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: `odpt:URL`,
    @query @doc("駅を表すID") `odpt:station`?: `odpt:URL`,
    @query @doc("路線を表すID") `odpt:railway`?: `odpt:URL`,
    @query @doc("事業者を表すID") `odpt:operator`?: `odpt:URL`,
    @query @doc("進行方向を表すID") `odpt:railDirection`?: `odpt:URL`,
    @query @doc("実施日を表すID") `odpt:calendar`?: `odpt:URL`,
    @query @doc("特定日付の時刻表を取得") `dc:date`?: DateTime,
  ): StationTimetable[] | Common.Error;
}

@route("/odpt:Train")
interface TrainOperations {
  @summary("列車情報(列車の位置情報)を取得する")
  @get
  getTrains(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: `odpt:URL`,
    @query @doc("列車情報を配信する事業者のID") `odpt:operator`?: `odpt:URL`,
    @query @doc("当該列車が運行している路線のID") `odpt:railway`?: `odpt:URL`,
  ): Train[] | Common.Error;
}

@route("/odpt:TrainInformation")
interface TrainInformationOperations {
  @summary("列車運行情報を取得する")
  @get
  getTrainInformation(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: `odpt:URL`,
    @query @doc("運行情報を配信する事業者のID") `odpt:operator`?: `odpt:URL`,
    @query @doc("運行情報が発生した路線のID") `odpt:railway`?: `odpt:URL`,
  ): TrainInformation[] | Common.Error;
}

@route("/odpt:TrainTimetable")
interface TrainTimetableOperations {
  @summary("列車時刻表を取得する")
  @get
  getTrainTimetables(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("固有識別子") `@id`?: URN,
    @query @doc("固有識別子別名") `owl:sameAs`?: `odpt:URL`,
    @query @doc("列車番号") `odpt:trainNumber`?: string,
    @query @doc("路線のID") `odpt:railway`?: `odpt:URL`,
    @query @doc("運行事業者のID") `odpt:operator`?: `odpt:URL`,
    @query @doc("列車種別ID") `odpt:trainType`?: `odpt:URL`,
    @query @doc("該当する列車ID") `odpt:train`?: `odpt:URL`,
    @query @doc("特定のカレンダー情報ID") `odpt:calendar`?: `odpt:URL`,
  ): TrainTimetable[] | Common.Error;
}

@route("/odpt:TrainType")
interface TrainTypeOperations {
  @summary("列車種別の定義を取得する")
  @get
  getTrainTypes(
    @query @doc("開発者サイトにて提供されるアクセストークン") `acl:consumerKey`: ConsumerKey,
    @query @doc("データに付与された固有識別子") `@id`?: URN,
    @query @doc("データに付与された固有識別子の別名") `owl:sameAs`?: `odpt:URL`,
    @query @doc("事業者を表すID") `odpt:operator`?: `odpt:URL`,
  ): TrainType[] | Common.Error;
}
