[← Back to technical index](../TECHNICAL_INDEX.en.md) | **English** | [繁體中文](37-first-lesson-data-flow.md)

---

# 7. First Lesson: Understand How a Single Piece of Data Flows

## 1. The Frontend Only Collects, It Does Not Compute Celestial Bodies

```ts
export interface BirthInput {
  birthDate: string;
  birthTime: string;
  latitude: number;
  longitude: number;
  timezone: string;
}
```

The frontend's responsibilities are:
- Help the user input data;
- Provide quick format hints;
- Send the data to the backend;
- Display the backend-confirmed result.

It must not define its own astronomical rules inside the browser just because "it seems faster." Otherwise the web, mobile, and backend may end up with three different answers.

## 2. The Gateway Accepts Commands, It Does Not Touch Swiss Ephemeris Directly

```ts
export interface CreateChartCommand {
  requestId: string;
  birth: BirthInput;
  options: {
    houseSystem: "P" | "K" | "E" | "W";
  };
}
```

Express should be responsible for:
- Validating the API contract;
- Verifying identity and permissions;
- Creating a requestId / trace;
- Writing a job record;
- Calling the calculation service;
- Translating Python errors into stable API errors.

## 3. The Python Domain Knows Nothing About HTTP

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

The real core logic depends on `EphemerisPort` rather than calling `swisseph` directly everywhere. This makes it possible to:
- Use a fake adapter for unit tests;
- Use a Swiss adapter for production calculations;
- Use another implementation for cross-validation;
- Provide a clear error when the ephemeris file is missing.

## 4. It Is Normal for the Same Data to Have Different Names at Each Layer

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

The point is not "all layers share one giant interface," but that every transformation has a clear responsibility and a test.
