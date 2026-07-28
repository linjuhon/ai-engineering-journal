[← 回到本研究總綱](../README.md)

---

# 七、第一課：先看懂一筆資料到底怎麼走

## 1. 前端只收集，不計算天體

```ts
export interface BirthInput {
  birthDate: string;
  birthTime: string;
  latitude: number;
  longitude: number;
  timezone: string;
}
```

前端的責任是：
- 協助使用者輸入；
- 做快速格式提示；
- 把資料送到後端；
- 顯示後端確認過的結果。

它不能因為「看起來比較快」就在瀏覽器內自行定義天文規則。否則 Web、手機與後端可能得到三套答案。

## 2. Gateway 接受 command，不直接碰 Swiss Ephemeris

```ts
export interface CreateChartCommand {
  requestId: string;
  birth: BirthInput;
  options: {
    houseSystem: "P" | "K" | "E" | "W";
  };
}
```

Express 應負責：
- 驗證 API 契約；
- 驗證身分與權限；
- 建立 requestId／trace；
- 寫入任務紀錄；
- 呼叫計算服務；
- 把 Python 錯誤翻成穩定的 API 錯誤。

## 3. Python domain 不知道 HTTP

```py
from dataclasses import dataclass

@dataclass(frozen=True)
class BirthMoment:
    utc_iso: str
    latitude: float
    longitude: float

class EphemerisPort:
    def calculate_chart(self, moment: BirthMoment, house_system: str):
        raise NotImplementedError
```

真正的核心邏輯依賴 `EphemerisPort`，而不是直接到處呼叫 `swisseph`。這樣才能：
- 用 fake adapter 做單元測試；
- 用 Swiss adapter 跑正式計算；
- 用另一個實作做交叉驗證；
- 在星曆缺檔時提供明確錯誤。

## 4. 同一筆資料在每層的名稱不同是正常的

```text
React Form State
→ BirthInput DTO
→ CreateChartCommand
→ BirthMoment domain value
→ Swiss Ephemeris arguments
→ CelestialResult domain object
→ ChartResult DTO
→ Report ViewModel
```

重點不是「所有層共用同一個超大 interface」，而是每次轉換都有明確責任與測試。
