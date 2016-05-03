# HotChat

try! `ReSwift`... but finally I wanna make up `Chat App`

## やったこと

### pod install

### App stateをつくる

### Actionをつくっていく

どんなActionをつくればいいのか・・・慣れないと悩む。状態変更がおきるな、というところを見ていく感じかな。あと名前も悩む。名前がめっちゃ長くなる。カプセル化できたりするのかな。

### 空のReducerをつくる

### 個別のstateを１つつくってみる

単位的にはとりあえず画面のstate

もともと
```
    var date :NSDate?
    var name :String?
    let sections = ["日時", "イベント名", "場所"]
```

になっているので、ここの`var`の部分がstateなわけなので

```
struct EventCreateState: StateType {
    var name = ""
    var date = NSDate()
}
```

こんな感じでつくってみる

### reducerを１つつくってみる

`initialAuthenticationState`にあたるものはつくったほうがいい？？

`case let action as CreateEventNameAction:`の書き方知らなかった、、、いいね！

### store

http://reswift.github.io/ReSwift/master/getting-started-guide.html に乗ってなかったので
ようわからんけど、countersampleをもとにグローバルであるstoreをつくってみる

```
    var store = Store<AppState>(
        reducer: AppReducer(),
        state: nil
    )
```

### 実際のsubscribeのところを書いてく、がむずい

```
        store.subscribe(self) { (state :AppState) -> EventCreateState in
            return state.eventCreateState
        }
```

必要なstateのみにfilteringしてる？？

`store.state.eventCreateState.date`
こんな感じで実際にデータ表示するところやっちゃってるけど、、、果たして？？w

### 一時的な状態ってどうやってもつのだろう

普通につくるなら、そのVCのvariableとして存在するだけだからそんな気にならないけど、AppStateの中に一時的なものとして存在するということかな、、、

### 同じ画面で複数の役割をするもの

イベント一覧でも「場所から」「履歴から」のときは・・・stateはわけるのか？？

### 一時的にもつvariableって

結構resetしてあげないといけない気がする。設定画面とかで更新するとき

### redux wayにのった、たとえばローディングの表示

とかのライブラリが必要になってきたりする？？
webもそうだったっけ？？

### hogehoge 

```
store.state.accountEditState.name = AccountManager.sharedInstance.user.name
```

あれ、stateを直接書き換えちゃダメだよね・・・でもコンパイルエラーにならないなぁ・・・

### OS準拠表示ロジック

`ShowRefreshAction`だとか`ShowDoneAlert`みたいなActionを通して、OS準拠？の表示ロジックを制御することはできるのか・・・

### ファイル構成

`ReSwift`っていうグループつくった
どれが`ReSwift`ウェイに乗っかったファイルなのかをわかりやすくするため

### Alertを

表示するのにAction経由でやってみようと思ったが、やっぱり無理というか違う感あるというか・・・
そもそもstateの変更というかは、alertを表示するという「手続き」みたいな感じがして・・・
あとそもそもalertを閉じるstateというのはこっち側ではもてないというか、非表示になったあとのトリガーしか拾えないというか。。。
あれ、であればカスタムアラートにすればいいのかな？？

## ReSwiftでは管理しづらいもの

- UIAlertControllerなど、OS準拠のもので状態はOSがもっているから
- ↑キーボードの処理もここに加わるかなと思った
- アニメーション（でもこれまだ実際には試していない）

## stateをどのように（どのような単位？）でもつ？？

- いまは画面ごとのstateみたいな感じでやっている
- が、ninjinkunさんのをみると、そういう感じではなかった、あくまでアプリケーションにどういったstateがあるか、といった感じ
- ↑ でも一時的な状態編集ってのはどうやってるのだろう？？

## やること

- なにも使わずにアプリケーション（`HotChat`）をつくってみる
- 次にReSwiftでつくりなおす
- 次に画面遷移もRouterでつくりなおす
- 次にRecorderなんかでHotReloadなんかを試していきたい

## データの初期化

って必要なのかね？？これまではそれぞれのvc内のinstanceとして存在していたので、そのvcが消える時 = そのデータも消える
が、ReSwiftではアプリのシングルトンとしてもつため、でリストのビューを開いたときには基本最新のに反映させるので
リセットみたいな処理が必要だと思うんだけど・・・
`deinit`にかく、`viewdidload`にかく、もっと別のなにか・・・・・ふーむ。。。

## newStateの難しさ

ここにreloadtable書いちゃうと・・・別のstate変更でもreloadtable走っちゃう汗
かなりの無駄な処理
ここらへん、ninjinkunが言っていた差分更新のことだと思うけど、
そもそも変更されたstateの型をみてうんぬん、みたいことってあるのかな・・・・

## 連続のstore.dispatch

`store.dispatch( `っていうコードが２回連発で続くことってありますよね？？
これって連続で`newState`が呼ばれるという不毛な感じですよね？？
いや、なるほど！これもnijinkunがいっていたことか！！
たとえばだけど、`store.dispatch().dispatch()` みたいに書いて、newStateは１回みたいな

## hot reload

ってiOSでもできるの？？

## ReSwiftRouter

- presentViewControllerもReSwiftRouterに入れる？？（ルーティングって感じじゃないけど・・・）  => どっちにしろいまは`UIAlertController`つかってるから厳しそう

## MEMO

- ReSwiftRouterとかReSwiftRecorderあたりでcontributeできないか・・・
- 以前は`Swift Flow`って名前だったらしい

## Question

- ReSwiftRouterってのもあるのか・・・Router?? =>  `When building apps with ReSwift you should aim to cause all state changes through actions - this includes changes to the navigation state`
- ReSwiftRecorderってのは？？Undo/Redoかな・・・
- normalizerはないのかなぁ・・・
- アニメーションまわりがwebと同じく管理しづらいのかな・・・

## 内部実装

hogehoge

## 登場人物

- Action(Protocol)
- StandardActionConvertible(Protocol)
- StandardAction(Struct)
- Reducer(Protocol)
- State
- Store
- StateType
