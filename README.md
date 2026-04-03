# Chicago Bike Share: Optimizing for Dual-Use Patterns

## Executive Summary
Chicago's bike share serves 5.5M annual trips across two fundamentally different user behaviors, but operational decisions (fleet distribution, pricing, station placement) may not have been differentiated, risking revenue loss and inefficient resource allocation. I analyzed 12 months of ridership data (Sept 2024–Aug 2025) to quantify behavioral differences between member commuters and casual recreational riders.

**Key Impact:**
- **14x seasonal swing** (casuals) vs. 4x (members) → enables targeted fleet rebalancing
- **8.2x higher** 60+ minute ride likelihood (casuals) → creates premium pricing opportunity  
- **83% member winter market share** → identifies committed year-round users
- **+34% Friday casual surge** → reveals weekend conversion opportunity

**Recommendations:** Season-specific fleet allocation, dual pricing strategies, and March-April conversion campaigns

## Business Problem

Chicago's bike share may have operated with one-size-fits-all strategies despite serving distinct user segments.

**This would create inefficiencies:**
- **Winter over-allocation**: Excess bikes at tourist zones despite 93% casual demand drop
- **Missed revenue**: No premium pricing for 30+ minute casual leisure rides vs. 14-minute member commutes
- **Poor conversion timing**: No targeted campaigns during optimal March-April window
- **Undifferentiated stations**: Same density strategy for commuter corridors and tourist zones

**Core question:** How do members and casuals actually use the system differently, and what operational/pricing/marketing strategies should be differentiated as a result?

---

## Methodology

**Data Processing (MySQL):**
- Combined 12 CSV files (5.5M trips) into unified database
- Created calculated fields (ride_length, day_of_week)
- Cleaned anomalies (43 negative durations from system maintenance)

**Analysis (SQL + Excel):**
- Aggregated by: bike type, hour, day, week, month, duration buckets
- Calculated: volume ratios, weighted averages, seasonal variations, market share
- Identified patterns: commute peaks, weekend shifts, seasonal extremes

**Visualization (Excel + PowerPoint):**
- Designed insight-driven charts following best practices
- Built progressive narrative: micro (hourly) → macro (seasonal)
- Synthesized findings into actionable recommendations

---

## Skills

**Technical:** MySQL (aggregation, window functions, temporal analysis), Excel (SUMPRODUCT, pivot analysis, weighted averages, visualization), data cleaning & validation

**Analytical:** Exploratory data analysis, behavioral segmentation, comparative analysis, statistical calculations, pattern recognition

**Business:** Data storytelling, strategic recommendations (operational/pricing/marketing), stakeholder communication, insight extraction

---

## Results & Recommendations

### Key Findings

**Members = Year-Round Commuters:**
- 3.5x advantage at 8 AM, 2.2:1 weekday dominance
- 11-13 min rides (100% of hours), only 3.3 min annual variance
- 76% of trips under 15 minutes
- 75% winter reduction but maintain presence (10.8% annual share)

**Casuals = Seasonal Recreationalists:**
- 53% higher weekend volume, 34% Friday surge
- 16-28 min variable rides, 23 min average
- 8.2x more 60+ min rides, 2.7x longer on classic bikes
- 93% winter dropout (4.5% annual share)

*[Insert 1-2 key visualizations]*

### Strategic Recommendations

**Operational:**
- Reduce winter fleet 70% (concentrate at commuter corridors)
- Add stations near transit hubs (member "last mile") and hotels (casual access)

**Pricing:**
- Introduce 60-90 min "scenic pass" for casuals (premium leisure pricing)
- Maintain member frequency model, add winter loyalty discounts
- Friday afternoon surge pricing for casual weekend demand

**Marketing:**
- March-April casual-to-member conversion campaigns ("lock in summer savings")
- Position classic bikes as "scenic cruisers" with comfort features (baskets)

---

## Next Steps

**Potential extensions beyond current scope:**

1. **Geographic mapping** - Validate lakefront tourist vs. inland commuter corridor hypothesis
2. **Cohort retention** - Track casual conversion patterns, calculate lifetime value differentials
3. **Weather modeling** - Correlate usage with temperature/precipitation for demand forecasting
4. **Route analysis** - Examine station-pair patterns to optimize directional bike flow
5. **A/B testing** - Experiment with pricing elasticity and conversion messaging optimization

---

**Data Source:** [Divvy System Data](https://divvy-tripdata.s3.amazonaws.com/index.html)  
**Tools:** MySQL | Excel | PowerPoint  
**Project Files:** [Presentation](link) | [SQL Scripts](link) | [Analysis Workbooks](link)
