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

## やること

- なにも使わずにアプリケーション（`HotChat`）をつくってみる
- 次にReSwiftでつくりなおす
- 次に画面遷移もRouterでつくりなおす
- 次にRecorderなんかでHotReloadなんかを試していきたい

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
