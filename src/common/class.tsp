@doc("アクセストークン")
scalar ConsumerKey extends string;

@doc("固有識別子")
scalar URN extends string;

@doc("固有識別子の別名 多くが`odpt.hoge:fuga`形式")
scalar `odpt.url` extends string;

@doc("ISO8601 日付時刻形式")
scalar DateTime extends string;

@doc("ISO8601 日付形式")
scalar Date extends string;

@doc("ISO8601 時刻形式")
scalar Time extends string;

@doc("多言語対応のタイトル")
model MultilingualTitle {
  ja: string;
  en: string;
  ko?: string;
  `ja-Hrkt`?: string;
  `zh-Hans`?: string;
  `zh-Hant`?: string;
}

@doc("曜日・日付区分を扱うクラス")
model Calendar {
  @doc("JSON-LD仕様に基づく @context のURL")
  @key
  `@context`: url;

  @doc("固有識別子(ucode)")
  `@id`: URN;

  @doc("クラス指定")
  `@type`: "odpt:Calendar";

  @doc("データ生成日時")
  `dc:date`?: DateTime;

  @doc("固有識別子")
  `owl:sameAs`: url;

  @doc("カレンダー名称（日本語）")
  `dc:title`?: string;

  @doc("カレンダー名称（多言語対応）")
  `odpt:calendarTitle`?: MultilingualTitle;
}

@doc("公共交通機関の事業者を扱うクラス")
model Operator {
  @doc("JSON-LD仕様に基づく @context のURL")
  @key
  `@context`: url;

  @doc("固有識別子(ucode)")
  `@id`: URN;

  @doc("クラス指定")
  `@type`: "odpt:Operator";

  @doc("データ生成日時")
  `dc:date`?: DateTime;

  @doc("固有識別子")
  `owl:sameAs`: url;

  @doc("事業者名称（日本語）")
  `dc:title`?: string;

  @doc("事業者名称（多言語対応）")
  `odpt:operatorTitle`?: MultilingualTitle;
}
