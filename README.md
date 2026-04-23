# CalcuStats — Statistical Analysis & Sample Size Calculator

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Live Demo](https://img.shields.io/badge/demo-live-brightgreen)](https://shinyhealthtools.github.io/calcustats/)
[![Vercel Deployment](https://img.shields.io/badge/deployed%20on-vercel-black)](https://calcustats.vercel.app/)

**Calculate. Analyze. Publish.** — A complete, free, and modern web‑based statistical suite for researchers, data analysts, and students.

**Live Application:**
- [CalcuStats on GitHub Pages](https://shinyhealthtools.github.io/calcustats/)
- [CalcuStats on Vercel](https://calcustats.vercel.app/)

![CalcuStats Hero Screenshot](https://raw.githubusercontent.com/mudassiribrahim12/Stats/main/CalcuStatslogo.png)

## ✨ Overview

CalcuStats is a powerful, ad‑free, and **completely free** statistical software that runs entirely in your browser. No installation, no data uploads to external servers, and no tracking. It provides everything you need for rigorous quantitative analysis: from initial sample size planning to advanced inferential statistics and publication‑ready visualizations.

Built by a health researcher for researchers, CalcuStats bridges the gap between complex statistical software (like SPSS, Stata, or SAS) and simple online calculators.

## 🚀 Key Features

### 📊 Sample Size Calculators
- **Proportional Allocation** — Distribute samples across strata with non‑response adjustment.
- **Taro Yamane Formula** — Classic finite‑population formula for surveys.
- **Cochran’s Formula** — Precision calculation for proportions with finite population correction (FPC).
- **Other Formulas** — Single proportion, mean estimation, case‑control, cohort, correlation, and prevalence study designs.

### 📈 Descriptive Statistics
- Automatic detection of **numeric** and **categorical** variables.
- Computes: Mean, median, standard deviation, variance, min, max, range,
  skewness, kurtosis, **95% CI for the mean**, quartiles, percentiles, and more.
- Frequency tables with cumulative counts/percentages and **95% CIs for proportions**.
- **High‑quality, customizable graphs** (bar, pie, histogram, boxplot) with full display options.
- Export results to **Excel** or **Word** with full analysis details.

### ⚙️ Advanced Inferential Tests
- **t‑Tests** — one‑sample, independent (equal/unequal variance), and paired.
- **ANOVA** — one‑way and two‑way, with post‑hoc tests (Tukey HSD, Bonferroni).
- **Regression Models** — linear (OLS), binary logistic, and Poisson.
- **Correlation** — Pearson, Spearman, and Kendall Tau with confidence intervals and scatter plots.
- **Categorical Data** — Chi‑square (with expected frequencies, effect sizes, and linear‑by‑linear association) and Fisher’s exact test (2×2).
- **Non‑Parametric Tests** — Mann‑Whitney U, Wilcoxon signed‑rank, Kruskal‑Wallis H.
- **Multivariate Methods** — ANCOVA, MANOVA, and multinomial logistic regression.
- **All p‑values, confidence intervals, and effect sizes** (Cohen’s d, Cramér’s V, etc.) are displayed in a clear, publication‑ready format.

### 🎨 Publication‑Ready Flowcharts
- Dynamically generate **flowcharts** from any proportional allocation result.
- Live customisation of colors, fonts, shapes, arrows, node sizes, and content.
- Show/hide legends, formulas, non‑response notes, and percentage bars.
- Download as **SVG** (vector) or **high‑resolution PNG**.
- **Full‑screen mode** and a massive set of visual controls (alternating colors, node dimensions, spacing, etc.).

### 📤 Export & Reporting
- Export **every calculation** to **Excel** (multiple sheets) or **Word** (formatted document).
- Download descriptive analysis reports (complete with tables and graphs).
- All exports include the calculation steps, final sample size, and site metadata.

### 🌙 User Experience
- **Dark / Light theme** toggle (remembers your preference).
- Fully **responsive** — works perfectly on desktop, tablet, and mobile.
- Zero ads, zero trackers, zero data sent to any server.
- Detailed **step‑by‑step** calculation logs for all formulas.
- Copy‑paste data directly from spreadsheets (Excel, Google Sheets, CSV).

## 🛠️ Technologies Used

- **HTML5 / CSS3** — Custom responsive layouts, CSS Grid, and Flexbox.
- **JavaScript (ES6+)** — All calculations are performed client‑side.
- **Charting** — Native Canvas API for high‑quality graphs and flowcharts.
- **Export** — SheetJS (XLSX) for Excel exports and Blob API for Word `.doc` files.
- **Deployment** — GitHub Pages & Vercel.

## 📥 Getting Started

### Using the Live Application
Simply navigate to [CalcuStats](https://shinyhealthtools.github.io/calcustats/) and start analysing.

### Running Locally
If you want to run the app on your own machine or contribute:

1. **Clone the repository**
   ```bash
   git clone https://github.com/shinyhealthtools/calcustats.git
   cd calcustats
