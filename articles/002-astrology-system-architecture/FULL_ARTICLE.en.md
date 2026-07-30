[← Back to Article Index](../../README.md) | **English** | [繁體中文](FULL_ARTICLE.md)

---

# Unified Astrology System Architecture and End-to-End Data Flow: Restructured Reference Document

> **Article Type:** Architecture Blueprint  
> **Maturity:** Architecture and governance design; unverified targets are not claimed as deployed results.
>
> **Related Article:** This document is the architecture overview of the Astrology Intelligence System. For complete component contracts, training strategy, cold start, governance mechanisms, and endgame research, see [Article 006: A–E Truth–Narrative Symbiosis System (Construction Specification)](../006-astrology-truth-narrative-system/). If the two conflict on implementation details, Article 006 takes precedence.


**Subtitle:** Nine Processing Stages × 12 Core Modules × Cross-Stage Services × Automated Document Governance

**Version:** Restructured v1.0 (based on original v3.2.0-technical-debt-optimized)  
**Version Date:** 2026-07-30

**Source:** `詳細數據流分析-統一版(1).txt` (original filename)

**Document Purpose:** This document is a restructured version of the original unified master design draft, reorganizing duplicate, misplaced, fragmented markers, and contradictory passages into a readable, verifiable, and actionable architecture specification.



## Document Status and Usage Rules

- This document retains the original draft's nine stages, 12 core modules, 1,631 tags, seven databases, performance thresholds, monitoring, error handling, CI/CD, and 10-week implementation plan.

- Numbers in the original draft fall into three categories: design targets, acceptance thresholds, and verified results. Anything without test evidence is marked only as a target or claim.

- Duplicate implementations are retained only once; feature sets from different versions are unioned, but differences are listed as pending decisions.

- This is an architecture and governance document. It is not compilable complete code, nor does it prove that all services are deployed.

## Executive Summary

The core of this system is to decompose astrology services into four layers—"Input and Security," "Astronomical Calculation," "Knowledge and Intelligence," and "Prediction and Output"—connected through nine monitorable stages; tags, data management, and system operations serve as cross-stage shared services. A single master document then generates module READMEs, stage documents, and aggregated views through markers and templates.

| Stage | Name | Target Time Limit | Mode |
| --- | --- | --- | --- |
| Stage 1 | User Input | < 100ms | Real-time Mode |
| Stage 2 | Authentication & Authorization | < 50ms | Real-time Mode |
| Stage 3 | Data Parsing | < 200ms | Real-time Mode |
| Stage 4 | Celestial Calculation | < 500ms | Full Mode |
| Stage 5 | Aspect Calculation | < 300ms | Full Mode |
| Stage 6 | Knowledge Retrieval | < 200ms | Full Mode |
| Stage 7 | Intelligent Analysis | < 2,000ms | Full Mode |
| Stage 8 | Prediction Analysis | < 3,000ms | Full Mode |
| Stage 9 | Result Output | < 200ms | Full Mode |

Real-time mode consists of Stages 1–3, with an original draft target of < 350ms; Full mode consists of Stages 4–9, with the original draft claiming < 5,500ms, and Stage 4 and Stage 6 running in parallel to save 200ms. Note: the individual upper limits of the nine stages do not sum to 5,500ms when added directly; therefore the total time limit must be redefined as a p95 budget, a typical value, or a branching flow, rather than adding all maximums together and still claiming compliance.

## Key Decisions in This Restructuring

| Issue | Original Draft Status | Restructured Handling |
| --- | --- | --- |
| Zero Technical Debt | Written as completed, but the body still contains duplicates, breaks, and misalignments | Treated as a target state; actual state must be proven by validators and cleanup reports |
| Full Mode < 5,500ms | Individual upper limits total 6,200ms; parallel savings of 200ms still yield 6,000ms | Listed as a performance budget gap, requiring clear definition of typical value, p95, or optional stages |
| Stage 4 and 6 Parallel | One place says Stage 6 depends only on birth data, another says it depends on celestial and aspect results | Recommend splitting into early knowledge prefetch and final context retrieval; pending architecture approval |
| Frontend UI | Global mentions Ant Design, Stage 1 detailed plan uses Material-UI v5 | Conflict retained; one must be selected before implementation |
| Module Numbering | Has 00–10 and 12, no 11 | Original numbering retained; 11 treated as a reserved slot, no module added arbitrarily |
| Generated Document Count | 48 module files and 60+ total files appear simultaneously | Unified interpretation: 48 module files + 9 stage files + aggregated/service files |



# Part I System Positioning and Architecture Principles

## 1. System Goals

The system accepts birth time and location, calculates planets, houses, aspects, and special celestial points, then retrieves evidence from knowledge bases and case libraries, uses AI to generate personalized interpretations, and finally performs transit/progression predictions and outputs reports. The architecture simultaneously pursues low latency, traceability, scalability, recoverability, and automated document synchronization.

## 2. Four Core Principles

- **Stage-Oriented:** Each stage has clear inputs, outputs, time limits, responsible modules, monitoring, and error strategies.

- **Single Source of Truth:** All derived documents are generated from the unified master document; editing the generated files directly to maintain architectural truth is prohibited.

- **Cross-Stage Shared Services:** Tagging, data, and operations capabilities are not duplicated into each business stage but are provided via interfaces.

- **Quality and Technical Debt Front-Loading:** Large documents, dense configuration, dense code blocks, and multi-tech-stack content are identified at input time and subjected to different quality rules.

## 3. Logical Layers

| Layer | Stages/Modules Included | Primary Responsibility |
| --- | --- | --- |
| Interaction and Security Layer | Stages 1–3; 02, 08, 00, 06, 09 | Input, validation, authorization, parsing, standardization |
| Core Calculation Layer | Stages 4–5; 01, 00, 06, 09 | Astronomical positions, houses, aspects, and patterns |
| Knowledge and Intelligence Layer | Stages 6–7; 03, 04, 06, 09 | Retrieval, cases, AI interpretation, personalization |
| Prediction and Delivery Layer | Stages 8–9; 05, 07, 08, 02, 06, 09 | Prediction, quantification, reports, API and file output |
| Engineering Governance Layer | 10, 09, Document Processor | CI/CD, containers, monitoring, quality, and document synchronization |

## 4. Technology Stack Overview

| Domain | Original Draft Technology Choice | Purpose |
| --- | --- | --- |
| Main Backend | TypeScript, Node.js, Express, TypeORM | API, users, business processes, report coordination |
| Celestial Calculation | Python, FastAPI, Swiss Ephemeris, Astropy, NumPy | Ephemeris, coordinates, houses, astronomical algorithms |
| AI/ML | Python, FastAPI, TensorFlow, Transformers | Interpretation, patterns, prediction models |
| Frontend | React, TypeScript, Redux Toolkit; globally listed Ant Design | Input forms, real-time validation, result display |
| Infrastructure | Docker, Kubernetes, Microservices | Deployment, scaling, isolation, and failure recovery |
| Observability | Prometheus, Grafana, Jaeger | Metrics, dashboards, distributed tracing |
| CI/CD | GitHub Actions | Validation, testing, document generation, deployment |



# Part II End-to-End Data Flow

## 5. Dual-Mode Processing Strategy

Real-time mode is responsible for letting the user quickly know "whether data is available, whether identity is valid, and how the system will calculate"; Full mode is responsible for heavy computation, knowledge, AI, prediction, and reports. Both modes should share requestId, traceId, version, and a state machine; the user can first receive an accepted/validated response, then stream progress and full results.

| Mode | Stages | Original Draft Total Target | Recommended Semantics |
| --- | --- | --- | --- |
| Real-time Mode | 1–3 | < 350ms | Synchronous completion, returns validation and task identification |
| Full Mode | 4–9 | < 5,500ms | Asynchronous/streaming completion; total budget must be re-closed |
| Parallel Optimization | 4 and 6 | Save 200ms, improve 28.6% | Only applicable to prefetch portions that do not depend on final celestial/aspect results |

## 6. Recommended Standard Processing Envelope

Each stage should receive and return a unified processing envelope, avoiding data existing only in a temporary object of some service:

```text
ProcessingEnvelope {
  requestId, traceId, userId, stage, status,
  inputVersion, schemaVersion, algorithmVersion, modelVersion,
  startedAt, finishedAt, processingTimeMs,
  payloadRef, resultRef, qualityScore, confidence,
  warnings[], errors[], provenance[]
}
```

The original draft already contains requestId, processingTime, timestamp, version, qualityScore, and other fields scattered throughout; the restructured version elevates these into a full-flow contract. This is a unified scheme derived from original draft elements and still needs to be finalized in interface specifications.

# Part III · Stage 1 User Input Stage

## 1.1 Stage Positioning and Time Limit

**Target Time Limit:** < 100ms　　**Mode:** Real-time Mode

Receives birth data, location, timezone, and output preferences, performs format validation, standardization, and initial risk pre-check, so that subsequent stages only process structured and traceable data.

## 1.2 Input Data

- Birth date (YYYY-MM-DD, original draft sets 1900–2100)

- Birth time (HH:mm:ss)

- Latitude (-90 to 90) and Longitude (-180 to 180)

- IANA timezone identifier

- Optional place name, house system, aspect orbs, output format, and user preferences

## 1.3 Core Processing Flow

1. Format validation: required fields, types, date/time format, coordinate range, timezone identifier.

2. Format standardization: date to ISO 8601, time to 24-hour format, coordinates to six decimal places, timezone name standardization.

3. Error classification: INVALID_DATE_FORMAT, INVALID_TIME_FORMAT, INVALID_COORDINATES, INVALID_TIMEZONE, MISSING_REQUIRED_FIELD.

4. Initial tagging and data storage: tag system, data management, monitoring services process in parallel.

5. Technical debt pre-check: document size, configuration density, number of code blocks, number of technology stacks, and quality risk level.

## 1.4 Output and Responsibility Boundary

- ValidatedInput / ProcessedInput

- requestId and processing time

- Standardized birth data and initial tags

- Storage location, validation score, errors or warnings

**Participating Modules:** Primary: 02-API Service, 08-User Service; Supporting: 00-Tag System, 06-Data Management, 09-System Operations

**Data Strategy:** PostgreSQL stores structured input; Redis holds sessions and short-term validation cache; MongoDB/Elasticsearch stores metadata, tags, and search indices.

## 1.5 Primary Interfaces/Services

- POST /api/v1/charts/validate-input

- POST /api/v1/charts/quick-validate

- POST /api/v1/charts/batch-validate

- WebSocket validate:realtime / validate:batch

- GraphQL validateInput / validateField / standardizeInput

## 1.6 Performance and Quality Thresholds

- Total processing < 100ms

- Validation accuracy > 99.9%

- Throughput > 1,000 req/s

- Error rate < 0.1%

- Technical debt prevention accuracy > 95%

- Quality risk prediction accuracy > 90%

## 1.7 Errors and Recovery

Input issues should be fed back immediately with guidance for correction; network errors can be retried three times then degraded; system errors must retain requestId, stage, stack trace, and processing time.

## 1.8 Original Draft Differences and Pending Decisions

The original draft simultaneously presents two frontend UI standards: Ant Design and Material-UI v5; the restructured version retains this difference, which should be unified by an architectural decision before implementation.

# Part III · Stage 2 Authentication and Authorization Stage

## 2.1 Stage Positioning and Time Limit

**Target Time Limit:** < 50ms　　**Mode:** Real-time Mode

Verifies user identity, session validity, and resource operation permissions, and completes rate limiting and security risk checks before entering core computation.

## 2.2 Input Data

- JWT access token

- sessionId / userId

- Target resource and operation

- Source IP, request frequency, and security context

## 2.3 Core Processing Flow

1. JWT format, signature, expiration, and blacklist check.

2. User existence, activation status, and session state check.

3. RBAC: role mapping, resource access, and operation authorization.

4. Security policies: rate limiting, IP whitelist, suspicious activity detection, and security logging.

## 2.4 Output and Responsibility Boundary

- AuthenticationResult

- user and permissions

- Authorization result and security event records

**Participating Modules:** Primary: 02-API Service; Supporting: 06-Data Management, 09-System Operations

**Data Strategy:** PostgreSQL stores accounts, roles, and credentials; Redis stores sessions, token state, and permission cache; Elasticsearch stores security events.

## 2.5 Primary Interfaces/Services

- POST /api/v1/auth/login

- POST /api/v1/auth/refresh

- GET /api/v1/auth/verify

- AuthenticationMiddleware

- AuthorizationMiddleware

## 2.6 Performance and Quality Thresholds

- Total processing < 50ms

- Token verification < 20ms

- Authorization check approximately < 20ms

- Authentication success rate > 99.5%

- Security compliance rate 100%

## 2.7 Errors and Recovery

Validation failure should reject the request and log the reason; RBAC check anomalies default to deny; blacklisted tokens and abnormal logins should trigger security alerts.

## 2.8 Original Draft Differences and Pending Decisions

The original draft reads JWT_SECRET directly from environment variables; actual deployment still needs to integrate secret management, rotation, and auditing.

# Part III · Stage 3 Data Parsing Stage

## 3.1 Stage Positioning and Time Limit

**Target Time Limit:** < 200ms　　**Mode:** Real-time Mode

Converts validated input into parameter objects that the calculation engine can directly consume, filling in timezone, geographic location, default values, and processing metadata.

## 3.2 Input Data

- ValidatedInput

- Validation result and requestId

- User preferences, calculation options, and output requirements

## 3.3 Core Processing Flow

1. Parallel extraction of birth data, calculation parameters, user preferences, and output format.

2. Logical validation: date-time consistency, location validity, calculation option and output format support.

3. Data enrichment: timezone resolution, place name to coordinate conversion, default value assignment, and metadata generation.

4. Parsing result tagging, caching, and quality score recording.

## 3.4 Output and Responsibility Boundary

- ParsedData

- BirthData

- CalculationParams

- UserPreferences

- OutputFormat

- qualityScore / complexityScore

**Participating Modules:** Primary: 02-API Service, 00-Tag System; Supporting: 06-Data Management, 09-System Operations

**Data Strategy:** Redis caches parsing results; PostgreSQL stores parameter configurations; MongoDB stores parsing history; Elasticsearch stores metadata indices.

## 3.5 Primary Interfaces/Services

- DataParsingService

- ParameterExtractor

- DataValidator

- DataEnricher

- FormatConverter

## 3.6 Performance and Quality Thresholds

- Total processing < 200ms

- Input parsing < 100ms

- Parameter validation < 50ms

- Data enrichment < 50ms

- Parsing accuracy > 99.9%

- Parameter completeness 100%

## 3.7 Errors and Recovery

Missing parameters, date-time contradictions, location and timezone inconsistencies, unsupported house systems or output formats should be split into error and warning, retaining the quality score.

## 3.8 Original Draft Differences and Pending Decisions

The original draft for this stage contains a large number of duplicate classes, duplicate extractBirthData, and fragmented markers; the restructured version retains only one consistent flow. Original draft defaults include placidus, standard orbs, traditional planets, high precision.

# Part III · Stage 4 Celestial Calculation Stage

## 4.1 Stage Positioning and Time Limit

**Target Time Limit:** < 500ms　　**Mode:** Full Mode

Generates high-precision celestial positions, houses, special points, and necessary astronomical correction data based on birth time, location, and calculation parameters.

## 4.2 Input Data

- BirthData

- CalculationParams

- Ephemeris version and precision settings

## 4.3 Core Processing Flow

1. Convert local time to UTC, calculate Julian day and local sidereal time.

2. Parallel calculation of planetary positions and house systems.

3. Calculate optional items: lunar nodes, asteroids, Arabic parts, solar/lunar eclipses, retrograde/stationary, lunar phases, etc.

4. Perform ecliptic/equatorial/horizontal coordinate transformations and corrections for precession, nutation, aberration, and atmospheric refraction.

5. Precision validation, result tagging, caching, storage, and monitoring.

## 4.4 Output and Responsibility Boundary

- PlanetaryPositions

- HouseSystem

- SpecialPoints

- CelestialPhenomena

- CalculationMetadata

**Participating Modules:** Primary: 01-Celestial Calculation Engine; Supporting: 00-Tag System, 06-Data Management, 09-System Operations

**Data Strategy:** Redis caches repeated calculation results; PostgreSQL stores structured results; MongoDB stores full charts and ephemeris metadata; TimescaleDB stores position time series.

## 4.5 Primary Interfaces/Services

- CelestialCalculationService

- PlanetaryPositionCalculator

- HouseSystemCalculator

- AstronomicalAlgorithms

- CoordinateTransformer

- PrecisionController

## 4.6 Performance and Quality Thresholds

- Total processing < 500ms

- Planetary positions approximately < 200–300ms

- Houses approximately < 100–150ms

- Precision > 99.9%

- Data integrity 100%

- Cache hit rate > 80%

- Concurrent computation > 100 req/s

## 4.7 Errors and Recovery

Missing ephemeris, insufficient precision, calculation timeout, or unsupported house system. The original draft plans for fallback algorithms, multiple data sources, dynamic precision reduction, and automatic retry.

## 4.8 Original Draft Differences and Pending Decisions

The set of house systems listed in the original draft is not entirely consistent; the restructured version retains their union: Placidus, Koch, Equal, Whole Sign, Campanus, Regiomontanus, Topocentric. The asteroid union includes Chiron, Ceres, Pallas, Juno, Vesta.

# Part III · Stage 5 Aspect Calculation Stage

## 5.1 Stage Positioning and Time Limit

**Target Time Limit:** < 300ms　　**Mode:** Full Mode

From celestial ecliptic longitudes, establishes planet pairs, calculates the shortest angular distance, identifies valid aspects and orbs, and evaluates strength, applying/separating state, and composite patterns.

## 5.2 Input Data

- PlanetaryPositions

- House and dignity information

- OrbSettings / AspectTypes

## 5.3 Core Processing Flow

1. Generate all planet pairs and calculate the shortest angular distance (0–180°).

2. Determine orbs according to definitions for conjunction, opposition, trine, square, sextile, and minor aspects.

3. Calculate strength factors: exactness, planetary dignity, house position, aspect nature, etc.

4. Identify composite patterns: grand trine, T-square, grand cross, Yod, stellium, etc.

5. Aspect tagging, relationship graph storage, statistics, and monitoring.

## 5.4 Output and Responsibility Boundary

- AspectCalculationResult

- ValidAspect[]

- AspectWithStrength[]

- CompositePatterns

- AspectStatistics

**Participating Modules:** Primary: 01-Celestial Calculation Engine; Supporting: 00-Tag System, 06-Data Management, 09-System Operations

**Data Strategy:** Redis caches aspect results; PostgreSQL stores aspect configurations and structured results; MongoDB stores history; Neo4j stores aspect relationship graphs; TimescaleDB stores statistics.

## 5.5 Primary Interfaces/Services

- AspectCalculationService

- OrbCalculator

- AspectStrengthAnalyzer

- CompositeAspectAnalyzer

## 5.6 Performance and Quality Thresholds

- Total processing < 300ms

- Angle and aspect identification approximately < 200ms

- Strength and patterns approximately < 100ms

- Aspect accuracy > 99.9%

- Calculation efficiency > 95%

- Result consistency 100%

## 5.7 Errors and Recovery

Invalid orb configuration, missing planetary data, angular unit errors, or pattern algorithm anomalies. Should retain raw angle, target angle, orb, and algorithm version for traceability.

## 5.8 Original Draft Differences and Pending Decisions

The original draft simultaneously provides "set orb by planet category" and four strategies: tight/standard/wide/custom; should be unified with a versioned OrbPolicy rather than scattered throughout the code.

# Part III · Stage 6 Knowledge Retrieval Stage

## 6.1 Stage Positioning and Time Limit

**Target Time Limit:** < 200ms　　**Mode:** Full Mode

Based on the chart, aspects, and user context, retrieves citable, rankable, and personalizable evidence material from knowledge bases, case libraries, vector indices, and knowledge graphs.

## 6.2 Input Data

- CelestialCalculationResult

- AspectCalculationResult

- UserContext

- Query tags and topics

## 6.3 Core Processing Flow

1. Parallel query of planet, sign, house, aspect, and composite pattern knowledge.

2. Case matching: vector similarity, rule patterns, house emphasis, and overall theme.

3. Personalization based on user level, interests, culture, and language preferences.

4. Relevance ranking, threshold filtering, caching, and monitoring.

## 6.4 Output and Responsibility Boundary

- KnowledgeRetrievalResult

- KnowledgeItem[]

- CaseMatch[]

- PersonalizedInsights

- RelevanceMetrics

**Participating Modules:** Primary: 03-Knowledge Base Management; Supporting: 06-Data Management, 09-System Operations

**Data Strategy:** Elasticsearch for full-text search; MongoDB for knowledge and case content; Pinecone for semantic vectors; PostgreSQL for user preferences; Neo4j can support relationship queries.

## 6.5 Primary Interfaces/Services

- KnowledgeQueryService

- CaseMatchingEngine

- PersonalizationService

- RelevanceRanker

## 6.6 Performance and Quality Thresholds

- Total processing < 200ms

- Knowledge query < 120ms

- Case matching < 50ms

- Personalization < 30ms

- Retrieval accuracy > 90%

- Knowledge coverage > 95%

- Relevance > 85%

## 6.7 Errors and Recovery

Index unavailable, vector service timeout, insufficient results, or relevance too low. Should fall back to full-text search, rule base, or a lower personalization tier.

## 6.8 Original Draft Differences and Pending Decisions

One place in the original draft claims Stages 4 and 6 can run directly in parallel, while another requires Stage 6 to use celestial and aspect results. After restructuring, this should be explicitly split into "early prefetch" and "final context retrieval" two phases; this is a specification awaiting formal confirmation and should not be treated as closed.

# Part III · Stage 7 Intelligent Analysis Stage

## 7.1 Stage Positioning and Time Limit

**Target Time Limit:** < 2,000ms　　**Mode:** Full Mode

Integrates the structured chart, aspects, knowledge evidence, and user context into traceable astrological interpretations, pattern judgments, and personalized insights.

## 7.2 Input Data

- CelestialData

- AspectData

- KnowledgeData

- UserContext

## 7.3 Core Processing Flow

1. Pattern recognition and AI interpretation execute in parallel.

2. Identify patterns such as grand trine, T-square, grand cross, Yod, stellium, and generate confidence levels.

3. Transformer-class generative models produce interpretations; rule bases, case libraries, and psychological models provide constraints.

4. Contextual analysis: personality, life themes, challenges and opportunities, relationship patterns, etc.

5. Synthesized insights, confidence indicators, model version, data sources, and monitoring records.

## 7.4 Output and Responsibility Boundary

- IntelligentAnalysisResult

- PatternAnalysis

- AIInterpretation

- PersonalizedAnalysis

- SynthesizedInsights

- ConfidenceMetrics

**Participating Modules:** Primary: 04-Astrology Intelligence Engine; Supporting: 03-Knowledge Base Management, 09-System Operations

**Data Strategy:** Analysis results, model versions, prompts, and quality indicators should be stored in the data management service; knowledge references must retain traceable IDs.

## 7.5 Primary Interfaces/Services

- AIInterpretationService

- PatternRecognitionEngine

- PersonalityAnalyzer

- ContextualAnalyzer

## 7.6 Performance and Quality Thresholds

- Total processing < 2,000ms

- AI interpretation approximately < 1,500ms

- Pattern recognition < 300ms

- Personalization < 200ms

- Analysis accuracy > 85%

- Interpretation quality > 80%

- Pattern recognition rate > 90% (monitoring target)

## 7.7 Errors and Recovery

Model unavailable, confidence too low, pattern recognition failure. The original draft plans for fallback models, rule engine, traditional analysis methods, and low-confidence manual review.

## 7.8 Original Draft Differences and Pending Decisions

"Accuracy" and "interpretation quality" must have clearly annotated datasets, raters, sample sizes, and versions; otherwise they can only be treated as design targets, not verified results.

# Part III · Stage 8 Prediction Analysis Stage

## 8.1 Stage Positioning and Time Limit

**Target Time Limit:** < 3,000ms　　**Mode:** Full Mode

Uses transits, progressions, solar returns, lunar phase cycles, and statistical models to generate time windows, trends, risks, uncertainty, and quantitative confidence.

## 8.2 Input Data

- IntelligentAnalysisResult

- NatalChart

- TimePeriod

- HistoricalData

- UserContext

## 8.3 Core Processing Flow

1. Tasks such as transits, secondary progressions, solar arcs, return charts, and lunar phase cycles run in parallel.

2. Synthesize scores and weights from different techniques to identify key time windows.

3. Perform trend, correlation, regression, time series, pattern, and probability analysis.

4. Calculate accuracy, confidence intervals, risk, performance, cross-validation, and benchmark comparison.

5. Model training, registration, version control, deployment health check, and rollback plan.

## 8.4 Output and Responsibility Boundary

- PredictionAnalysisResult

- Predictions

- StatisticalAnalysis

- RiskAssessment

- SynthesizedForecast

- UncertaintyRange

**Participating Modules:** Primary: 05-Prediction and Quantitative Analysis; Supporting: 06-Data Management, 09-System Operations

**Data Strategy:** TimescaleDB for history and trends; PostgreSQL for model and result indices; MongoDB for model parameters and full results; Redis for statistical cache.

## 8.5 Primary Interfaces/Services

- PredictionModelService

- TransitCalculator

- ProgressionCalculator

- SolarArcCalculator

- ReturnChartCalculator

- StatisticalAnalysisEngine

- QuantitativeAssessmentEngine

- ModelManagementEngine

## 8.6 Performance and Quality Thresholds

- Total processing < 3,000ms

- Prediction modeling < 2,000ms

- Statistical analysis < 800ms

- Risk assessment < 200ms

- Prediction accuracy > 80%

- Model confidence > 75%

- Statistical significance > 95%

## 8.7 Errors and Recovery

Model service failure, insufficient historical data, invalid statistical assumptions, confidence too low, or time range too large. Output must explicitly indicate uncertainty; probabilities must not be presented as certainties.

## 8.8 Original Draft Differences and Pending Decisions

The original draft claims historical data exceeding one million records, compression rate 85%, etc., without supporting verification evidence; the restructured version retains these as planned scale/targets, not marked as completed achievements. Quantitative total score weights: accuracy 35%, confidence 25%, risk 20%, performance 20%.

# Part III · Stage 9 Result Output Stage

## 9.1 Stage Positioning and Time Limit

**Target Time Limit:** < 200ms　　**Mode:** Full Mode

Assembles the results from the preceding calculation, knowledge, intelligent analysis, and prediction into a full, summary, visual, or interactive report, and delivers it via API or file format.

## 9.2 Input Data

- PredictionAnalysisResult

- UserContext

- OutputOptions

## 9.3 Core Processing Flow

1. Parallel generation of report content and formatted data.

2. Generate sections: summary, celestial analysis, aspect analysis, personality insights, predictions, and recommendations.

3. Output JSON, PDF, HTML, or XML.

4. Perform checks for completeness, format consistency, content accuracy, readability, and user experience.

5. Save output, generate download links, record quality score and total processing time.

## 9.4 Output and Responsibility Boundary

- FinalOutputResult

- ReportContent

- FormattedData

- DownloadLinks

- QualityMetrics

**Participating Modules:** Primary: 07-Report Generation, 08-User Service, 02-API Service; Supporting: 09-System Operations

**Data Strategy:** Final reports, formatted data, quality indicators, and artifact locations are stored by the data management service; large files should go to object storage, which the original draft does not explicitly specify.

## 9.5 Primary Interfaces/Services

- ReportGenerationService

- TemplateProcessor

- FormatConverter

- QualityController

- UIRenderingService

- ResponseFormatter

## 9.6 Performance and Quality Thresholds

- Total processing < 200ms

- Report generation < 120ms

- Format conversion < 50ms

- Quality check < 30ms

- Output completeness 100%

- Format consistency 100%

- User satisfaction > 90%

## 9.7 Errors and Recovery

Missing report sections, template errors, format conversion failure, quality threshold not met. Should refuse to mark as successful and retain reconstructable intermediate results.

## 9.8 Original Draft Differences and Pending Decisions

Generating a complete PDF/interactive report in real time within 200ms may only be feasible for pre-assembled or cached results; "API response time" and "heavy file rendering time" need to be measured separately.

# Part IV Module Architecture and Dependency Governance

## 7. 12 Core Modules

| ID | Module | Core Responsibility | Participating Stages | Technology/Assets | Dependency Summary |
| --- | --- | --- | --- | --- | --- |
| 00 | Tag System | Cross-stage vocabulary, classification, and semantic standardization base service | 1, 3, 4, 5 | TypeScript + Node.js + Redis | No dependencies; used by most modules |
| 01 | Celestial Calculation Engine | Planetary positions, houses, astronomical corrections, and aspect calculation | 4, 5 | Python / Swiss Ephemeris; external service can be wrapped by FastAPI | Depends on 00, 06; provides to 04, 05 |
| 02 | API Service | Request reception, authentication, parsing, routing, and final API response | 1, 2, 3, 9 | TypeScript + Node.js + Express + TypeORM | Depends on 00, 06, 09; provides to 08 |
| 03 | Knowledge Base Management | Knowledge business logic, query, case matching, ranking, and quality evaluation | 6, 7 | TypeScript business layer + search/vector service interfaces | Depends on 00, 06; provides to 04, 05, 12 |
| 04 | Astrology Intelligence Engine | AI interpretation, pattern recognition, and personalized analysis | 7 | Python + FastAPI + Transformers / TensorFlow (original draft) | Depends on 00, 01, 03, 06; provides to 05, 12 |
| 05 | Prediction and Quantitative Analysis | Transits, progressions, statistics, risk, and model management | 8 | Python + time series/statistical/ML tools | Depends on 00, 01, 03, 04, 06; provides to 12 |
| 06 | Data Management | Seven database types, cache, search, connection pools, backup, and consistency | 1, 2, 3, 4, 5, 6, 8 | PostgreSQL / MongoDB / Redis / Elasticsearch / Pinecone / Neo4j / TimescaleDB | No dependencies; provides to 01, 02, 03, 04, 05, 07, 08 |
| 07 | Report Generation | Templates, content assembly, format conversion, and output quality control | 9 | TypeScript / report rendering tools | Depends on 00, 06 |
| 08 | User Service | Frontend forms, result display, interaction, and feedback | 1, 9 | React + TypeScript + Redux Toolkit | Depends on 00, 02, 06 |
| 09 | System Operations | Full-stage monitoring, tracing, alerting, health checks, and recovery | 1–9 | Prometheus + Grafana + Jaeger | No dependencies; supports 02 and the entire system |
| 10 | Development and Deployment | CI/CD, containers, Kubernetes, toolchain, and release governance | Cross-cutting | Docker + Kubernetes + GitHub Actions | Infrastructure layer; no business dependencies |
| 12 | Instances and Examples | Test data, case libraries, validation scenarios, and teaching support | Validation support | Fixtures / Examples / Test harness | Depends on 00, 03, 04, 05 |

## 8. Dependency Levels

- **Level 0 Foundation Layer:** 00 Tags, 06 Data, 09 Operations, 10 Development and Deployment; original draft claims no upstream business dependencies.

- **Level 1 Core Calculation Layer:** 01 Celestial Calculation, 03 Knowledge Base.

- **Level 2 Knowledge Analysis Layer:** 04 Intelligence Engine, 05 Prediction and Quantitative.

- **Level 3 Service Presentation Layer:** 02 API, 07 Reports, 08 User Service.

- **Level 4 Validation Support Layer:** 12 Instances and Examples.

The original draft counts 24 dependencies total, zero circular dependencies; 00 is depended on by 9 modules, 06 by 7 modules, 05 has the most dependencies (5). These are design matrix declarations and must be continuously verified by the actual import graph, service dependency graph, and CI checks.

## 9. Key Responsibility Isolation

| Boundary | Allowed | Prohibited |
| --- | --- | --- |
| 03 Knowledge Base vs 06 Data Management | 03 manages business queries, ranking, cases, and quality; 06 manages connections, storage, cache, backup | 03 directly managing DB connections; 06 writing astrology business logic |
| 01 Calculation vs 04 Intelligence | 01 produces verifiable astronomical data; 04 does interpretation and patterns | AI model recalculating astronomical positions or altering algorithmic truth |
| 02 API vs 08 User Service | 02 provides stable contracts; 08 handles display and interaction | Frontend depending on internal DB schema or backend returning unversioned objects |
| 07 Reports vs 09 Operations | 07 controls content and format; 09 monitors generation time, failures, and resources | Monitoring service rewriting report content |



# Part V Cross-Stage Shared Services

## 10. Tag System: 1,631 Tags

| Type | Count | Definition | Example |
| --- | --- | --- | --- |
| Atomic Tags | 168 | Indivisible planetary, sign, house, aspect vocabulary | Sun, Aries, 1st House, Conjunction |
| Core Tags | 216 | Core astrological structures formed by combining atomic tags | Sun in Aries, Moon in 7th House, Sun Conjunct Moon |
| Professional Tags | 1,247 | Professional semantics for interpretation, career, relationships, health, etc. | Leadership ability, Artistic talent, Relationship patterns |

The tag system participates in Stages 1, 3, 4, and 5, responsible for vocabulary standardization, synonym mapping, multilingual support, hierarchical relationships, circular reference detection, and orphan node cleanup. Tags are not arbitrary keywords but should have an ID, version, parent-child relationships, scope, source, and deprecation status.

## 11. Seven Database Collaboration

| Database | Role | Primary Data | Target Latency | Governance Focus |
| --- | --- | --- | --- | --- |
| PostgreSQL | Relational primary data | Users, credentials, configurations, calculation and prediction indices | < 50ms target | Transaction consistency, indices, and connection pools |
| MongoDB | Document content | Charts, knowledge, cases, analysis reports, historical records | < 30–50ms target | Flexible schema, compound indices, and sharding |
| Redis | High-speed cache/session | Sessions, validation, parsing, calculation, aspect, and statistical cache | 1–5ms target | TTL, eviction policy, and cache consistency |
| Elasticsearch | Full-text search/logs | Knowledge content, input history, security and system logs | < 100–200ms target | Index versioning, mappings, and relevance |
| Pinecone | Vector search | Knowledge vectors, case vectors, pattern similarity | < 200ms target | Embedding version, namespaces, and recall rate |
| Neo4j | Graph relationship analysis | Aspect networks, knowledge graphs, and pattern associations | Service target < 150ms; global upper limit once listed as 500ms | Query depth, hot nodes, and cost |
| TimescaleDB | Time series data | Ephemeris, performance, historical trends, and prediction time series | < 80–100ms target | Partitioning, retention policy, and compression |

For cross-database consistency, the original draft lists three strategies: two-phase commit, Saga, and event sourcing. These cannot be used ambiguously at the same time during implementation; the choice should be based on business type: core accounting/identity uses relational transactions; long-running flows use Saga; analysis and reports use events and reconstructable artifacts. Recovery targets: RTO < 1 hour, RPO < 15 minutes.

## 12. System Operations and Observability

- Prometheus: stage latency, success/failure, resources, business quality metrics; original draft retains 30 days.

- Grafana: nine-stage overview, single-stage details, shared services, health status, and error trends.

- Jaeger: cross-stage trace; critical path 100% sampling, general requests 10% sampling.

- Alerts: Critical response < 5 minutes, Warning < 15 minutes, Info < 1 hour.

- Alert channels: Slack, Email, SMS, Webhook; same-type alerts suppressed for 5 minutes, downstream storm suppression on dependency failure.

- Health checks: databases, cache, external services, each Stage service, corresponding to live/ready/startup.

# Part VI Performance, Reliability, and Security

## 13. Performance Budget Table

| Stage | Target | Alert/Caution |
| --- | --- | --- |
| Stage 1 | < 100ms | > 120ms alert; validation accuracy requires a test set |
| Stage 2 | < 50ms | Token and permission cache must not sacrifice revocation timeliness |
| Stage 3 | < 200ms | Parsing, validation, enrichment need segmented timing |
| Stage 4 | < 500ms | > 600–700ms alert; precision and cache hit rate are parallel concerns |
| Stage 5 | < 300ms | Pairing is O(n²) as planet count increases |
| Stage 6 | < 200ms | Full-text, vector, and graph queries need separate measurement |
| Stage 7 | < 2,000ms | Model inference, retrieval, and post-processing must not be conflated into a single number |
| Stage 8 | < 3,000ms | Long time ranges should be converted to background tasks or precomputation |
| Stage 9 | < 200ms | API assembly and PDF rendering need to be separated |

## 14. Total Time Limit Closure Problem

The original draft's stage upper limits total 6,200ms; if Stages 4 and 6 completely overlap, theoretically only 200ms is saved, still yielding 6,000ms. Therefore "Full Mode < 5,500ms" cannot be derived from the current numbers. One of the following formal definitions may be adopted:

- Each stage value is an independent worst-case; the overall 5,500ms is a typical p95, and the two are not directly additive; measured distributions must be provided.

- Stage 8 is optional or deferred; the full natal analysis excludes predictions; predictions are a separate task.

- Certain subtasks of Stages 7 and 8 run in parallel, or Stage 9 streams the response first and generates the file later.

- Correct the full mode threshold to < 6,000ms and reset each stage's budget.

Until the performance definition is closed, "< 5,500ms achieved" must not be used as an acceptance conclusion.

## 15. Unified Error Model

| Level | Original Draft Handling | Restructured Requirement |
| --- | --- | --- |
| Critical | Immediately stop subsequent stages | Retain full context, trigger circuit breaker/fallback, must not output success |
| Medium | Log and continue | Output degraded status and affected functionality, must not hide |
| Low | Log only | Retain warning and source, allow normal completion |

Common recovery mechanisms include circuit breaker, graceful degradation, automatic retry, fallback mode. Each retry must have an idempotency key, maximum count, backoff strategy, and error classification, to avoid infinite retries of logic errors.

## 16. Security Baseline

- JWT signing, expiration, revocation, and session consistency; secrets must not be hardcoded, require rotation and least privilege.

- Beyond RBAC, resource ownership and data scope checks are still required.

- Input sanitization, rate limiting, anomalous pattern detection, sensitive data masking, and audit logging.

- Data in transit and at rest, backups, and logs must all be encrypted and subject to sensitivity rules; the document generation flow simultaneously scans for secrets, PII, and internal configurations that should not be public.

# Part VII Quality and Technical Debt Governance

## 17. 218 Technical Debt Items Analysis

| Batch | Count | Percentage | Primary Issues |
| --- | --- | --- | --- |
| Batch 3 | 189 | 86.7% | Main source: 41,965 lines of development/deployment guide and insufficient large-document processing |
| Batch 7 | 20 | 9.2% | Incomplete operations documentation |
| Batch 4 | 4 | 1.8% | Insufficient algorithm explanation |
| Batch 5 | 2 | 0.9% | API format inconsistency |
| Batch 6 | 3 | 1.4% | Missing template metadata |
| Total | 218 | 100% | Original draft technical debt analysis base |

The original draft's root cause conclusions are: insufficient large-document processing strategy, insufficient configuration document detection precision, limited auto-repair coverage, lack of differentiated rules by document type, and unclear manual review triggers. The plan is divided into immediate cleanup, short-term refactoring, and long-term prevention, expecting to eliminate 95% of technical debt and improve quality by 25%. These are plan targets and still need to be proven with checklists and verification reports.

## 18. Five-Dimensional Quality Model

| Dimension | Weight | Check Content |
| --- | --- | --- |
| Content Completeness | 30% | Required sections, example coverage, sufficient explanation, cross-references |
| Structural Completeness | 35% | Heading levels, section logic, format consistency, clear navigation |
| Content Richness | 25% | Technical depth, examples, best practices, troubleshooting |
| Metadata Completeness | 10% | Version, update time, author, tag classification |

## 19. Complexity Trigger Conditions

- Document exceeds 10,000 lines: initiate complexity assessment and higher-frequency checks.

- Configuration examples exceed 50, code blocks exceed 100, technology stacks exceed 3: apply differentiated standards.

- Document exceeds 40,000 lines: automatically split by technology stack module, increase manual review, adopt progressive processing.

- Configuration documents: increase syntax, template, and example executability checks.

- Operations documents: mandatory checks for error handling, step completeness, environment dependencies, and rollback procedures.

## 20. Correct Definition of Zero Technical Debt

"Zero technical debt" should be a production release gate, not a self-declaration. At a minimum, all of the following must be simultaneously true: all markers are paired, no duplicate canonical sections, generated results are reproducible, content consistency checks pass, unresolved issues have a clear owner/deadline/risk, and any exemptions are versioned. The original draft's own duplication and fragmentation prove it has not yet achieved this state.

# Part VIII Automated Document Management

## 21. Single Source of Truth and Marker System

The master document uses HTML comment markers for Stage, responsibility, module, cross-stage service, technical implementation, performance, and implementation plan. The processor parses these sections to generate 12 module derived documents, 9 stage documents, shared services, and aggregated views. Generated documents must be marked "Do Not Edit Directly" with the source version.

| Marker Type | Example |
| --- | --- |
| Complete Stage | <!-- STAGE_01_COMPLETE_START --> … <!-- STAGE_01_COMPLETE_END --> |
| Stage Responsibilities | <!-- STAGE_01_RESPONSIBILITIES_START --> |
| Stage Modules | <!-- STAGE_01_MODULES_START --> |
| Technical Implementation | <!-- STAGE_01_TECHNICAL_IMPLEMENTATION_START --> |
| Shared Services | <!-- TAG_SYSTEM_SERVICE_START --> / DATA_MANAGEMENT / SYSTEM_MONITORING |
| Aggregated Views | <!-- MODULE_MATRIX_START --> / PERFORMANCE_SUMMARY / IMPLEMENTATION_STATUS |

## 22. Document Processor Flow

- Parse the master document and build an abstract structure.

- Validate marker pairing, uniqueness, nesting, and required sections.

- Generate module files, stage files, shared services, and aggregated views in parallel.

- Run content consistency, link, performance value, and technology stack checks on generated results.

- Compare Git diff; block merge if generated results are not committed or are out of sync with the source.

CLI commands from the original draft include `astrology-doc-processor generate`, `validate`, `--dry-run`, and `--strict`. The template engine uses Handlebars, and the processor is implemented in TypeScript/Node.js.

## 23. CI/CD Document Workflow

- Triggers: master document or document-processor changes, Pull Request, scheduled check.

- Validate: structure, markers, cross-references, content consistency.

- Generate: 48 module files, 9 stage files, and aggregated files.

- Diff: fails if artifacts are out of sync with the source; requires local regeneration.

- Deploy: after main branch validation passes, build documentation site and search index; can deploy to GitHub Pages.

- Versioning: semantic versioning; main/develop/feature/release branches; at least two-person approval.

# Part IX Deployment, Development, and Verification

## 24. Deployment Architecture

| Item | Original Draft Configuration |
| --- | --- |
| Base Images | node:18-alpine, python:3.11-slim, nginx:1.24-alpine |
| Kubernetes | Rolling Update; 2–10 replicas; target CPU 70% |
| Health Endpoints | /health/live, /health/ready, /health/startup |
| Load Balancing | nginx-ingress, least_connections; original draft also lists ClientIP session affinity |
| Rollback | Stage 1 blue-green deployment < 5 minutes; Stage 4 progressive migration < 10 minutes |
| Cache | Redis 2GB, allkeys-lru, RDB; Stage 1 TTL 1h, Stage 4 24h, Stage 6 6h |

## 25. Development Quality Baseline

- TypeScript strict, noImplicitAny, noImplicitReturns, noUnusedLocals.

- ESLint (original draft lists Airbnb TypeScript), Prettier, Husky.

- Unit tests with Jest, coverage > 90%; Stage 4 precision-related targets > 95%.

- Integration tests with Supertest + Jest; E2E with Playwright; external services should be mockable.

- CI Gate: SonarQube A, test coverage met, no high-severity vulnerabilities, performance tests passed.

- Deployment pipeline: quality, unit, integration, security, build, Staging, E2E, Production.

## 26. Stage Verification Evidence

| Type | Required Evidence |
| --- | --- |
| Correctness | Fixed input, expected output, algorithm/model version, comparison with trusted baseline |
| Performance | Hardware, data scale, warm-up, sample size, p50/p95/p99, error rate |
| Reliability | Retry, circuit breaker, degradation, fault injection, recovery time |
| Data | Schema, migration, backup, RTO/RPO, cross-database consistency tests |
| AI Quality | Dataset, scoring rules, human review, consistency, confidence calibration |
| Documentation | Marker validation, generation reproducible, diff zero, links and examples usable |



# Part X Implementation Plan, Risks, and Acceptance

## 27. Ten-Week Implementation Plan

| Timeline | Focus | Deliverables | Personnel |
| --- | --- | --- | --- |
| Weeks 1–2 | Foundation infrastructure, processor skeleton, CI/CD | document-processor, core types, basic workflow | 1 lead + 1 reviewer |
| Weeks 3–4 | Master document restructuring, markers, content standardization | Fully marked master document, validation rules, quality standards | 2 engineers |
| Weeks 5–7 | Generator, Handlebars templates, testing | Module/stage READMEs, generation tests | 2–3 engineers |
| Weeks 8–10 | Integration, coverage, CI/CD, user documentation | Complete test suite, deployment and usage guide | 2 engineers + feedback loop |

The original draft totals 2–3 engineers, 10 weeks total. This plan primarily describes document automation and architecture cleanup; it is not equivalent to building all nine stages of the full business system from scratch to complete deployment.

## 28. Risk Matrix

| Risk | Probability/Impact | Mitigation |
| --- | --- | --- |
| Master document single point of failure | Low/High | Multiple backups, Git versioning, rollback, automatic recovery, multi-person review |
| Team learning curve | Medium/Medium | Start with small modules, training, mentoring, buffer time |
| Large document performance bottleneck | Low/Medium | Splitting, parallelism, caching, performance monitoring, and horizontal scaling |
| Document exposing sensitive data | Medium/Medium | Permissions, sensitive information scanning, encryption, and security audit |
| Technology dependency upgrades | Low/Low | Version pinning, regular updates, upgrade testing, and alternatives |
| Performance budget not closed | High/High (newly added in this restructure) | Redefine total SLA, optional stages, and parallel dependencies; establish real baselines |

## 29. Acceptance Thresholds

- Nine-stage interfaces, status, and error contracts are verifiable; document existence alone does not represent feature completion.

- Real-time mode < 350ms with clear test environment, load, and percentile definitions.

- Full mode SLA mathematically closed and measured; Stage 4/6 parallel dependency formally finalized.

- Document generation 100% reproducible, derived files and master document diff zero.

- Test coverage > 90%, security scan with no high-severity vulnerabilities, monitoring and alerting covering 100% of stages.

- All "accuracy, satisfaction, maintenance cost reduction, speed improvement" have measurement methods and baselines.

## 30. Business Effect Targets

The original draft proposes: document maintenance cost reduced by 80%, development speed improved by 50%, support for 10x user volume, member onboarding time reduced by 60%, user satisfaction > 90%. The restructured version retains these as KPI candidates, but current baselines, measurement cycles, and attribution methods must first be established before they can be evaluated at acceptance.

# Appendix A Key Pending Decisions List

| ID | Decision | Reason | Completion Condition |
| --- | --- | --- | --- |
| D-01 | Ant Design or Material-UI | Original draft frontend standard conflict | Select one and update globally and in Stage 1 |
| D-02 | Whether Stage 6 is split into prefetch/final retrieval | Dependency contradiction with Stage 4 parallelism | Draw DAG and pass integration tests |
| D-03 | Full mode SLA | 5,500ms budget not closed | Define p95/optional flow and measure |
| D-04 | Graph query SLA | Original draft has 150ms and 500ms | Distinguish typical target from alert upper limit |
| D-05 | Scope of report 200ms | Full PDF may exceed | Split API assembly and artifact rendering |
| D-06 | AI/Prediction quality definition | Percentages without dataset and scoring rules | Establish benchmark, annotation, and versioning |
| D-07 | Zero technical debt status | Target and current state conflated | Validator, debt checklist, and exemption report all pass |
| D-08 | Module 11 | Numbering gap | Confirm reserved slot or formal purpose |



# Appendix B Minimum Implementation Order

1. First clean up master document markers, duplicates, and canonical sections, establishing a machine-parseable single source.

2. Establish ProcessingEnvelope, error model, version fields, and Stage state machine.

3. Complete Stages 1–3 and the API/frontend real-time loop, first proving < 350ms.

4. Complete the astronomical and aspect correctness baseline for Stages 4–5; do not pursue AI first.

5. Establish knowledge base schema, tag versioning, and Stage 6 citable retrieval.

6. Integrate Stage 7, starting with rules + retrieval + single model, establish quality evaluation.

7. Stage 8 is implemented as an independent asynchronous task to avoid locking the full natal report SLA.

8. Stage 9 is split into real-time JSON/HTML and background PDF artifacts.

9. Finally, introduce full K8s, seven databases, and multiple models; do not deploy all complexity at once before necessity is proven.

# Appendix C Conclusion

The most valuable part of the original draft is not the large number of class and interface names, but the complete system perspective it has already formed: "nine-stage main flow, module responsibilities, shared services, performance thresholds, technical debt governance, document generation." The main line after restructuring is: first make truth traceable, then make calculation verifiable, then make intelligence measurable, and only then talk about full automation and zero technical debt.

This document retains the important details of the original design while clearly marking what has not been proven, what conflicts, or what is mathematically unclosed. Any subsequent implementation should update the status with executable interfaces, test evidence, performance baselines, and generation consistency, rather than declaring completion through narrative.
