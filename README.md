# ⚡ RealICM — Oracle ICM Analytics Engine

> The real-time analytics engine for Oracle Incentive Compensation Management.

## What It Is

RealICM connects directly to your Oracle Fusion instance and gives you three ways to work with ICM data:

| Pillar | Who It's For | What It Does |
|--------|-------------|--------------|
| 🧠 **DIY Explorer** | Power users / developers | Full SQL editor with ICM schema sidebar, AI SQL generation, live Oracle results |
| 📚 **SQL Library** | Semi-technical users | 11+ pre-built production-tested ICM queries with parameter prompts — no SQL needed |
| 📊 **Dashboards** | Admins / managers | Live Overview, Seller View, Comp Plans, Earnings, Approvals, Anomalies, Calendar |

## Quick Start

```bash
git clone https://github.com/cskasarabada/RealICM
cd RealICM
npm install
npm start
```

Then click **Not Connected** → enter your Oracle Fusion URL, username, password, and (optionally) Anthropic API key for AI features.

## Features

- **One connection** — enter Oracle credentials once, all three pillars share them
- **Live Oracle data** — XHR calls to Oracle REST APIs (no CORS issues in Electron)
- **AI SQL generation** — describe what you want in plain English, get Oracle ICM SQL
- **11 pre-built queries** — comp plan detail, BIP participants, subledger balances, calendar periods, FX rates, and more
- **Anomaly detection** — duplicate credits, outlier earners, missing plan assignments
- **What-If calculator** — sellers can model commission impact before closing deals
- **Export** — Excel, CSV (coming in v1.1)

## Pre-Built SQL Library

| Query | Tables | Params |
|-------|--------|--------|
| Comp Plan Full Detail | CN_COMP_PLANS_ALL_VL, CN_PLAN_COMPONENTS_ALL_VL | Plan Name |
| BIP Participant OTV Report | CN_SRP_PARTICIPANT_DETAILS_ALL | BU Org ID |
| Commission Earnings by Participant | CN_TP_CREDITS_ALL | Participant ID |
| Subledger Balances | CN_SRP_SUBLEDGER_ALL | Participant ID |
| Comp Letter Approvals | FA_FUSION_SOAINFRA.WFTASK | — |
| ICM Business Units | FUN_ALL_BUSINESS_UNITS_V | — |
| Calendar Periods | CN_PERIODS_B | Calendar Name |
| FX Conversion Rates | CN_CONVERSION_RATES | Start Date, Currency |
| Pro-Rated OTV Calculation | CN_SRP_PARTICIPANT_DETAILS_ALL | Participant ID |
| Participant → HCM User Link | CN_SRP_PARTICIPANTS_ALL | — |
| Employee Details & BU | PER_ALL_PEOPLE_F | — |

## Architecture

```
RealICM/
├── main.js              ← Electron shell + Oracle conn IPC
├── preload.js           ← exposes Oracle API to renderer
├── renderer/
│   ├── index.html       ← 3-pillar app (DIY + Library + Dashboards)
│   └── dashboards/
│       └── seller.html  ← Full Oracle ICM Seller mockup
├── sql/                 ← Raw .sql files (library source)
└── .github/workflows/   ← CI/CD for Mac DMG + Windows EXE
```

## Requirements

- Oracle Fusion instance with REST API access
- Node.js 22+
- macOS 12+ or Windows 10+

## Built By

Chandra Kasarabada — Oracle ICM/CPQ Principal Architect @ Argano
