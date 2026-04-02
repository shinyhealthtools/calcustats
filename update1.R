<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>CalcuStats Lite (Free Multipurpose Sample Size Calculator) - Proportional Allocation, Taro Yamane, Cochran's Formula & More</title>
<meta name="description" content="Professional sample size calculator suite: Taro Yamane, Cochran's Formula, Proportional Allocation, and more.">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=DM+Mono:wght@400;500&family=Outfit:wght@300;400;500;600&display=swap" rel="stylesheet">
<style>
:root {
  --bg: #0a0a0f;
  --bg2: #111118;
  --bg3: #1a1a24;
  --bg4: #22222e;
  --border: rgba(255,255,255,0.07);
  --border2: rgba(255,255,255,0.12);
  --text: #f0f0f8;
  --text2: #9898b0;
  --text3: #5a5a72;
  --accent: #6c63ff;
  --accent2: #8b85ff;
  --accent-glow: rgba(108,99,255,0.25);
  --teal: #00d4aa;
  --teal-dim: rgba(0,212,170,0.15);
  --amber: #f5a623;
  --amber-dim: rgba(245,166,35,0.12);
  --coral: #ff6b6b;
  --coral-dim: rgba(255,107,107,0.12);
  --green: #4ade80;
  --green-dim: rgba(74,222,128,0.12);
  --mono: 'DM Mono', monospace;
  --serif: 'DM Serif Display', serif;
  --sans: 'Outfit', sans-serif;
  --radius: 12px;
  --radius-lg: 18px;
  --radius-xl: 24px;
}

* { margin:0; padding:0; box-sizing:border-box; }

html { scroll-behavior: smooth; }

body {
  font-family: var(--sans);
  background: var(--bg);
  color: var(--text);
  min-height: 100vh;
  font-size: 15px;
  line-height: 1.6;
  overflow-x: hidden;
}

/* Background grid */
body::before {
  content: '';
  position: fixed;
  inset: 0;
  background-image:
    linear-gradient(rgba(108,99,255,0.03) 1px, transparent 1px),
    linear-gradient(90deg, rgba(108,99,255,0.03) 1px, transparent 1px);
  background-size: 48px 48px;
  pointer-events: none;
  z-index: 0;
}

/* Loader */
#loader {
  position: fixed; inset: 0; z-index: 9999;
  background: var(--bg);
  display: flex; flex-direction: column;
  align-items: center; justify-content: center;
  gap: 24px;
  transition: opacity 0.6s ease, visibility 0.6s ease;
}
#loader.out { opacity: 0; visibility: hidden; }
.loader-rings {
  position: relative; width: 80px; height: 80px;
}
.loader-rings div {
  position: absolute; inset: 0;
  border: 2px solid transparent;
  border-radius: 50%;
  animation: spin 2s linear infinite;
}
.loader-rings div:nth-child(1) { border-top-color: var(--accent); }
.loader-rings div:nth-child(2) { border-right-color: var(--teal); animation-delay: -0.5s; inset: 8px; }
.loader-rings div:nth-child(3) { border-bottom-color: var(--amber); animation-delay: -1s; inset: 16px; }
@keyframes spin { to { transform: rotate(360deg); } }
#loader p { font-family: var(--mono); font-size: 13px; color: var(--text3); letter-spacing: 0.1em; }

/* Header */
.header {
  position: sticky; top: 0; z-index: 100;
  background: rgba(10,10,15,0.85);
  backdrop-filter: blur(20px);
  border-bottom: 1px solid var(--border);
}
.header-inner {
  max-width: 1300px; margin: 0 auto;
  padding: 0 32px;
  display: flex; align-items: center; gap: 32px;
  height: 64px;
}
.logo {
  display: flex; align-items: center; gap: 12px;
  text-decoration: none;
  flex-shrink: 0;
}
.logo-mark {
  width: 36px; height: 36px;
  background: linear-gradient(135deg, var(--accent), var(--teal));
  border-radius: 10px;
  display: flex; align-items: center; justify-content: center;
  font-family: var(--mono); font-size: 14px; font-weight: 500;
  color: white;
  letter-spacing: -0.05em;
}
.logo-text {
  font-family: var(--serif);
  font-size: 20px;
  color: var(--text);
}
.logo-sub {
  font-family: var(--sans);
  font-size: 11px;
  color: var(--text3);
  letter-spacing: 0.12em;
  text-transform: uppercase;
  margin-top: -2px;
}

/* Nav tabs */
.nav {
  display: flex; align-items: center; gap: 4px;
  flex: 1;
  overflow-x: auto;
  scrollbar-width: none;
}
.nav::-webkit-scrollbar { display: none; }
.nav-btn {
  flex-shrink: 0;
  padding: 7px 16px;
  background: none;
  border: 1px solid transparent;
  border-radius: 8px;
  font-family: var(--sans); font-size: 13px; font-weight: 500;
  color: var(--text3);
  cursor: pointer;
  transition: all 0.2s;
  display: flex; align-items: center; gap: 8px;
  white-space: nowrap;
}
.nav-btn:hover { color: var(--text2); background: var(--bg3); }
.nav-btn.active {
  color: var(--accent2);
  border-color: rgba(108,99,255,0.3);
  background: rgba(108,99,255,0.08);
}
.nav-icon { font-size: 14px; opacity: 0.8; }

/* Theme btn */
.theme-btn {
  margin-left: auto;
  flex-shrink: 0;
  width: 36px; height: 36px;
  background: var(--bg3);
  border: 1px solid var(--border);
  border-radius: 8px;
  color: var(--text2);
  cursor: pointer;
  font-size: 16px;
  display: flex; align-items: center; justify-content: center;
  transition: all 0.2s;
}
.theme-btn:hover { border-color: var(--border2); color: var(--text); }

/* Mobile menu */
.hamburger {
  display: none;
  width: 36px; height: 36px;
  background: var(--bg3);
  border: 1px solid var(--border);
  border-radius: 8px;
  color: var(--text2);
  cursor: pointer;
  font-size: 18px;
  align-items: center; justify-content: center;
  transition: all 0.2s;
}
.mobile-drawer {
  position: fixed;
  top: 64px; left: 0; right: 0;
  background: var(--bg2);
  border-bottom: 1px solid var(--border);
  z-index: 99;
  padding: 12px;
  display: none;
}
.mobile-drawer.open { display: block; animation: slideDown 0.2s ease; }
@keyframes slideDown { from { opacity:0; transform: translateY(-8px); } to { opacity:1; transform: translateY(0); } }
.mobile-nav { display: flex; flex-direction: column; gap: 4px; }
.mobile-nav-btn {
  width: 100%;
  padding: 12px 16px;
  background: none;
  border: 1px solid transparent;
  border-radius: 8px;
  font-family: var(--sans); font-size: 14px; font-weight: 500;
  color: var(--text2);
  cursor: pointer;
  text-align: left;
  display: flex; align-items: center; gap: 12px;
  transition: all 0.15s;
}
.mobile-nav-btn:hover { background: var(--bg3); color: var(--text); }
.mobile-nav-btn.active { color: var(--accent2); background: rgba(108,99,255,0.08); border-color: rgba(108,99,255,0.3); }

/* Main */
main {
  max-width: 1300px;
  margin: 0 auto;
  padding: 0 32px 80px;
  position: relative; z-index: 1;
}

/* Pages */
.page { display: none; }
.page.active { display: block; animation: fadeUp 0.3s ease; }
@keyframes fadeUp { from { opacity:0; transform: translateY(12px); } to { opacity:1; transform: translateY(0); } }

/* Hero */
.hero {
  padding: 80px 0 60px;
  text-align: center;
}
.hero-badge {
  display: inline-flex; align-items: center; gap: 8px;
  padding: 6px 16px;
  background: rgba(108,99,255,0.1);
  border: 1px solid rgba(108,99,255,0.25);
  border-radius: 100px;
  font-size: 12px; font-weight: 500;
  color: var(--accent2);
  letter-spacing: 0.06em;
  text-transform: uppercase;
  margin-bottom: 28px;
}
.hero-badge span { width: 6px; height: 6px; background: var(--accent); border-radius: 50%; animation: pulse 2s infinite; }
@keyframes pulse { 0%,100%{opacity:1;transform:scale(1)} 50%{opacity:0.5;transform:scale(0.8)} }
.hero h1 {
  font-family: var(--serif);
  font-size: clamp(42px, 6vw, 76px);
  line-height: 1.05;
  color: var(--text);
  margin-bottom: 20px;
}
.hero h1 em {
  font-style: italic;
  background: linear-gradient(135deg, var(--accent2), var(--teal));
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}
.hero-desc {
  font-size: 17px;
  color: var(--text2);
  max-width: 600px;
  margin: 0 auto 48px;
  font-weight: 300;
  line-height: 1.7;
}

/* Card grid */
.card-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 16px;
  margin-bottom: 48px;
}
.calc-card {
  background: var(--bg2);
  border: 1px solid var(--border);
  border-radius: var(--radius-lg);
  padding: 28px;
  cursor: pointer;
  transition: all 0.25s;
  position: relative;
  overflow: hidden;
  text-align: left;
}
.calc-card::before {
  content: '';
  position: absolute;
  top: 0; left: 0; right: 0;
  height: 2px;
  opacity: 0;
  transition: opacity 0.25s;
}
.calc-card.c-purple::before { background: linear-gradient(90deg, var(--accent), transparent); }
.calc-card.c-teal::before { background: linear-gradient(90deg, var(--teal), transparent); }
.calc-card.c-amber::before { background: linear-gradient(90deg, var(--amber), transparent); }
.calc-card.c-coral::before { background: linear-gradient(90deg, var(--coral), transparent); }
.calc-card:hover { border-color: var(--border2); transform: translateY(-3px); }
.calc-card:hover::before { opacity: 1; }
.card-icon {
  width: 48px; height: 48px; border-radius: 12px;
  display: flex; align-items: center; justify-content: center;
  font-size: 22px; margin-bottom: 18px;
}
.c-purple .card-icon { background: rgba(108,99,255,0.12); }
.c-teal .card-icon { background: var(--teal-dim); }
.c-amber .card-icon { background: var(--amber-dim); }
.c-coral .card-icon { background: var(--coral-dim); }
.calc-card h3 { font-size: 16px; font-weight: 600; margin-bottom: 8px; }
.calc-card p { font-size: 13px; color: var(--text2); line-height: 1.6; margin-bottom: 20px; }
.card-link {
  font-size: 12px; font-weight: 600;
  letter-spacing: 0.06em; text-transform: uppercase;
  color: var(--text3);
  display: flex; align-items: center; gap: 6px;
  transition: color 0.2s;
}
.c-purple .card-link { color: var(--accent); }
.c-teal .card-link { color: var(--teal); }
.c-amber .card-link { color: var(--amber); }
.c-coral .card-link { color: var(--coral); }
.card-link::after { content: '→'; transition: transform 0.2s; }
.calc-card:hover .card-link::after { transform: translateX(4px); }

/* Stats row */
.stats-row {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
  gap: 12px;
  padding: 32px 0;
  border-top: 1px solid var(--border);
  border-bottom: 1px solid var(--border);
  margin-bottom: 48px;
}
.stat-item { text-align: center; }
.stat-num {
  font-family: var(--serif);
  font-size: 36px;
  color: var(--text);
  line-height: 1;
  margin-bottom: 6px;
}
.stat-label { font-size: 12px; color: var(--text3); letter-spacing: 0.06em; text-transform: uppercase; }

/* Calculator layout */
.calc-layout {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 24px;
  padding: 40px 0 20px;
}
.calc-header {
  padding: 40px 0 32px;
  border-bottom: 1px solid var(--border);
  margin-bottom: 0;
  display: flex; align-items: flex-start; gap: 20px;
}
.calc-header-icon {
  width: 56px; height: 56px; border-radius: 16px;
  display: flex; align-items: center; justify-content: center;
  font-size: 26px; flex-shrink: 0;
  margin-top: 4px;
}
.calc-header-text h2 {
  font-family: var(--serif);
  font-size: 32px; line-height: 1.1;
  margin-bottom: 8px;
}
.calc-header-text p { color: var(--text2); font-size: 14px; line-height: 1.6; }

/* Panel */
.panel {
  background: var(--bg2);
  border: 1px solid var(--border);
  border-radius: var(--radius-xl);
  padding: 32px;
}
.panel-title {
  font-size: 11px; font-weight: 600;
  letter-spacing: 0.12em; text-transform: uppercase;
  color: var(--text3);
  margin-bottom: 24px;
  padding-bottom: 16px;
  border-bottom: 1px solid var(--border);
  display: flex; align-items: center; gap: 8px;
}
.panel-title::before {
  content: '';
  width: 4px; height: 4px;
  border-radius: 50%;
  background: var(--accent);
  display: inline-block;
}

/* Formula box */
.formula-box {
  background: var(--bg);
  border: 1px solid var(--border);
  border-left: 3px solid var(--accent);
  border-radius: var(--radius);
  padding: 20px;
  margin-bottom: 28px;
}
.formula-label {
  font-size: 10px; font-weight: 600;
  letter-spacing: 0.12em; text-transform: uppercase;
  color: var(--text3);
  margin-bottom: 10px;
}
.formula-expr {
  font-family: var(--mono);
  font-size: 15px; font-weight: 500;
  color: var(--accent2);
  margin-bottom: 10px;
}
.formula-desc { font-size: 12px; color: var(--text3); line-height: 1.6; }

/* Form elements */
.field { margin-bottom: 20px; }
.field label {
  display: block;
  font-size: 12px; font-weight: 600;
  letter-spacing: 0.04em; text-transform: uppercase;
  color: var(--text3);
  margin-bottom: 8px;
}
.field input, .field select {
  width: 100%;
  padding: 11px 14px;
  background: var(--bg);
  border: 1px solid var(--border2);
  border-radius: 8px;
  color: var(--text);
  font-family: var(--sans); font-size: 14px; font-weight: 400;
  outline: none;
  transition: border-color 0.2s, box-shadow 0.2s;
  -webkit-appearance: none;
}
.field input:focus, .field select:focus {
  border-color: var(--accent);
  box-shadow: 0 0 0 3px var(--accent-glow);
}
.field input::placeholder { color: var(--text3); }
.field-hint {
  font-size: 11px; color: var(--text3);
  margin-top: 6px; line-height: 1.5;
}
.field-row { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }
.field select {
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' viewBox='0 0 12 8'%3E%3Cpath d='M1 1l5 5 5-5' stroke='%235a5a72' stroke-width='1.5' fill='none' stroke-linecap='round'/%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: right 12px center;
  padding-right: 36px;
  cursor: pointer;
}
.field select option { background: #1a1a24; }

/* Toggle */
.toggle-row {
  display: flex; align-items: center; gap: 12px;
  padding: 14px 16px;
  background: var(--bg);
  border: 1px solid var(--border);
  border-radius: 8px;
  cursor: pointer;
  margin-bottom: 16px;
  transition: border-color 0.2s;
}
.toggle-row:hover { border-color: var(--border2); }
.toggle-switch {
  width: 36px; height: 20px;
  background: var(--bg4);
  border-radius: 100px;
  position: relative; flex-shrink: 0;
  transition: background 0.2s;
}
.toggle-switch.on { background: var(--accent); }
.toggle-knob {
  position: absolute;
  top: 3px; left: 3px;
  width: 14px; height: 14px;
  background: white;
  border-radius: 50%;
  transition: left 0.2s;
}
.toggle-switch.on .toggle-knob { left: 19px; }
.toggle-label { font-size: 13px; font-weight: 500; color: var(--text2); }

/* Strata */
.strata-wrap {
  display: none;
  margin-top: 8px;
  border: 1px solid var(--border);
  border-radius: var(--radius);
  overflow: hidden;
}
.strata-wrap.visible { display: block; }
.strata-header-row {
  padding: 12px 16px;
  background: var(--bg);
  border-bottom: 1px solid var(--border);
  display: flex; align-items: center; justify-content: space-between;
}
.strata-header-row span { font-size: 12px; font-weight: 600; color: var(--text3); text-transform: uppercase; letter-spacing: 0.06em; }
.add-stratum-btn {
  padding: 6px 12px;
  background: var(--bg3);
  border: 1px solid var(--border);
  border-radius: 6px;
  font-family: var(--sans); font-size: 12px; font-weight: 500;
  color: var(--teal);
  cursor: pointer;
  display: flex; align-items: center; gap: 6px;
  transition: all 0.15s;
}
.add-stratum-btn:hover { background: var(--teal-dim); border-color: rgba(0,212,170,0.3); }
.strata-list { padding: 12px; display: flex; flex-direction: column; gap: 8px; }
.stratum-row {
  display: grid;
  grid-template-columns: 1fr 1fr auto;
  gap: 8px; align-items: center;
  padding: 10px 12px;
  background: var(--bg2);
  border: 1px solid var(--border);
  border-radius: 8px;
  transition: border-color 0.2s;
}
.stratum-row:hover { border-color: var(--border2); }
.stratum-row input {
  width: 100%; padding: 7px 10px;
  background: var(--bg);
  border: 1px solid var(--border);
  border-radius: 6px;
  color: var(--text); font-family: var(--sans); font-size: 13px;
  outline: none;
  transition: border-color 0.15s;
}
.stratum-row input:focus { border-color: var(--accent); }
.del-stratum {
  width: 28px; height: 28px;
  background: none;
  border: 1px solid var(--border);
  border-radius: 6px;
  color: var(--text3);
  cursor: pointer;
  display: flex; align-items: center; justify-content: center;
  font-size: 13px;
  transition: all 0.15s;
  flex-shrink: 0;
}
.del-stratum:hover { background: var(--coral-dim); border-color: rgba(255,107,107,0.3); color: var(--coral); }
.del-stratum:disabled { opacity: 0.3; cursor: not-allowed; }

/* Buttons */
.btn-row { display: flex; gap: 12px; margin-top: 28px; padding-top: 24px; border-top: 1px solid var(--border); }
.btn-primary {
  flex: 1;
  padding: 13px 20px;
  background: var(--accent);
  border: none;
  border-radius: 10px;
  color: white;
  font-family: var(--sans); font-size: 14px; font-weight: 600;
  cursor: pointer;
  display: flex; align-items: center; justify-content: center; gap: 8px;
  transition: all 0.2s;
  letter-spacing: 0.01em;
}
.btn-primary:hover { background: var(--accent2); transform: translateY(-1px); box-shadow: 0 8px 24px var(--accent-glow); }
.btn-primary:active { transform: translateY(0); }
.btn-secondary {
  padding: 13px 18px;
  background: var(--bg3);
  border: 1px solid var(--border);
  border-radius: 10px;
  color: var(--text2);
  font-family: var(--sans); font-size: 14px; font-weight: 500;
  cursor: pointer;
  display: flex; align-items: center; gap: 8px;
  transition: all 0.2s;
}
.btn-secondary:hover { border-color: var(--border2); color: var(--text); }

/* Results panel */
.results-empty {
  display: flex; flex-direction: column;
  align-items: center; justify-content: center;
  min-height: 340px;
  text-align: center;
  padding: 40px 20px;
}
.results-empty-icon {
  width: 64px; height: 64px;
  border: 1px dashed var(--border2);
  border-radius: 16px;
  display: flex; align-items: center; justify-content: center;
  font-size: 28px;
  margin-bottom: 20px;
  color: var(--text3);
}
.results-empty h3 { font-size: 16px; font-weight: 600; margin-bottom: 8px; }
.results-empty p { font-size: 13px; color: var(--text3); line-height: 1.6; max-width: 240px; }

.results-content { animation: fadeUp 0.3s ease; }

.result-metric {
  padding: 20px 0;
  border-bottom: 1px solid var(--border);
}
.result-metric:last-of-type { border-bottom: none; }
.result-metric-label {
  font-size: 10px; font-weight: 600;
  letter-spacing: 0.12em; text-transform: uppercase;
  color: var(--text3); margin-bottom: 6px;
}
.result-metric-value {
  font-family: var(--mono);
  font-size: 36px; font-weight: 500;
  color: var(--text);
  line-height: 1;
}
.result-metric-value.highlight {
  background: linear-gradient(135deg, var(--accent2), var(--teal));
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.steps-box {
  background: var(--bg);
  border: 1px solid var(--border);
  border-radius: var(--radius);
  padding: 20px;
  margin-top: 20px;
  font-family: var(--mono);
  font-size: 12px;
  line-height: 1.9;
  color: var(--text2);
  white-space: pre-wrap;
  word-break: break-word;
}
.steps-box .step-head { color: var(--accent2); font-weight: 500; }
.steps-box .step-val { color: var(--teal); }

.alloc-list {
  margin-top: 16px;
  display: flex; flex-direction: column; gap: 8px;
}
.alloc-item {
  display: flex; align-items: center;
  padding: 12px 16px;
  background: var(--bg);
  border: 1px solid var(--border);
  border-radius: 8px;
  gap: 12px;
}
.alloc-bar-wrap {
  flex: 1; height: 4px;
  background: var(--bg4);
  border-radius: 100px; overflow: hidden;
}
.alloc-bar {
  height: 100%;
  background: linear-gradient(90deg, var(--accent), var(--teal));
  border-radius: 100px;
  transition: width 0.6s ease;
}
.alloc-name { font-size: 13px; font-weight: 500; min-width: 90px; }
.alloc-val {
  font-family: var(--mono);
  font-size: 13px; font-weight: 500;
  color: var(--accent2);
  min-width: 36px;
  text-align: right;
}
.alloc-pct { font-size: 11px; color: var(--text3); min-width: 44px; text-align: right; }

/* Toast */
#toast {
  position: fixed;
  bottom: 32px; right: 32px;
  background: var(--bg2);
  border: 1px solid var(--border2);
  border-radius: 12px;
  padding: 16px 20px;
  display: flex; align-items: center; gap: 12px;
  font-size: 14px;
  box-shadow: 0 20px 60px rgba(0,0,0,0.5);
  z-index: 1000;
  transform: translateY(80px); opacity: 0;
  transition: all 0.35s cubic-bezier(0.34,1.56,0.64,1);
  pointer-events: none;
  max-width: 360px;
}
#toast.show { transform: translateY(0); opacity: 1; }
.toast-dot {
  width: 8px; height: 8px; border-radius: 50%; flex-shrink: 0;
}
.toast-dot.success { background: var(--green); box-shadow: 0 0 8px rgba(74,222,128,0.5); }
.toast-dot.warn { background: var(--amber); }
.toast-dot.info { background: var(--accent2); }
.toast-text { line-height: 1.4; }
.toast-text strong { display: block; font-weight: 600; margin-bottom: 2px; }
.toast-text span { font-size: 12px; color: var(--text3); }

/* Back to top */
#btt {
  position: fixed; bottom: 32px; left: 32px;
  width: 44px; height: 44px;
  background: var(--bg2);
  border: 1px solid var(--border);
  border-radius: 50%;
  color: var(--text2);
  font-size: 18px;
  cursor: pointer;
  display: flex; align-items: center; justify-content: center;
  z-index: 50;
  opacity: 0; transform: translateY(8px);
  transition: all 0.3s;
}
#btt.show { opacity:1; transform: translateY(0); }
#btt:hover { background: var(--bg3); color: var(--text); }

/* Light theme */
body.light {
  --bg: #f5f5fa;
  --bg2: #ffffff;
  --bg3: #f0f0f7;
  --bg4: #e8e8f0;
  --border: rgba(0,0,0,0.07);
  --border2: rgba(0,0,0,0.14);
  --text: #0e0e1a;
  --text2: #5a5a7a;
  --text3: #9898b8;
  --accent-glow: rgba(108,99,255,0.15);
}
body.light body::before { background-image: linear-gradient(rgba(108,99,255,0.015) 1px, transparent 1px), linear-gradient(90deg, rgba(108,99,255,0.015) 1px, transparent 1px); }
body.light .formula-box, body.light .field input, body.light .field select { background: var(--bg3); }
body.light .stratum-row input, body.light .steps-box, body.light .alloc-item, body.light .results-empty { background: var(--bg3); }
body.light .panel { background: var(--bg2); }
body.light .strata-header-row { background: var(--bg3); }
body.light .strata-wrap { background: var(--bg2); }

/* Responsive */
@media (max-width: 1024px) {
  .calc-layout { grid-template-columns: 1fr; }
}
@media (max-width: 768px) {
  .header-inner { padding: 0 20px; }
  .nav { display: none; }
  .hamburger { display: flex; }
  main { padding: 0 20px 60px; }
  .hero { padding: 48px 0 40px; }
  .field-row { grid-template-columns: 1fr; }
  .panel { padding: 24px 20px; }
  #toast { left: 20px; right: 20px; bottom: 20px; }
  #btt { bottom: 72px; left: 16px; }
  .btn-row { flex-direction: column; }
  .btn-secondary { justify-content: center; }
}
@media (max-width: 480px) {
  .hero h1 { font-size: 38px; }
  .stats-row { grid-template-columns: 1fr 1fr; }
  .stratum-row { grid-template-columns: 1fr auto; }
  .stratum-row input:first-child { display: none; }
}
</style>
</head>
<body>

<div id="loader">
  <div class="loader-rings"><div></div><div></div><div></div></div>
  <p>Initializing CalcuStats Lite…</p>
</div>

<header class="header">
  <div class="header-inner">
    <a class="logo" href="#">
      <div class="logo-mark">Cl</div>
      <div>
        <div class="logo-text">CalcuStats Lite</div>
        <div class="logo-sub">Calculation Hub</div>
      </div>
    </a>
    <nav class="nav">
      <button class="nav-btn active" data-page="home">
        <span class="nav-icon">◈</span> Home
      </button>
      <button class="nav-btn" data-page="proportional">
        <span class="nav-icon">◉</span> Proportional
      </button>
      <button class="nav-btn" data-page="yamane">
        <span class="nav-icon">◐</span> Taro Yamane
      </button>
      <button class="nav-btn" data-page="cochran">
        <span class="nav-icon">◑</span> Cochran
      </button>
      <button class="nav-btn" data-page="other">
        <span class="nav-icon">◇</span> Other Formulas
      </button>
    </nav>
    <button class="theme-btn" id="themeBtn" title="Toggle theme">☀</button>
    <button class="hamburger" id="hamburger">≡</button>
  </div>
</header>

<div class="mobile-drawer" id="mobileDrawer">
  <div class="mobile-nav">
    <button class="mobile-nav-btn active" data-page="home">◈ &nbsp; Home</button>
    <button class="mobile-nav-btn" data-page="proportional">◉ &nbsp; Proportional Allocation</button>
    <button class="mobile-nav-btn" data-page="yamane">◐ &nbsp; Taro Yamane</button>
    <button class="mobile-nav-btn" data-page="cochran">◑ &nbsp; Cochran Formula</button>
    <button class="mobile-nav-btn" data-page="other">◇ &nbsp; Other Formulas</button>
  </div>
</div>

<main>

<!-- HOME PAGE -->
<div class="page active" id="page-home">
  <div class="hero">
    <div class="hero-badge"><span></span> Professional Research Tools</div>
    <h1>Precise <em>sample sizes</em><br>for confident research</h1>
    <p class="hero-desc">A complete suite of validated statistical formulas to determine the optimal sample size for your research study.</p>
  </div>

  <div class="card-grid">
    <div class="calc-card c-purple" onclick="goTo('proportional')">
      <div class="card-icon">⊕</div>
      <h3>Proportional Allocation</h3>
      <p>Distribute your sample proportionally across population strata, with full non-response rate adjustment.</p>
      <div class="card-link">Open Calculator</div>
    </div>
    <div class="calc-card c-teal" onclick="goTo('yamane')">
      <div class="card-icon">∑</div>
      <h3>Taro Yamane</h3>
      <p>Classic finite population formula for survey sampling. Fast, reliable, and universally recognized.</p>
      <div class="card-link">Open Calculator</div>
    </div>
    <div class="calc-card c-amber" onclick="goTo('cochran')">
      <div class="card-icon">%</div>
      <h3>Cochran's Formula</h3>
      <p>Precision calculation for population proportions. Supports finite population correction and flexible input formats.</p>
      <div class="card-link">Open Calculator</div>
    </div>
    <div class="calc-card c-coral" onclick="goTo('other')">
      <div class="card-icon">∫</div>
      <h3>Other Formulas</h3>
      <p>Mean estimation, single proportion, and correlation coefficient studies — all in one place.</p>
      <div class="card-link">Open Calculator</div>
    </div>
  </div>

  <div class="stats-row">
    <div class="stat-item">
      <div class="stat-num">4</div>
      <div class="stat-label">Formula Types</div>
    </div>
    <div class="stat-item">
      <div class="stat-num">∞</div>
      <div class="stat-label">Strata Support</div>
    </div>
    <div class="stat-item">
      <div class="stat-num">0</div>
      <div class="stat-label">Ads / Tracking</div>
    </div>
    <div class="stat-item">
      <div class="stat-num">100%</div>
      <div class="stat-label">Free Forever</div>
    </div>
  </div>
</div>

<!-- PROPORTIONAL ALLOCATION -->
<div class="page" id="page-proportional">
  <div class="calc-header">
    <div class="calc-header-icon" style="background: rgba(108,99,255,0.1);">⊕</div>
    <div class="calc-header-text">
      <h2>Proportional Allocation</h2>
      <p>Allocate sample sizes proportionally across population strata. Ensures each group is represented in proportion to its size in the total population.</p>
    </div>
  </div>
  <div class="calc-layout">
    <div class="panel">
      <div class="panel-title">Parameters</div>
      <div class="formula-box">
        <div class="formula-label">Formula</div>
        <div class="formula-expr">n_i = (N_i / N) × n</div>
        <div class="formula-desc">n_i = stratum sample size &nbsp;·&nbsp; N_i = stratum population &nbsp;·&nbsp; N = total population &nbsp;·&nbsp; n = total sample</div>
      </div>
      <div class="field-row">
        <div class="field">
          <label>Total Sample Size (n)</label>
          <input type="number" id="prop-n" value="200" min="1">
        </div>
        <div class="field">
          <label>Non-Response Rate (%)</label>
          <input type="number" id="prop-nr" value="0" min="0" max="99" step="1">
        </div>
      </div>

      <div style="margin-top: 4px;">
        <div class="strata-wrap visible" id="prop-strata-wrap">
          <div class="strata-header-row">
            <span>Strata</span>
            <button class="add-stratum-btn" onclick="addStratum('prop')">+ Add Stratum</button>
          </div>
          <div class="strata-list" id="prop-strata-list"></div>
        </div>
      </div>

      <div class="btn-row">
        <button class="btn-primary" onclick="calcProportional()">⟳ &nbsp; Calculate Allocation</button>
        <button class="btn-secondary" onclick="resetProportional()">↺ Reset</button>
      </div>
    </div>
    <div class="panel" id="prop-results-panel">
      <div class="panel-title">Results</div>
      <div class="results-empty" id="prop-empty">
        <div class="results-empty-icon">⊕</div>
        <h3>Ready to calculate</h3>
        <p>Fill in the parameters and click Calculate to see the allocation breakdown.</p>
      </div>
      <div class="results-content" id="prop-results" style="display:none;"></div>
    </div>
  </div>
</div>

<!-- TARO YAMANE -->
<div class="page" id="page-yamane">
  <div class="calc-header">
    <div class="calc-header-icon" style="background: var(--teal-dim);">∑</div>
    <div class="calc-header-text">
      <h2>Taro Yamane Formula</h2>
      <p>Compute the required sample size for finite populations. Simple, widely cited, and assumes a 95% confidence level.</p>
    </div>
  </div>
  <div class="calc-layout">
    <div class="panel">
      <div class="panel-title">Parameters</div>
      <div class="formula-box" style="border-left-color: var(--teal);">
        <div class="formula-label">Formula</div>
        <div class="formula-expr" style="color:var(--teal);">n = N / (1 + N × e²)</div>
        <div class="formula-desc">N = population size &nbsp;·&nbsp; e = margin of error &nbsp;·&nbsp; Assumes 95% confidence (Z = 1.96)</div>
      </div>
      <div class="field-row">
        <div class="field">
          <label>Population Size (N)</label>
          <input type="number" id="yam-n" value="5000" min="1">
        </div>
        <div class="field">
          <label>Margin of Error (e)</label>
          <input type="number" id="yam-e" value="0.05" min="0.001" max="1" step="0.01">
          <div class="field-hint">Decimal e.g. 0.05 = 5%</div>
        </div>
      </div>
      <div class="field">
        <label>Non-Response Rate (%)</label>
        <input type="number" id="yam-nr" value="0" min="0" max="99" step="1">
      </div>

      <div class="toggle-row" onclick="toggleStrata('yam')" id="yam-toggle-row">
        <div class="toggle-switch" id="yam-toggle">
          <div class="toggle-knob"></div>
        </div>
        <span class="toggle-label">Allocate across strata?</span>
      </div>
      <div class="strata-wrap" id="yam-strata-wrap">
        <div class="strata-header-row">
          <span>Strata</span>
          <button class="add-stratum-btn" onclick="event.stopPropagation();addStratum('yam')">+ Add Stratum</button>
        </div>
        <div class="strata-list" id="yam-strata-list"></div>
      </div>

      <div class="btn-row">
        <button class="btn-primary" onclick="calcYamane()">⟳ &nbsp; Calculate Sample Size</button>
        <button class="btn-secondary" onclick="resetYamane()">↺ Reset</button>
      </div>
    </div>
    <div class="panel">
      <div class="panel-title">Results</div>
      <div class="results-empty" id="yam-empty">
        <div class="results-empty-icon">∑</div>
        <h3>Ready to calculate</h3>
        <p>Enter population size and margin of error, then hit Calculate.</p>
      </div>
      <div class="results-content" id="yam-results" style="display:none;"></div>
    </div>
  </div>
</div>

<!-- COCHRAN -->
<div class="page" id="page-cochran">
  <div class="calc-header">
    <div class="calc-header-icon" style="background: var(--amber-dim);">%</div>
    <div class="calc-header-text">
      <h2>Cochran's Formula</h2>
      <p>Calculates the required sample size based on an estimated population proportion. Supports flexible input formats and finite population correction.</p>
    </div>
  </div>
  <div class="calc-layout">
    <div class="panel">
      <div class="panel-title">Parameters</div>
      <div class="formula-box" style="border-left-color: var(--amber);">
        <div class="formula-label">Formula</div>
        <div class="formula-expr" style="color:var(--amber);">n₀ = Z² × p × (1−p) / e²</div>
        <div class="formula-desc">Finite correction: n = n₀ / (1 + (n₀−1)/N) &nbsp;·&nbsp; p = estimated proportion &nbsp;·&nbsp; e = margin of error</div>
      </div>
      <div class="field">
        <label>Estimated Proportion (p)</label>
        <input type="text" id="coch-p" value="50%" placeholder="0.5 · 50 · 50%">
        <div class="field-hint">Accepts: 0.50 (decimal), 50 (percent), or 50%</div>
      </div>
      <div class="field-row">
        <div class="field">
          <label>Z-Score (Confidence)</label>
          <input type="number" id="coch-z" value="1.96" min="0.5" max="3.5" step="0.01">
          <div class="field-hint">90%=1.645 · 95%=1.96 · 99%=2.576</div>
        </div>
        <div class="field">
          <label>Margin of Error (e)</label>
          <input type="number" id="coch-e" value="0.05" min="0.001" max="1" step="0.01">
        </div>
      </div>
      <div class="field-row">
        <div class="field">
          <label>Population Size (optional)</label>
          <input type="number" id="coch-N" placeholder="Leave blank for ∞">
          <div class="field-hint">For finite population correction</div>
        </div>
        <div class="field">
          <label>Non-Response Rate (%)</label>
          <input type="number" id="coch-nr" value="0" min="0" max="99" step="1">
        </div>
      </div>

      <div class="toggle-row" onclick="toggleStrata('coch')" id="coch-toggle-row">
        <div class="toggle-switch" id="coch-toggle"><div class="toggle-knob"></div></div>
        <span class="toggle-label">Allocate across strata?</span>
      </div>
      <div class="strata-wrap" id="coch-strata-wrap">
        <div class="strata-header-row">
          <span>Strata</span>
          <button class="add-stratum-btn" onclick="event.stopPropagation();addStratum('coch')">+ Add Stratum</button>
        </div>
        <div class="strata-list" id="coch-strata-list"></div>
      </div>

      <div class="btn-row">
        <button class="btn-primary" onclick="calcCochran()">⟳ &nbsp; Calculate Sample Size</button>
        <button class="btn-secondary" onclick="resetCochran()">↺ Reset</button>
      </div>
    </div>
    <div class="panel">
      <div class="panel-title">Results</div>
      <div class="results-empty" id="coch-empty">
        <div class="results-empty-icon">%</div>
        <h3>Ready to calculate</h3>
        <p>Enter proportion, Z-score, and margin of error, then hit Calculate.</p>
      </div>
      <div class="results-content" id="coch-results" style="display:none;"></div>
    </div>
  </div>
</div>

<!-- OTHER FORMULAS -->
<div class="page" id="page-other">
  <div class="calc-header">
    <div class="calc-header-icon" style="background: var(--coral-dim);">∫</div>
    <div class="calc-header-text">
      <h2>Other Statistical Formulas</h2>
      <p>Additional sample size methods for proportion estimation, mean estimation, and correlation studies.</p>
    </div>
  </div>
  <div class="calc-layout">
    <div class="panel">
      <div class="panel-title">Parameters</div>
      <div class="field">
        <label>Select Formula Type</label>
        <select id="other-type" onchange="updateOtherFormula()">
          <option value="prop">Single Population Proportion</option>
          <option value="mean">Mean Estimation (Known Variance)</option>
          <option value="corr">Correlation Coefficient</option>
        </select>
      </div>
      <div class="formula-box" style="border-left-color: var(--coral);" id="other-formula-box">
        <div class="formula-label">Formula</div>
        <div class="formula-expr" style="color:var(--coral);" id="other-formula-expr"></div>
        <div class="formula-desc" id="other-formula-desc"></div>
      </div>
      <div id="other-inputs"></div>
      <div class="field">
        <label>Non-Response Rate (%)</label>
        <input type="number" id="other-nr" value="0" min="0" max="99" step="1">
      </div>

      <div class="toggle-row" onclick="toggleStrata('oth')" id="oth-toggle-row">
        <div class="toggle-switch" id="oth-toggle"><div class="toggle-knob"></div></div>
        <span class="toggle-label">Allocate across strata?</span>
      </div>
      <div class="strata-wrap" id="oth-strata-wrap">
        <div class="strata-header-row">
          <span>Strata</span>
          <button class="add-stratum-btn" onclick="event.stopPropagation();addStratum('oth')">+ Add Stratum</button>
        </div>
        <div class="strata-list" id="oth-strata-list"></div>
      </div>

      <div class="btn-row">
        <button class="btn-primary" onclick="calcOther()">⟳ &nbsp; Calculate Sample Size</button>
        <button class="btn-secondary" onclick="resetOther()">↺ Reset</button>
      </div>
    </div>
    <div class="panel">
      <div class="panel-title">Results</div>
      <div class="results-empty" id="oth-empty">
        <div class="results-empty-icon">∫</div>
        <h3>Ready to calculate</h3>
        <p>Select a formula, enter parameters, then hit Calculate.</p>
      </div>
      <div class="results-content" id="oth-results" style="display:none;"></div>
    </div>
  </div>
</div>

</main>

<button id="btt" onclick="window.scrollTo({top:0,behavior:'smooth'})">↑</button>

<div id="toast">
  <div class="toast-dot" id="toast-dot"></div>
  <div class="toast-text">
    <strong id="toast-title"></strong>
    <span id="toast-msg"></span>
  </div>
</div>

<script>
// ─── STATE ─────────────────────────────────────────────────────
const strataCounts = { prop: 0, yam: 0, coch: 0, oth: 0 };
let toastTimer;

// ─── BOOT ──────────────────────────────────────────────────────
window.addEventListener('load', () => {
  setTimeout(() => {
    document.getElementById('loader').classList.add('out');
    setTimeout(() => document.getElementById('loader').style.display='none', 700);
  }, 1400);

  const saved = localStorage.getItem('ss-theme');
  if (saved === 'light') applyTheme('light');

  // default strata
  initDefaultStrata('prop', 3);
  updateOtherFormula();

  // nav
  document.querySelectorAll('[data-page]').forEach(btn => {
    btn.addEventListener('click', () => goTo(btn.dataset.page));
  });

  document.getElementById('themeBtn').addEventListener('click', toggleTheme);
  document.getElementById('hamburger').addEventListener('click', () => {
    document.getElementById('mobileDrawer').classList.toggle('open');
  });

  // back to top
  window.addEventListener('scroll', () => {
    document.getElementById('btt').classList.toggle('show', scrollY > 400);
  });

  toast('Welcome to CalcuStats Lite', 'Professional sample size hub', 'info');
});

// ─── NAVIGATION ─────────────────────────────────────────────────
function goTo(page) {
  document.querySelectorAll('.page').forEach(p => p.classList.remove('active'));
  document.querySelectorAll('[data-page]').forEach(b => b.classList.remove('active'));
  document.getElementById('page-' + page).classList.add('active');
  document.querySelectorAll('[data-page="'+page+'"]').forEach(b => b.classList.add('active'));
  document.getElementById('mobileDrawer').classList.remove('open');
  window.scrollTo({top:0, behavior:'smooth'});
}

// ─── THEME ──────────────────────────────────────────────────────
let currentTheme = 'dark';
function applyTheme(t) {
  currentTheme = t;
  document.body.className = t === 'light' ? 'light' : '';
  document.getElementById('themeBtn').textContent = t === 'light' ? '☾' : '☀';
  localStorage.setItem('ss-theme', t);
}
function toggleTheme() { applyTheme(currentTheme === 'dark' ? 'light' : 'dark'); }

// ─── TOAST ──────────────────────────────────────────────────────
function toast(title, msg, type='success') {
  clearTimeout(toastTimer);
  const el = document.getElementById('toast');
  const dot = document.getElementById('toast-dot');
  document.getElementById('toast-title').textContent = title;
  document.getElementById('toast-msg').textContent = msg;
  dot.className = 'toast-dot ' + type;
  el.classList.add('show');
  toastTimer = setTimeout(() => el.classList.remove('show'), 4000);
}

// ─── STRATA MANAGEMENT ─────────────────────────────────────────
function initDefaultStrata(prefix, count) {
  for (let i = 0; i < count; i++) addStratum(prefix, false);
}

function addStratum(prefix, populate=true) {
  strataCounts[prefix]++;
  const n = strataCounts[prefix];
  const list = document.getElementById(prefix + '-strata-list');
  const row = document.createElement('div');
  row.className = 'stratum-row';
  row.id = `${prefix}-sr-${n}`;
  row.innerHTML = `
    <input type="text" id="${prefix}-sn-${n}" value="Stratum ${n}" placeholder="Name">
    <input type="number" id="${prefix}-sp-${n}" value="100" min="1" placeholder="Population">
    <button class="del-stratum" onclick="delStratum('${prefix}',${n})" title="Remove">✕</button>
  `;
  list.appendChild(row);
  if (populate) updateDelButtons(prefix);
}

function delStratum(prefix, id) {
  const el = document.getElementById(`${prefix}-sr-${id}`);
  if (el) el.remove();
  strataCounts[prefix]--;
  // renumber
  const list = document.getElementById(prefix + '-strata-list');
  list.querySelectorAll('.stratum-row').forEach((row, idx) => {
    const num = idx + 1;
    const inputs = row.querySelectorAll('input');
    row.id = `${prefix}-sr-${num}`;
    if(inputs[0]) { inputs[0].id = `${prefix}-sn-${num}`; if(inputs[0].value.startsWith('Stratum')) inputs[0].value = `Stratum ${num}`; }
    if(inputs[1]) inputs[1].id = `${prefix}-sp-${num}`;
    const btn = row.querySelector('.del-stratum');
    if(btn) btn.setAttribute('onclick', `delStratum('${prefix}',${num})`);
  });
  strataCounts[prefix] = document.getElementById(prefix + '-strata-list').querySelectorAll('.stratum-row').length;
  updateDelButtons(prefix);
}

function updateDelButtons(prefix) {
  const rows = document.querySelectorAll(`#${prefix}-strata-list .stratum-row`);
  rows.forEach(r => {
    const btn = r.querySelector('.del-stratum');
    if(btn) btn.disabled = rows.length <= 1;
  });
}

function toggleStrata(prefix) {
  const sw = document.getElementById(prefix + '-toggle');
  const wrap = document.getElementById(prefix + '-strata-wrap');
  const isOn = sw.classList.toggle('on');
  if(isOn) {
    wrap.classList.add('visible');
    if(strataCounts[prefix] === 0) addStratum(prefix);
    updateDelButtons(prefix);
  } else {
    wrap.classList.remove('visible');
  }
}

function getStrata(prefix) {
  const list = document.getElementById(prefix + '-strata-list');
  const rows = list.querySelectorAll('.stratum-row');
  const strata = [];
  rows.forEach((r, i) => {
    const num = i+1;
    const name = (document.getElementById(`${prefix}-sn-${num}`)?.value || `Stratum ${num}`).trim();
    const pop = parseFloat(document.getElementById(`${prefix}-sp-${num}`)?.value) || 0;
    if(pop > 0) strata.push({name, pop});
  });
  return strata;
}

// ─── HELPERS ────────────────────────────────────────────────────
function parseProp(v) {
  if(!v) return 0.5;
  const s = v.toString().trim();
  if(s.includes('%')) {
    const n = parseFloat(s); return isNaN(n) ? 0.5 : n/100;
  }
  const n = parseFloat(s);
  if(isNaN(n)) return 0.5;
  if(n >= 0 && n <= 1) return n;
  if(n > 1 && n <= 100) return n/100;
  return 0.5;
}

function fmtProp(v) { return (v*100).toFixed(1) + '%'; }
function fmtN(n) { return Math.round(n).toLocaleString(); }

function getNR(id) {
  const v = document.getElementById(id)?.value?.trim();
  return (v === '' || v === undefined) ? 0 : Math.min(99, Math.max(0, parseFloat(v)||0));
}

function applyNR(n, nr) {
  if(nr <= 0) return Math.ceil(n);
  return Math.ceil(n / (1 - nr/100));
}

function buildAllocResult(strata, totalPop, sample) {
  const allocs = strata.map(s => {
    const raw = (s.pop / totalPop) * sample;
    return { name: s.name, pop: s.pop, raw, n: Math.floor(raw), prop: s.pop/totalPop };
  });
  let totalAlloc = allocs.reduce((a,b) => a+b.n, 0);
  let rem = sample - totalAlloc;
  const sorted = [...allocs].sort((a,b) => (b.raw-b.n)-(a.raw-a.n));
  for(let i=0;i<rem;i++) sorted[i%sorted.length].n++;
  return allocs;
}

// ─── RESULT RENDERING ───────────────────────────────────────────
function showResults(prefix, html) {
  document.getElementById(prefix + '-empty').style.display = 'none';
  const el = document.getElementById(prefix + '-results');
  el.innerHTML = html;
  el.style.display = 'block';
  if(window.innerWidth <= 1024) {
    setTimeout(() => el.scrollIntoView({behavior:'smooth', block:'start'}), 100);
  }
}
function clearResults(prefix) {
  document.getElementById(prefix + '-empty').style.display = 'flex';
  const el = document.getElementById(prefix + '-results');
  el.innerHTML = ''; el.style.display = 'none';
}

function metricHTML(label, val, highlight=false) {
  return `<div class="result-metric">
    <div class="result-metric-label">${label}</div>
    <div class="result-metric-value${highlight?' highlight':''}">${val}</div>
  </div>`;
}

function stepsHTML(text) {
  return `<div class="steps-box">${text}</div>`;
}

function allocHTML(allocs, totalSample) {
  const rows = allocs.map(a => {
    const pct = (a.n/totalSample*100).toFixed(1);
    const barW = Math.round(a.prop*100);
    return `<div class="alloc-item">
      <div class="alloc-name">${a.name}</div>
      <div class="alloc-bar-wrap"><div class="alloc-bar" style="width:${barW}%"></div></div>
      <div class="alloc-val">${a.n}</div>
      <div class="alloc-pct">${(a.prop*100).toFixed(1)}%</div>
    </div>`;
  }).join('');
  return `<div style="margin-top:4px;"><div style="font-size:10px;font-weight:600;letter-spacing:.1em;text-transform:uppercase;color:var(--text3);margin-bottom:10px;">Stratum Allocation</div><div class="alloc-list">${rows}</div></div>`;
}

// ─── PROPORTIONAL ALLOCATION ────────────────────────────────────
function calcProportional() {
  const n = parseInt(document.getElementById('prop-n').value) || 0;
  const nr = getNR('prop-nr');
  if(!n) { toast('Missing input','Please enter total sample size.','warn'); return; }

  const strata = getStrata('prop');
  if(!strata.length) { toast('No strata','Add at least one stratum with population > 0.','warn'); return; }
  const totalPop = strata.reduce((a,b) => a+b.pop, 0);
  const adj = applyNR(n, nr);
  const allocs = buildAllocResult(strata, totalPop, adj);

  let steps = `<span class="step-head">Given:</span>\n`;
  steps += `  Total sample (n)      = ${n}\n`;
  steps += `  Non-response rate     = ${nr}%\n`;
  steps += `  Total population (N)  = ${fmtN(totalPop)}\n\n`;
  if(nr>0) steps += `<span class="step-head">Non-Response Adjustment:</span>\n  n_adj = ${n} / (1 − ${nr}/100) = <span class="step-val">${adj}</span>\n\n`;
  steps += `<span class="step-head">Proportional Allocation  n_i = (N_i / N) × n:</span>\n`;
  allocs.forEach(a => {
    steps += `  ${a.name}: (${a.pop} / ${totalPop}) × ${adj} = <span class="step-val">${a.n}</span>\n`;
  });

  let html = metricHTML('Total Sample', fmtN(n));
  if(nr>0) html += metricHTML('Adjusted for Non-Response', fmtN(adj), true);
  else html += metricHTML('Sample Size', fmtN(adj), true);
  html += metricHTML('Total Population', fmtN(totalPop));
  html += metricHTML('Number of Strata', strata.length);
  html += stepsHTML(steps);
  html += allocHTML(allocs, adj);

  showResults('prop', html);
  toast('Allocation complete', `${fmtN(adj)} samples across ${strata.length} strata`, 'success');
}

function resetProportional() {
  document.getElementById('prop-n').value = 200;
  document.getElementById('prop-nr').value = 0;
  document.getElementById('prop-strata-list').innerHTML = '';
  strataCounts.prop = 0;
  initDefaultStrata('prop', 3);
  clearResults('prop');
  toast('Reset', 'Proportional allocation cleared.', 'info');
}

// ─── TARO YAMANE ────────────────────────────────────────────────
function calcYamane() {
  const N = parseFloat(document.getElementById('yam-n').value) || 0;
  const e = parseFloat(document.getElementById('yam-e').value) || 0.05;
  const nr = getNR('yam-nr');
  const useStrata = document.getElementById('yam-toggle').classList.contains('on');

  if(!N) { toast('Missing input','Enter population size.','warn'); return; }

  const raw = N / (1 + N * e * e);
  const n0 = Math.ceil(raw);
  const adj = applyNR(n0, nr);

  let steps = `<span class="step-head">Given:</span>\n`;
  steps += `  N = ${fmtN(N)},  e = ${e},  non-response = ${nr}%\n\n`;
  steps += `<span class="step-head">Yamane Formula:</span>\n`;
  steps += `  n = N / (1 + N × e²)\n`;
  steps += `  n = ${fmtN(N)} / (1 + ${fmtN(N)} × ${e}²)\n`;
  steps += `  n = ${fmtN(N)} / ${(1 + N*e*e).toFixed(4)}\n`;
  steps += `  n = ${raw.toFixed(4)} → <span class="step-val">${n0}</span>\n`;
  if(nr>0) steps += `\n<span class="step-head">Non-Response Adjustment:</span>\n  n_adj = ${n0} / (1 − ${nr}/100) = <span class="step-val">${adj}</span>\n`;

  let html = metricHTML('Population Size', fmtN(N));
  html += metricHTML('Margin of Error', (e*100).toFixed(1)+'%');
  html += metricHTML('Non-Response Rate', nr+'%');
  html += metricHTML(nr>0?'Adjusted Sample Size':'Recommended Sample Size', fmtN(adj), true);
  html += stepsHTML(steps);

  if(useStrata) {
    const strata = getStrata('yam');
    if(strata.length) {
      const tp = strata.reduce((a,b)=>a+b.pop,0);
      const allocs = buildAllocResult(strata, tp, adj);
      let aSteps = `\n<span class="step-head">Stratum Allocation:</span>\n`;
      allocs.forEach(a => aSteps += `  ${a.name}: (${a.pop}/${tp}) × ${adj} = <span class="step-val">${a.n}</span>\n`);
      html += stepsHTML(aSteps);
      html += allocHTML(allocs, adj);
    }
  }

  showResults('yam', html);
  toast('Yamane calculation done', `Sample size: ${fmtN(adj)}`, 'success');
}

function resetYamane() {
  document.getElementById('yam-n').value = 5000;
  document.getElementById('yam-e').value = 0.05;
  document.getElementById('yam-nr').value = 0;
  const sw = document.getElementById('yam-toggle');
  sw.classList.remove('on');
  document.getElementById('yam-strata-wrap').classList.remove('visible');
  document.getElementById('yam-strata-list').innerHTML='';
  strataCounts.yam=0;
  clearResults('yam');
  toast('Reset','Yamane parameters cleared.','info');
}

// ─── COCHRAN ────────────────────────────────────────────────────
function calcCochran() {
  const pRaw = document.getElementById('coch-p').value;
  const p = parseProp(pRaw);
  const z = parseFloat(document.getElementById('coch-z').value) || 1.96;
  const e = parseFloat(document.getElementById('coch-e').value) || 0.05;
  const Nraw = document.getElementById('coch-N').value.trim();
  const N = Nraw ? parseFloat(Nraw) : null;
  const nr = getNR('coch-nr');
  const useStrata = document.getElementById('coch-toggle').classList.contains('on');

  if(p<0||p>1) { toast('Invalid proportion','Enter value between 0–1, 0–100, or 0%–100%.','warn'); return; }

  const n0 = (z*z * p * (1-p)) / (e*e);
  let n = n0;
  let fpc = false;
  if(N && N > 0) { n = n0 / (1 + (n0-1)/N); fpc = true; }
  const nCeil = Math.ceil(n);
  const adj = applyNR(nCeil, nr);

  let steps = `<span class="step-head">Given:</span>\n`;
  steps += `  p = "${pRaw}" → ${p.toFixed(4)} (${fmtProp(p)})\n`;
  steps += `  Z = ${z},  e = ${e},  non-response = ${nr}%\n\n`;
  steps += `<span class="step-head">Cochran Formula (infinite population):</span>\n`;
  steps += `  n₀ = Z² × p × (1−p) / e²\n`;
  steps += `  n₀ = ${z}² × ${p.toFixed(4)} × ${(1-p).toFixed(4)} / ${e}²\n`;
  steps += `  n₀ = ${(z*z).toFixed(4)} × ${(p*(1-p)).toFixed(4)} / ${(e*e).toFixed(6)}\n`;
  steps += `  n₀ = <span class="step-val">${n0.toFixed(4)}</span>\n`;
  if(fpc) {
    steps += `\n<span class="step-head">Finite Population Correction (N=${fmtN(N)}):</span>\n`;
    steps += `  n = n₀ / (1 + (n₀−1)/N)\n`;
    steps += `  n = ${n0.toFixed(4)} / (1 + ${(n0-1).toFixed(4)}/${N})\n`;
    steps += `  n = <span class="step-val">${n.toFixed(4)}</span> → ${nCeil}\n`;
  }
  if(nr>0) steps += `\n<span class="step-head">Non-Response Adjustment:</span>\n  n_adj = ${nCeil} / (1−${nr}/100) = <span class="step-val">${adj}</span>\n`;

  let html = metricHTML('Estimated Proportion', fmtProp(p));
  html += metricHTML('Z-Score', z + (z===1.96?' (95%)':z===1.645?' (90%)':z===2.576?' (99%)':''));
  html += metricHTML('Margin of Error', (e*100).toFixed(1)+'%');
  if(fpc) html += metricHTML('Population Size', fmtN(N));
  html += metricHTML(nr>0?'Initial Sample Size':'Recommended Sample Size', fmtN(adj), true);
  if(nr>0) html += metricHTML('Non-Response Adjusted', fmtN(adj));
  html += stepsHTML(steps);

  if(useStrata) {
    const strata = getStrata('coch');
    if(strata.length) {
      const tp = strata.reduce((a,b)=>a+b.pop,0);
      const allocs = buildAllocResult(strata, tp, adj);
      let aSteps = `\n<span class="step-head">Stratum Allocation:</span>\n`;
      allocs.forEach(a => aSteps += `  ${a.name}: (${a.pop}/${tp}) × ${adj} = <span class="step-val">${a.n}</span>\n`);
      html += stepsHTML(aSteps);
      html += allocHTML(allocs, adj);
    }
  }

  showResults('coch', html);
  toast('Cochran calculation done', `Sample size: ${fmtN(adj)}`, 'success');
}

function resetCochran() {
  document.getElementById('coch-p').value = '50%';
  document.getElementById('coch-z').value = 1.96;
  document.getElementById('coch-e').value = 0.05;
  document.getElementById('coch-N').value = '';
  document.getElementById('coch-nr').value = 0;
  document.getElementById('coch-toggle').classList.remove('on');
  document.getElementById('coch-strata-wrap').classList.remove('visible');
  document.getElementById('coch-strata-list').innerHTML='';
  strataCounts.coch=0;
  clearResults('coch');
  toast('Reset','Cochran parameters cleared.','info');
}

// ─── OTHER FORMULAS ─────────────────────────────────────────────
function updateOtherFormula() {
  const type = document.getElementById('other-type').value;
  const expEl = document.getElementById('other-formula-expr');
  const descEl = document.getElementById('other-formula-desc');
  const inp = document.getElementById('other-inputs');

  const defs = {
    prop: {
      expr: 'n = Z² × p × (1−p) / e²',
      desc: 'For estimating a single proportion with specified precision.',
      html: `<div class="field-row">
        <div class="field"><label>Proportion (p)</label><input type="text" id="oth-p" value="50%" placeholder="0.5 / 50 / 50%">
        <div class="field-hint">Decimal · percent · or with %</div></div>
        <div class="field"><label>Z-Score</label><input type="number" id="oth-z" value="1.96" step="0.01">
        <div class="field-hint">90%=1.645 · 95%=1.96 · 99%=2.576</div></div>
      </div>
      <div class="field"><label>Margin of Error (e)</label><input type="number" id="oth-e" value="0.05" step="0.01"></div>`
    },
    mean: {
      expr: 'n = (Z² × σ²) / e²',
      desc: 'For estimating population mean when variance is known.',
      html: `<div class="field-row">
        <div class="field"><label>Std Deviation (σ)</label><input type="number" id="oth-sd" value="1" min="0.001" step="0.1"></div>
        <div class="field"><label>Z-Score</label><input type="number" id="oth-z2" value="1.96" step="0.01">
        <div class="field-hint">90%=1.645 · 95%=1.96</div></div>
      </div>
      <div class="field"><label>Margin of Error (e)</label><input type="number" id="oth-me" value="0.5" step="0.1"></div>`
    },
    corr: {
      expr: 'n = [(Zα + Zβ) / (0.5 × ln((1+r)/(1−r)))]² + 3',
      desc: "Fisher's z transformation for detecting correlations at specified power.",
      html: `<div class="field"><label>Expected Correlation (r)</label><input type="number" id="oth-r" value="0.3" min="-0.99" max="0.99" step="0.01"></div>
      <div class="field-row">
        <div class="field"><label>Alpha (α)</label><input type="number" id="oth-a" value="0.05" step="0.01"></div>
        <div class="field"><label>Power (1−β)</label><input type="number" id="oth-pw" value="0.8" step="0.01"></div>
      </div>`
    }
  };

  const d = defs[type];
  expEl.textContent = d.expr;
  descEl.textContent = d.desc;
  inp.innerHTML = d.html;
}

function zFromAlpha(a) {
  if(a<=0.001) return 3.291; if(a<=0.005) return 2.807;
  if(a<=0.01) return 2.576; if(a<=0.025) return 2.241;
  if(a<=0.05) return 1.96; if(a<=0.10) return 1.645;
  return 1.282;
}
function zFromPower(pw) {
  if(pw>=0.99) return 2.326; if(pw>=0.95) return 1.645;
  if(pw>=0.90) return 1.282; if(pw>=0.85) return 1.036;
  if(pw>=0.80) return 0.842; if(pw>=0.75) return 0.674;
  if(pw>=0.70) return 0.524; if(pw>=0.60) return 0.253;
  return 0.000;
}

function calcOther() {
  const type = document.getElementById('other-type').value;
  const nr = getNR('other-nr');
  const useStrata = document.getElementById('oth-toggle').classList.contains('on');
  let n0, fname, steps;

  if(type === 'prop') {
    const p = parseProp(document.getElementById('oth-p')?.value);
    const z = parseFloat(document.getElementById('oth-z')?.value) || 1.96;
    const e = parseFloat(document.getElementById('oth-e')?.value) || 0.05;
    fname = 'Single Proportion';
    n0 = (z*z * p * (1-p)) / (e*e);
    steps = `<span class="step-head">Given:</span> p=${fmtProp(p)}, Z=${z}, e=${e}\n`;
    steps += `<span class="step-head">Formula:</span> n = Z² × p × (1−p) / e²\n`;
    steps += `n = ${(z*z).toFixed(4)} × ${(p*(1-p)).toFixed(4)} / ${(e*e).toFixed(6)} = <span class="step-val">${n0.toFixed(2)}</span>`;
  } else if(type === 'mean') {
    const sd = parseFloat(document.getElementById('oth-sd')?.value) || 1;
    const z = parseFloat(document.getElementById('oth-z2')?.value) || 1.96;
    const me = parseFloat(document.getElementById('oth-me')?.value) || 0.5;
    fname = 'Mean Estimation';
    n0 = (z*z * sd*sd) / (me*me);
    steps = `<span class="step-head">Given:</span> σ=${sd}, Z=${z}, e=${me}\n`;
    steps += `<span class="step-head">Formula:</span> n = (Z² × σ²) / e²\n`;
    steps += `n = (${(z*z).toFixed(4)} × ${(sd*sd).toFixed(4)}) / ${(me*me).toFixed(4)} = <span class="step-val">${n0.toFixed(2)}</span>`;
  } else {
    const r = parseFloat(document.getElementById('oth-r')?.value) || 0.3;
    const a = parseFloat(document.getElementById('oth-a')?.value) || 0.05;
    const pw = parseFloat(document.getElementById('oth-pw')?.value) || 0.8;
    fname = 'Correlation Study';
    const za = zFromAlpha(a), zb = zFromPower(pw);
    const fz = 0.5 * Math.log((1+r)/(1-r));
    n0 = Math.pow((za+zb)/fz, 2) + 3;
    steps = `<span class="step-head">Given:</span> r=${r}, α=${a}, power=${pw}\n`;
    steps += `<span class="step-head">Z-scores:</span> Zα=${za.toFixed(4)}, Zβ=${zb.toFixed(4)}\n`;
    steps += `<span class="step-head">Fisher z:</span> 0.5 × ln((1+${r})/(1−${r})) = ${fz.toFixed(4)}\n`;
    steps += `<span class="step-head">Formula:</span> n = ((${za.toFixed(4)}+${zb.toFixed(4)}) / ${fz.toFixed(4)})² + 3\n`;
    steps += `n = ${(Math.pow((za+zb)/fz,2)).toFixed(2)} + 3 = <span class="step-val">${Math.ceil(n0)}</span>`;
  }

  const nCeil = Math.ceil(n0);
  const adj = applyNR(nCeil, nr);
  if(nr>0) steps += `\n\n<span class="step-head">Non-Response Adjustment:</span>\n  ${nCeil} / (1−${nr}/100) = <span class="step-val">${adj}</span>`;

  let html = metricHTML('Formula', fname);
  html += metricHTML('Non-Response Rate', nr+'%');
  html += metricHTML('Recommended Sample Size', fmtN(adj), true);
  html += stepsHTML(steps);

  if(useStrata) {
    const strata = getStrata('oth');
    if(strata.length) {
      const tp = strata.reduce((a,b)=>a+b.pop,0);
      const allocs = buildAllocResult(strata, tp, adj);
      let aSteps = `\n<span class="step-head">Stratum Allocation:</span>\n`;
      allocs.forEach(a => aSteps += `  ${a.name}: (${a.pop}/${tp}) × ${adj} = <span class="step-val">${a.n}</span>\n`);
      html += stepsHTML(aSteps);
      html += allocHTML(allocs, adj);
    }
  }

  showResults('oth', html);
  toast(`${fname} done`, `Sample size: ${fmtN(adj)}`, 'success');
}

function resetOther() {
  document.getElementById('other-type').value = 'prop';
  document.getElementById('other-nr').value = 0;
  document.getElementById('oth-toggle').classList.remove('on');
  document.getElementById('oth-strata-wrap').classList.remove('visible');
  document.getElementById('oth-strata-list').innerHTML='';
  strataCounts.oth=0;
  updateOtherFormula();
  clearResults('oth');
  toast('Reset','Other formula parameters cleared.','info');
}
</script>
</body>
</html>
