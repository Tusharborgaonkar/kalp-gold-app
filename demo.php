<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MetalPulse — Live MCX Gold & Silver Market Rates</title>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:ital,opsz,wght@0,9..40,300;0,9..40,400;0,9..40,500;0,9..40,600;0,9..40,700;1,9..40,300&family=DM+Serif+Display:ital@0;1&display=swap" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/ScrollTrigger.min.js"></script>
<script src="https://cdn.jsdelivr.net/gh/studio-freight/lenis@1.0.19/bundled/lenis.min.js"></script>
<style>
  :root {
    --bg: #0B0E11;
    --card: #161A23;
    --border: #2A2F3A;
    --gold: #D4AF37;
    --gold-light: #F6D365;
    --silver: #A8A9AD;
    --silver-grad: linear-gradient(135deg, #8E9196 0%, #E5E7EB 50%, #8E9196 100%);
    --board-accent: var(--gold);
    --board-accent-grad: var(--grad);
    --text: #FFFFFF;
    --muted: #9CA3AF;
    --green: #22C55E;
    --red: #EF4444;
    --grad: linear-gradient(135deg, #D4AF37, #F6D365);
  }

  * { margin: 0; padding: 0; box-sizing: border-box; }

  html, body {
    overflow-x: hidden;
    width: 100%;
    position: relative;
  }

  body {
    background: var(--bg);
    color: var(--text);
    font-family: 'DM Sans', sans-serif;
    line-height: 1.6;
  }

  /* NOISE TEXTURE OVERLAY */
  body::before {
    content: '';
    position: fixed;
    inset: 0;
    background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)' opacity='0.03'/%3E%3C/svg%3E");
    pointer-events: none;
    z-index: 0;
    opacity: 0.4;
  }

  /* SCROLLBAR */
  ::-webkit-scrollbar { width: 4px; }
  ::-webkit-scrollbar-track { background: var(--bg); }
  ::-webkit-scrollbar-thumb { background: var(--gold); border-radius: 2px; }

  /* NAVBAR */
  nav {
    position: fixed;
    top: 0; left: 0; right: 0;
    z-index: 100;
    padding: 0 5%;
    height: 70px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    background: rgba(11, 14, 17, 0.75);
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
    border-bottom: 1px solid rgba(212, 175, 55, 0.12);
    transition: all 0.3s;
  }

  .nav-logo {
    display: flex;
    align-items: center;
    gap: 10px;
    text-decoration: none;
  }

  .logo-icon {
    width: 36px; height: 36px;
    background: var(--grad);
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 18px;
  }

  .logo-text {
    font-family: 'DM Serif Display', serif;
    font-size: 1.3rem;
    background: var(--grad);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    letter-spacing: -0.02em;
    font-weight: 700;
  }


  /* ALERT MARQUEE */
  .alert-marquee {
    background: #000;
    border-bottom: 1px solid var(--border);
    padding: 8px 0;
    overflow: hidden;
    white-space: nowrap;
  }

  .alert-inner {
    display: inline-block;
    animation: alert-scroll 30s linear infinite;
    padding-left: 100%;
  }

  .alert-item {
    display: inline-block;
    color: var(--gold-light);
    font-size: 0.85rem;
    font-weight: 600;
    margin-right: 50px;
  }

  @keyframes alert-scroll {
    0% { transform: translateX(0); }
    100% { transform: translateX(-100%); }
  }

  /* TABS */
  /* RATES BOARD - BULLION STYLE */
  .rates-board {
    max-width: 900px;
    margin: 40px auto;
    background: #000;
    border: 1px solid var(--border);
    border-radius: 4px;
    overflow: hidden;
    box-shadow: 0 20px 50px rgba(0,0,0,0.5);
  }

  .rb-tabs {
    display: grid;
    grid-template-columns: 1fr 1fr;
    border-bottom: 2px solid #000;
  }

  .rb-tab {
    padding: 15px;
    text-align: center;
    background: #000;
    color: #fff;
    font-weight: 700;
    font-size: 0.9rem;
    cursor: pointer;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    border: 1px solid #111;
    transition: all 0.3s;
  }

  .rb-tab.active {
    background: var(--board-accent-grad);
    color: #fff;
    border-color: var(--board-accent);
  }

  .rb-spotlight {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;
    background: #1A1A1A;
    border-bottom: 1px solid #333;
  }

  .rb-spot-item {
    padding: 20px;
    text-align: center;
    border-right: 1px solid #333;
  }

  .rb-spot-item:last-child { border-right: none; }

  .rb-spot-label {
    color: var(--board-accent);
    font-weight: 700;
    font-size: 0.85rem;
    text-transform: uppercase;
    margin-bottom: 8px;
  }

  .rb-spot-value {
    font-size: 1.5rem;
    font-weight: 800;
    color: var(--board-accent);
    font-family: 'DM Sans', sans-serif;
  }

  .rb-product-list {
    background: var(--bg);
    padding: 10px;
  }

  .rb-product-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: var(--card);
    border: 1px solid var(--border);
    margin-bottom: 8px;
    padding: 15px 20px;
    border-radius: 4px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.2);
  }

  .rb-prod-name {
    color: var(--board-accent);
    font-weight: 600;
    font-size: 0.95rem;
  }

  .rb-prod-price {
    color: var(--board-accent);
    font-weight: 800;
    font-size: 1.3rem;
  }

  .rb-table-header {
    background: #1A1A1A;
    display: grid;
    grid-template-columns: 2fr 1fr 1fr;
    padding: 12px 20px;
  }

  .rb-th {
    color: var(--board-accent);
    font-weight: 700;
    font-size: 0.85rem;
    text-transform: uppercase;
  }

  .rb-th.center { text-align: center; }

  .rb-cost-row {
    background: var(--card);
    display: grid;
    grid-template-columns: 2.2fr 1fr 1fr;
    padding: 15px 20px;
    border-bottom: 1px solid var(--border);
    align-items: center;
  }

  .rb-cost-prod {
    color: var(--board-accent);
    font-weight: 700;
    font-size: 0.95rem;
  }

  .rb-cost-val-wrap {
    text-align: center;
  }

  .rb-cost-val {
    display: block;
    color: var(--board-accent);
    font-weight: 800;
    font-size: 1.3rem;
  }

  .rb-hl {
    font-size: 0.7rem;
    font-weight: 700;
    margin-top: 4px;
  }

  .rb-hl.high { color: #22C55E; }
  .rb-hl.low { color: #EF4444; }

  /* Redefining some elements for index1.php context */
  .live-rates { padding: 100px 0; background: #0B0E11; }

  .nav-links {
    display: flex;
    gap: 2.5rem;
    list-style: none;
  }

  .nav-links a {
    color: var(--muted);
    text-decoration: none;
    font-size: 0.88rem;
    font-weight: 500;
    transition: color 0.2s;
    letter-spacing: 0.01em;
  }

  .nav-links a:hover { color: var(--text); }

  .btn-gold {
    background: var(--grad);
    color: #0B0E11;
    border: none;
    padding: 10px 22px;
    border-radius: 10px;
    font-family: 'DM Sans', sans-serif;
    font-weight: 700;
    font-size: 0.85rem;
    cursor: pointer;
    transition: all 0.25s;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 6px;
    letter-spacing: 0.01em;
  }

  .btn-gold:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 30px rgba(212, 175, 55, 0.4);
  }

  .btn-outline {
    background: transparent;
    color: var(--gold);
    border: 1.5px solid var(--gold);
    padding: 10px 22px;
    border-radius: 10px;
    font-family: 'DM Sans', sans-serif;
    font-weight: 600;
    font-size: 0.85rem;
    cursor: pointer;
    transition: all 0.25s;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 6px;
  }

  .btn-outline:hover {
    background: rgba(212, 175, 55, 0.1);
    transform: translateY(-2px);
  }

  /* HERO */
  .hero {
    min-height: 100vh;
    padding: 20px 5% 20px;
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 60px;
    align-items: center;
    position: relative;
    overflow: hidden;
  }

  .hero::before {
    content: '';
    position: absolute;
    top: -200px; right: -200px;
    width: 700px; height: 700px;
    background: radial-gradient(circle, rgba(212, 175, 55, 0.08) 0%, transparent 70%);
    pointer-events: none;
  }

  .hero::after {
    content: '';
    position: absolute;
    bottom: -100px; left: -100px;
    width: 500px; height: 500px;
    background: radial-gradient(circle, rgba(212, 175, 55, 0.05) 0%, transparent 70%);
    pointer-events: none;
  }

  .hero-tag {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    background: rgba(212, 175, 55, 0.1);
    border: 1px solid rgba(212, 175, 55, 0.25);
    border-radius: 50px;
    padding: 6px 14px;
    font-size: 0.78rem;
    color: var(--gold-light);
    font-weight: 600;
    letter-spacing: 0.05em;
    text-transform: uppercase;
    margin-bottom: 24px;
    width: fit-content;
  }

  .live-dot {
    width: 7px; height: 7px;
    background: var(--green);
    border-radius: 50%;
    animation: pulse 1.5s infinite;
  }

  @keyframes pulse {
    0%, 100% { opacity: 1; transform: scale(1); }
    50% { opacity: 0.5; transform: scale(0.8); }
  }

  .hero h1 {
    font-family: 'DM Serif Display', serif;
    font-size: clamp(2.4rem, 4.5vw, 3.6rem);
    line-height: 1.1;
    letter-spacing: -0.03em;
    margin-bottom: 22px;
  }

  .hero h1 em {
    font-style: italic;
    background: var(--grad);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
  }

  .hero p {
    color: var(--muted);
    font-size: 1.05rem;
    max-width: 460px;
    margin-bottom: 36px;
    font-weight: 300;
    line-height: 1.7;
  }

  .hero-buttons {
    display: flex;
    gap: 14px;
    flex-wrap: wrap;
  }

  .hero-stats {
    display: flex;
    gap: 32px;
    margin-top: 50px;
    padding-top: 32px;
    border-top: 1px solid var(--border);
  }

  .hero-stat-val {
    font-family: 'DM Serif Display', serif;
    font-size: 1.6rem;
    background: var(--grad);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
  }

  .hero-stat-lbl {
    font-size: 0.78rem;
    color: var(--muted);
    font-weight: 500;
    text-transform: uppercase;
    letter-spacing: 0.06em;
    margin-top: 2px;
  }

  /* HERO VISUAL */
  .hero-visual {
    position: relative;
    z-index: 1;
  }

  .dashboard-card {
    background: var(--card);
    border: 1px solid var(--border);
    border-radius: 20px;
    padding: 24px;
    box-shadow: 0 40px 80px rgba(0,0,0,0.5);
    position: relative;
    overflow: hidden;
  }

  .dashboard-card::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 2px;
    background: var(--grad);
    border-radius: 20px 20px 0 0;
  }

  .dc-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
  }

  .dc-title { font-weight: 600; font-size: 0.95rem; }

  .dc-badge {
    background: rgba(34, 197, 94, 0.15);
    color: var(--green);
    border: 1px solid rgba(34, 197, 94, 0.3);
    padding: 3px 10px;
    border-radius: 20px;
    font-size: 0.72rem;
    font-weight: 700;
  }

  .chart-placeholder {
    height: 160px;
    position: relative;
    margin-bottom: 20px;
  }

  .chart-placeholder svg { width: 100%; height: 100%; }

  .dc-price {
    font-family: 'DM Serif Display', serif;
    font-size: 2.2rem;
    letter-spacing: -0.03em;
    margin-bottom: 4px;
  }

  .dc-change {
    color: var(--green);
    font-size: 0.85rem;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 4px;
  }

  .mini-cards {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 12px;
    margin-top: 16px;
  }

  .mini-card {
    background: rgba(255,255,255,0.03);
    border: 1px solid var(--border);
    border-radius: 12px;
    padding: 12px;
  }

  .mini-card-lbl {
    font-size: 0.72rem;
    color: var(--muted);
    font-weight: 500;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    margin-bottom: 4px;
  }

  .mini-card-val {
    font-weight: 700;
    font-size: 1.05rem;
  }

  /* .floating-badge {
    position: absolute;
    top: -16px;
    right: 30px;
    background: var(--card);
    border: 1px solid rgba(212, 175, 55, 0.3);
    border-radius: 12px;
    padding: 10px 16px;
    display: flex;
    align-items: center;
    gap: 10px;
    box-shadow: 0 20px 40px rgba(0,0,0,0.4);
  } */

  .fb-icon {
    width: 32px; height: 32px;
    background: var(--grad);
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 16px;
  }

  .fb-lbl { font-size: 0.75rem; color: var(--muted); }
  .fb-val { font-weight: 700; font-size: 0.9rem; color: var(--green); }

  /* SECTION SHARED */
  section { position: relative; z-index: 1; }
  .container { max-width: 1200px; margin: 0 auto; padding: 0 5%; }

  .section-tag {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    background: rgba(212, 175, 55, 0.08);
    border: 1px solid rgba(212, 175, 55, 0.2);
    border-radius: 50px;
    padding: 5px 14px;
    font-size: 0.73rem;
    color: var(--gold);
    font-weight: 700;
    letter-spacing: 0.08em;
    text-transform: uppercase;
    margin-bottom: 16px;
  }

  .section-title {
    font-family: 'DM Serif Display', serif;
    font-size: clamp(1.8rem, 3vw, 2.6rem);
    letter-spacing: -0.03em;
    line-height: 1.1;
    margin-bottom: 12px;
  }

  .section-sub {
    color: var(--muted);
    font-size: 1rem;
    max-width: 500px;
    font-weight: 300;
  }

  .live-rates {
    padding: 20px 0 80px;
    background: linear-gradient(180deg, transparent 0%, rgba(212,175,55,0.02) 50%, transparent 100%);
  }

  .section-header { margin-bottom: 48px; }

  .rates-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 24px;
    perspective: 1200px;
    transform-style: preserve-3d;
  }

  .rate-card {
    background: var(--card);
    border: 1px solid var(--border);
    border-radius: 20px;
    padding: 28px;
    position: relative;
    overflow: hidden;
    cursor: default;
    transition: box-shadow 0.35s ease, transform 0.35s ease;
    will-change: transform, opacity;
  }

  /* SHIMMER LIGHT SWEEP */
  .shimmer-sweep {
    position: absolute;
    top: 0; left: -150%;
    width: 100%; height: 100%;
    background: linear-gradient(
      120deg, 
      transparent 30%, 
      rgba(212, 175, 55, 0.1) 45%, 
      rgba(212, 175, 55, 0.2) 50%, 
      rgba(212, 175, 55, 0.1) 55%, 
      transparent 70%
    );
    pointer-events: none;
    z-index: 5;
  }

  /* PULSE ANIMATIONS */
  @keyframes goldGlow {
    0%, 100% { box-shadow: 0 0 0 rgba(212, 175, 55, 0); }
    50% { box-shadow: 0 0 20px rgba(212, 175, 55, 0.3); }
  }

  .pulse-gold {
    animation: goldGlow 2s infinite;
  }

  @keyframes badgePulse {
    0%, 100% { transform: scale(1); opacity: 1; }
    50% { transform: scale(1.05); opacity: 0.8; }
  }

  .rc-badge {
    animation: badgePulse 2.5s infinite ease-in-out;
  }

  /* PARTICLES BACKGROUND */
  .particles-container {
    position: absolute;
    top: 0; left: 0;
    width: 100%; height: 100%;
    overflow: hidden;
    pointer-events: none;
    z-index: 0;
  }

  .particle {
    position: absolute;
    width: 4px; height: 4px;
    background: var(--gold);
    border-radius: 50%;
    filter: blur(1px);
    opacity: 0.3;
  }

  .rate-card::after {
    content: '';
    position: absolute;
    inset: 0;
    border-radius: 20px;
    border: 1px solid transparent;
    background: var(--grad) border-box;
    -webkit-mask: linear-gradient(#fff 0 0) padding-box, linear-gradient(#fff 0 0);
    -webkit-mask-composite: destination-out;
    mask-composite: exclude;
    opacity: 0;
    transition: opacity 0.35s;
  }

  .rate-card:hover {
    transform: translateY(-8px) rotateX(2deg) rotateY(2deg);
    box-shadow: 0 30px 60px rgba(212, 175, 55, 0.2);
  }

  .rate-card:hover::after { opacity: 1; }

  .rate-card-glow {
    position: absolute;
    top: -60px; right: -60px;
    width: 160px; height: 160px;
    border-radius: 50%;
    opacity: 0;
    transition: opacity 0.35s;
    pointer-events: none;
  }

  .rate-card:hover .rate-card-glow { opacity: 1; }

  .gold-glow { background: radial-gradient(circle, rgba(212,175,55,0.12) 0%, transparent 70%); }
  .silver-glow { background: radial-gradient(circle, rgba(200,200,215,0.1) 0%, transparent 70%); }

  .rc-top {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 20px;
  }

  .rc-icon {
    width: 48px; height: 48px;
    border-radius: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 22px;
  }

  .rc-icon.gold { background: var(--grad); color: #000; }
  .rc-icon.silver { background: var(--silver-grad); color: #000; }

  .rc-badge {
    font-size: 0.72rem;
    font-weight: 700;
    padding: 4px 10px;
    border-radius: 20px;
  }

  .badge-up {
    background: rgba(34,197,94,0.12);
    color: var(--green);
    border: 1px solid rgba(34,197,94,0.25);
  }

  .badge-down {
    background: rgba(239,68,68,0.12);
    color: var(--red);
    border: 1px solid rgba(239,68,68,0.25);
  }

  .rc-metal { font-size: 0.8rem; color: var(--muted); font-weight: 600; letter-spacing: 0.05em; text-transform: uppercase; margin-bottom: 6px; }

  .rc-price {
    font-family: 'DM Serif Display', serif;
    font-size: 2rem;
    letter-spacing: -0.03em;
    margin-bottom: 6px;
  }

  .rc-change {
    font-size: 0.83rem;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 4px;
    margin-bottom: 20px;
  }

  .sparkline { width: 100%; height: 50px; }

  .rc-meta {
    display: flex;
    justify-content: space-between;
    margin-top: 14px;
    padding-top: 14px;
    border-top: 1px solid var(--border);
  }

  .rc-meta-item { font-size: 0.75rem; }
  .rc-meta-label { color: var(--muted); font-weight: 500; margin-bottom: 2px; }
  .rc-meta-val { font-weight: 700; }

  /* CHART SECTION */
  .chart-section { padding: 80px 0; }

  .chart-wrap {
    background: var(--card);
    border: 1px solid var(--border);
    border-radius: 24px;
    overflow: hidden;
    box-shadow: 0 40px 80px rgba(0,0,0,0.3);
  }

  .chart-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 28px 32px;
    border-bottom: 1px solid var(--border);
  }

  .chart-title-wrap { }
  .chart-title { font-weight: 700; font-size: 1.1rem; margin-bottom: 2px; }
  .chart-subtitle { color: var(--muted); font-size: 0.8rem; }

  .time-filters {
    display: flex;
    gap: 4px;
    background: rgba(255,255,255,0.04);
    border: 1px solid var(--border);
    border-radius: 12px;
    padding: 4px;
  }

  .tf-btn {
    background: transparent;
    color: var(--muted);
    border: none;
    padding: 7px 16px;
    border-radius: 8px;
    font-family: 'DM Sans', sans-serif;
    font-size: 0.8rem;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.2s;
  }

  .tf-btn.active, .tf-btn:hover {
    background: var(--grad);
    color: #0B0E11;
  }

  .chart-price-display {
    padding: 20px 32px 10px;
    display: flex;
    align-items: baseline;
    gap: 14px;
  }

  .cdp-price {
    font-family: 'DM Serif Display', serif;
    font-size: 2.4rem;
    letter-spacing: -0.04em;
  }

  .cdp-change { color: var(--green); font-weight: 700; font-size: 1rem; }
  .cdp-time { color: var(--muted); font-size: 0.8rem; margin-left: auto; }

  .chart-body {
    padding: 10px 20px 28px;
    height: 280px;
    position: relative;
  }

  #mainChart { width: 100%; height: 100%; }

  .tooltip-box {
    position: absolute;
    background: rgba(22, 26, 35, 0.95);
    border: 1px solid rgba(212,175,55,0.3);
    border-radius: 10px;
    padding: 10px 14px;
    pointer-events: none;
    font-size: 0.78rem;
    box-shadow: 0 8px 24px rgba(0,0,0,0.5);
    display: none;
    z-index: 10;
  }

  .tooltip-price { font-weight: 700; font-size: 0.95rem; margin-bottom: 4px; }
  .tooltip-change { color: var(--green); font-weight: 600; }
  .tooltip-time { color: var(--muted); margin-top: 2px; }

  .market-stats { 
    padding: 120px 0; 
    perspective: 2000px;
    overflow: visible;
  }

  .stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
    gap: 30px;
    position: relative;
    transform-style: preserve-3d;
  }

  .stat-card {
    background: var(--card);
    border: 1px solid var(--border);
    border-radius: 20px;
    padding: 28px;
    transition: box-shadow 0.35s ease;
    cursor: default;
    position: relative;
    transform-style: preserve-3d;
    will-change: transform, opacity;
  }

  .stat-card:hover {
    border-color: rgba(212,175,55,0.4);
    box-shadow: 0 20px 50px rgba(0,0,0,0.3);
  }

  .stat-icon {
    width: 42px; height: 42px;
    border-radius: 12px;
    background: rgba(212,175,55,0.1);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 18px;
    margin-bottom: 16px;
  }

  .stat-label { font-size: 0.78rem; color: var(--muted); font-weight: 600; text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 6px; }

  .stat-value {
    font-family: 'DM Serif Display', serif;
    font-size: 1.8rem;
    letter-spacing: -0.03em;
    margin-bottom: 6px;
  }

  .stat-trend {
    display: flex;
    align-items: center;
    gap: 6px;
    font-size: 0.8rem;
    font-weight: 600;
  }

  .trend-up { color: var(--green); }
  .trend-down { color: var(--red); }

  /* WHY USE */
  .why-section {
    padding: 80px 0;
    background: linear-gradient(180deg, transparent 0%, rgba(212,175,55,0.025) 50%, transparent 100%);
  }

  .why-grid {
    display: grid;
    grid-template-columns: 1.2fr 1fr;
    gap: 80px;
    align-items: center;
  }

  .feature-list {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
    margin-top: 40px;
  }

  /* 2x1x2 Grid implementation */
  .feature-item:nth-child(3) {
    grid-column: span 2;
  }

  .feature-item {
    display: flex;
    gap: 16px;
    align-items: flex-start;
    padding: 24px;
    background: var(--card);
    border: 1px solid var(--border);
    border-radius: 14px;
    transition: all 0.3s;
    cursor: default;
    height: 100%;
  }

  .feature-item:hover {
    border-color: rgba(212,175,55,0.25);
    background: rgba(22,26,35,0.8);
    transform: translateY(-5px);
  }

  .fi-icon {
    width: 44px; height: 44px;
    border-radius: 12px;
    background: var(--grad);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px;
    flex-shrink: 0;
  }

  .fi-title { font-weight: 700; font-size: 0.95rem; margin-bottom: 6px; }
  .fi-desc { color: var(--muted); font-size: 0.82rem; line-height: 1.6; }

  .why-visual {
    position: relative;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .app-mockup {
    background: var(--card);
    border: 1px solid rgba(212,175,55,0.2);
    border-radius: 40px;
    padding: 28px;
    box-shadow: 0 50px 100px rgba(0,0,0,0.6), 0 0 0 1px rgba(212,175,55,0.1);
    width: 100%;
    max-width: 400px;
    aspect-ratio: 9 / 18.5;
    margin: 0 auto;
    position: relative;
  }

  .app-screen {
    background: #0B0E11;
    border-radius: 30px;
    padding: 30px;
    height: 100%;
    display: flex;
    flex-direction: column;
    overflow: hidden;
  }

  .app-notch {
    width: 80px; height: 6px;
    background: var(--border);
    border-radius: 3px;
    margin: 0 auto 30px;
    flex-shrink: 0;
  }

  .app-header { font-size: 0.8rem; color: var(--muted); margin-bottom: 24px; font-weight: 600; letter-spacing: 0.06em; text-transform: uppercase; }

  .app-price-big {
    font-family: 'DM Serif Display', serif;
    font-size: 2.8rem;
    letter-spacing: -0.04em;
    margin-bottom: 8px;
  }

  .app-change { color: var(--green); font-size: 1rem; font-weight: 600; margin-bottom: 30px; }

  .app-chart-mini {
    height: 100px;
    margin-bottom: 35px;
  }

  .app-actions {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 15px;
    margin-bottom: 25px;
  }

  .app-btn-buy {
    background: var(--grad);
    color: #0B0E11;
    border: none;
    padding: 14px;
    border-radius: 12px;
    font-weight: 700;
    font-size: 0.85rem;
    cursor: pointer;
    font-family: 'DM Sans', sans-serif;
  }

  .app-btn-sell {
    background: rgba(239,68,68,0.15);
    color: var(--red);
    border: 1px solid rgba(239,68,68,0.3);
    padding: 14px;
    border-radius: 12px;
    font-weight: 700;
    font-size: 0.85rem;
    cursor: pointer;
    font-family: 'DM Sans', sans-serif;
  }

  .app-mini-stats {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 12px;
    margin-top: auto;
  }

  .ams-item {
    background: rgba(255,255,255,0.03);
    border: 1px solid var(--border);
    border-radius: 12px;
    padding: 14px;
  }

  .ams-lbl { font-size: 0.7rem; color: var(--muted); font-weight: 600; text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 4px; }
  .ams-val { font-weight: 700; font-size: 1rem; }

  /* DOWNLOAD SECTION */
  .download-section {
    padding: 80px 0;
  }

  .download-card {
    background: var(--card);
    border: 1px solid rgba(212,175,55,0.2);
    border-radius: 28px;
    padding: 60px;
    text-align: center;
    position: relative;
    overflow: hidden;
  }

  .download-card::before {
    content: '';
    position: absolute;
    top: -200px; left: 50%;
    transform: translateX(-50%);
    width: 600px; height: 400px;
    background: radial-gradient(ellipse, rgba(212,175,55,0.1) 0%, transparent 70%);
    pointer-events: none;
  }

  .download-card h2 {
    font-family: 'DM Serif Display', serif;
    font-size: clamp(2rem, 3.5vw, 3rem);
    letter-spacing: -0.03em;
    margin-bottom: 16px;
  }

  .download-card h2 em {
    font-style: italic;
    background: var(--grad);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
  }

  .download-card p {
    color: var(--muted);
    font-size: 1rem;
    max-width: 480px;
    margin: 0 auto 40px;
    font-weight: 300;
    line-height: 1.7;
  }

  .store-buttons {
    display: flex;
    gap: 16px;
    justify-content: center;
    flex-wrap: wrap;
  }

  .store-btn {
    display: flex;
    align-items: center;
    gap: 12px;
    background: rgba(255,255,255,0.05);
    border: 1.5px solid var(--border);
    border-radius: 14px;
    padding: 14px 24px;
    cursor: pointer;
    transition: all 0.3s;
    text-decoration: none;
    color: var(--text);
  }

  .store-btn:hover {
    border-color: var(--gold);
    background: rgba(212,175,55,0.08);
    transform: translateY(-3px);
    box-shadow: 0 12px 30px rgba(212,175,55,0.15);
  }

  .store-btn-icon { font-size: 28px; }
  .store-btn-sub { font-size: 0.68rem; color: var(--muted); font-weight: 500; text-transform: uppercase; letter-spacing: 0.06em; }
  .store-btn-name { font-weight: 700; font-size: 1rem; }

  /* INSIGHTS */
  .insights-section { padding: 80px 0; }

  .insights-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 24px;
    margin-top: 48px;
  }

  .insight-card {
    background: var(--card);
    border: 1px solid var(--border);
    border-radius: 20px;
    overflow: hidden;
    transition: all 0.3s;
    cursor: pointer;
  }

  .insight-card:hover {
    border-color: rgba(212,175,55,0.25);
    transform: translateY(-4px);
    box-shadow: 0 16px 50px rgba(0,0,0,0.3);
  }

  .insight-preview {
    height: 140px;
    position: relative;
    overflow: hidden;
  }

  .insight-card:nth-child(1) .insight-preview {
    background: linear-gradient(135deg, rgba(212,175,55,0.15) 0%, rgba(246,211,101,0.08) 100%);
  }
  .insight-card:nth-child(2) .insight-preview {
    background: linear-gradient(135deg, rgba(180,180,200,0.12) 0%, rgba(150,150,170,0.06) 100%);
  }
  .insight-card:nth-child(3) .insight-preview {
    background: linear-gradient(135deg, rgba(34,197,94,0.12) 0%, rgba(0,200,100,0.06) 100%);
  }

  .insight-preview-icon {
    position: absolute;
    top: 50%; left: 50%;
    transform: translate(-50%, -50%);
    font-size: 52px;
    opacity: 0.4;
  }

  .insight-body { padding: 24px; }

  .insight-tag {
    font-size: 0.68rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.08em;
    color: var(--gold);
    background: rgba(212,175,55,0.08);
    padding: 3px 10px;
    border-radius: 20px;
    display: inline-block;
    margin-bottom: 10px;
  }

  .insight-title {
    font-weight: 700;
    font-size: 1.0rem;
    line-height: 1.3;
    margin-bottom: 10px;
  }

  .insight-desc { color: var(--muted); font-size: 0.82rem; line-height: 1.6; margin-bottom: 16px; }

  .read-more {
    color: var(--gold);
    font-size: 0.8rem;
    font-weight: 700;
    text-decoration: none;
    display: flex;
    align-items: center;
    gap: 6px;
    transition: gap 0.2s;
  }

  .read-more:hover { gap: 10px; }

  /* FOOTER */
  footer {
    background: rgba(22, 26, 35, 0.8);
    border-top: 1px solid var(--border);
    padding: 60px 5% 30px;
  }

  .footer-grid {
    display: grid;
    grid-template-columns: 2fr repeat(3, 1fr);
    gap: 48px;
    margin-bottom: 48px;
  }

  .footer-brand .logo-text { display: block; font-size: 1.4rem; margin-bottom: 12px; }
  .footer-brand p { color: var(--muted); font-size: 0.83rem; line-height: 1.7; max-width: 260px; }

  .footer-col-title {
    font-weight: 700;
    font-size: 0.8rem;
    text-transform: uppercase;
    letter-spacing: 0.08em;
    color: var(--muted);
    margin-bottom: 18px;
  }

  .footer-links { list-style: none; display: flex; flex-direction: column; gap: 10px; }
  .footer-links a { color: var(--muted); text-decoration: none; font-size: 0.85rem; transition: color 0.2s; }
  .footer-links a:hover { color: var(--text); }

  .footer-bottom {
    border-top: 1px solid var(--border);
    padding-top: 28px;
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    flex-wrap: wrap;
    gap: 16px;
  }

  .footer-disclaimer {
    font-size: 0.75rem;
    color: var(--muted);
    max-width: 600px;
    line-height: 1.6;
  }

  .footer-copy {
    font-size: 0.75rem;
    color: var(--muted);
    white-space: nowrap;
  }

  /* TICKER */
  .ticker-wrap {
    background: rgba(212,175,55,0.05);
    border-top: 1px solid rgba(212,175,55,0.1);
    border-bottom: 1px solid rgba(212,175,55,0.1);
    overflow: hidden;
    padding: 10px 0;
  }

  .ticker-inner {
    display: flex;
    gap: 0;
    animation: ticker 40s linear infinite;
    width: max-content;
  }

  .ticker-inner:hover { animation-play-state: paused; }

  @keyframes ticker {
    0% { transform: translateX(0); }
    100% { transform: translateX(-50%); }
  }

  .ticker-item {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 0 32px;
    border-right: 1px solid var(--border);
    white-space: nowrap;
    font-size: 0.8rem;
    font-weight: 600;
  }

  .ticker-name { color: var(--muted); font-size: 0.72rem; text-transform: uppercase; letter-spacing: 0.05em; }
  .ticker-price { font-weight: 700; }
  .ticker-chg-up { color: var(--green); font-size: 0.75rem; }
  .ticker-chg-dn { color: var(--red); font-size: 0.75rem; }

  /* ANIMATIONS */
  @keyframes fadeInUp {
    from { opacity: 0; transform: translateY(30px); }
    to { opacity: 1; transform: translateY(0); }
  }

  @keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
  }

  @keyframes slideInLeft {
    from { opacity: 0; transform: translateX(-60px); }
    to { opacity: 1; transform: translateX(0); }
  }

  @keyframes slideInRight {
    from { opacity: 0; transform: translateX(200px); }
    to { opacity: 1; transform: translateX(0); }
  }

  .anim { opacity: 0; animation: fadeInUp 2.7s ease forwards; }
  .anim-left { opacity: 0; animation: slideInLeft 3.5s cubic-bezier(0.2, 0.8, 0.2, 1) forwards; }
  .anim-right { opacity: 0; animation: slideInRight 3.5s cubic-bezier(0.2, 0.8, 0.2, 1) forwards; }
  .anim-d1 { animation-delay: 0.1s; }
  .anim-d2 { animation-delay: 0.2s; }
  .anim-d3 { animation-delay: 0.3s; }
  .anim-d4 { animation-delay: 0.4s; }
  .anim-d5 { animation-delay: 0.5s; }

  /* RESPONSIVE */
  @media (max-width: 1024px) {
    .hero { grid-template-columns: 1fr; gap: 48px; border-top: 1px solid var(--border); }
    .why-grid { grid-template-columns: 1fr; gap: 24px; }
    .footer-grid { grid-template-columns: 1fr 1fr; }
    .nav-links { display: none; }
  }

  @media (max-width: 768px) {
    .rb-spotlight { grid-template-columns: 1fr 1fr; }
    .rb-spot-item:last-child { grid-column: span 2; border-right: none; border-top: 1px solid #333; }
    .rb-table-header, .rb-cost-row { grid-template-columns: 1.5fr 1fr 1fr; padding: 12px 10px; }
    .rb-prod-price, .rb-cost-val { font-size: 1.1rem; }
    .rb-prod-name, .rb-cost-prod { font-size: 0.85rem; }
    .ticker-item { padding: 0 15px; }
    .feature-list { grid-template-columns: 1fr; }
    .feature-item:nth-child(3) { grid-column: span 1; }
  }

  @media (max-width: 640px) {
    .hero { padding: 100px 5% 60px; }
    .download-card { padding: 40px 24px; }
    .footer-grid { grid-template-columns: 1fr; gap: 32px; }
    .footer-bottom { flex-direction: column; align-items: center; text-align: center; }
    .chart-header { flex-direction: column; gap: 16px; align-items: flex-start; }
    .hero-stats { flex-direction: column; gap: 24px; align-items: flex-start; }
    .rb-table-header { display: none; }
    .rb-cost-row { 
      grid-template-columns: 1fr 1fr; 
      gap: 10px; 
      padding: 15px;
    }
    .rb-cost-prod { grid-column: span 2; border-bottom: 1px solid rgba(255,255,255,0.05); padding-bottom: 8px; margin-bottom: 5px; }
    .rb-cost-val-wrap:nth-child(2) { text-align: left; }
    .rb-cost-val-wrap:nth-child(2)::before { content: 'BID '; font-size: 0.65rem; color: var(--muted); display: block; }
    .rb-cost-val-wrap:nth-child(3) { text-align: right; }
    .rb-cost-val-wrap:nth-child(3)::before { content: 'ASK '; font-size: 0.65rem; color: var(--muted); display: block; }
  }

  @media (max-width: 480px) {
    .loader-text { font-size: 1.8rem; }
    .nav-logo .logo-text { font-size: 1.0rem; }
    .nav-logo .logo-icon { width: 30px; height: 30px; font-size: 14px; }
    nav { padding: 0 10px; }
    .btn-gold, .btn-outline { padding: 6px 10px; font-size: 0.7rem; }
    .rb-spot-value { font-size: 1.1rem; }
    .dc-price { font-size: 1.6rem; }
    .hero h1 { font-size: 1.8rem; }
    .hero-stat-val { font-size: 1.3rem; }
    .dc-btns { flex-direction: column; gap: 16px; }
  }

  /* PRELOADER */
  #preloader {
    position: fixed;
    inset: 0;
    background: #0B0E11;
    z-index: 99999;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 20px;
  }

  .loader-logo {
    font-size: 50px;
    animation: loaderPulse 1.5s infinite ease-in-out;
  }

  @keyframes loaderPulse {
    0%, 100% { transform: scale(1); opacity: 0.8; }
    50% { transform: scale(1.15); opacity: 1; filter: drop-shadow(0 0 15px var(--gold)); }
  }

  .loader-text {
    font-family: 'DM Serif Display', serif;
    font-size: 2.5rem;
    letter-spacing: -0.02em;
    background: linear-gradient(90deg, #D4AF37, #F6D365, #D4AF37);
    background-size: 200% auto;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    animation: loaderShimmer 2s linear infinite;
  }

  @keyframes loaderShimmer {
    to { background-position: 200% center; }
  }

  .loader-bar-wrap {
    width: 200px;
    height: 2px;
    background: rgba(255,255,255,0.05);
    border-radius: 2px;
    overflow: hidden;
  }

  .loader-bar {
    width: 100%;
    height: 100%;
    background: var(--grad);
    transform: translateX(-100%);
  }

  .crosshair-line {
    position: absolute;
    top: 0;
    bottom: 0;
    width: 1px;
    background: rgba(212,175,55,0.4);
    pointer-events: none;
    display: none;
  }
</style>
</head>
<body>

<!-- PRELOADER -->
<div id="preloader">
  <div class="loader-logo">🪙</div>
  <div class="loader-text">MetalPulse</div>
  <div class="loader-bar-wrap">
    <div class="loader-bar"></div>
  </div>
</div>

<!-- NAVBAR -->
<nav style="top:0;">
  <a href="#" class="nav-logo">
    <div class="logo-icon">🪙</div>
    <span class="logo-text">MetalPulse</span>
  </a>
  <ul class="nav-links">
    <li><a href="#chart">Bars</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#download">Trades</a></li>
  </ul>
  <div style="display:flex;gap:10px;">
    <a href="javascript:void(0)" class="btn-gold" style="padding: 8px 14px; font-size: 0.75rem;">Android</a>
    <a href="javascript:void(0)" class="btn-outline" style="padding: 8px 14px; font-size: 0.75rem;">iOS</a>
  </div>
</nav>

<!-- ALERT MARQUEE -->
<div class="alert-marquee" style="margin-top:70px;">
  <div class="alert-inner">
    <span class="alert-item">⚠️ Payment should be done on or before given date. Otherwise it will be squared off as per market rates.</span>
    <span class="alert-item">⚠️ Silver delivery and dispatch charges extra for each delivery.</span>
    <span class="alert-item">⚠️ RTGS/NEFT must be done from same bank account as registered.</span>
  </div>
</div>

<!-- TICKER -->
<div class="ticker-wrap">
  <div class="ticker-inner" id="tickerInner"></div>
</div>

<!-- HERO -->
<section class="hero" id="home">
  <div class="hero-content anim-left">
    <div class="hero-tag anim anim-d1">
      <span class="live-dot"></span>
      Live Market Data
    </div>
    <h1 class="anim anim-d2">
      Welcome to <em>MetalPulse</em><br>Premium Bullion Rates
    </h1>
    <p class="anim anim-d3">Leading Bullion Dealer in Ahmedabad and Rajkot. Track real-time gold and silver prices with professional accuracy.</p>
    <div class="hero-buttons anim anim-d4">
      <a href="#download" class="btn-gold">📱 Download Mobile App</a>
      <a href="#rates" class="btn-outline">📊 View Live Rates</a>
    </div>
    <div class="hero-stats anim anim-d5">
      <div>
        <div class="hero-stat-val">₹72,450</div>
        <div class="hero-stat-lbl">Gold 24K / 10g</div>
      </div>
      <div>
        <div class="hero-stat-val">₹84,200</div>
        <div class="hero-stat-lbl">Silver / kg</div>
      </div>
      <div>
        <div class="hero-stat-val">+1.4%</div>
        <div class="hero-stat-lbl">Today's Change</div>
      </div>
    </div>
  </div>

  <div class="hero-visual anim-right">
    <div style="position:relative;">
      <!-- <div class="floating-badge">
        <div class="fb-icon">📈</div>
        <div>
          <div class="fb-lbl">Gold Today</div>
          <div class="fb-val">▲ +1.45%</div>
        </div>
      </div> -->
      <div class="dashboard-card">
        <div class="dc-header">
          <span class="dc-title">MCX Gold Performance</span>
          <span class="dc-badge">● LIVE</span>
        </div>
        <div class="chart-placeholder">
          <svg viewBox="0 0 400 160" preserveAspectRatio="none">
            <defs>
              <linearGradient id="heroGrad" x1="0" y1="0" x2="0" y2="1">
                <stop offset="0%" stop-color="#D4AF37" stop-opacity="0.3"/>
                <stop offset="100%" stop-color="#D4AF37" stop-opacity="0"/>
              </linearGradient>
            </defs>
            <path d="M0,120 C20,115 30,100 50,90 S80,70 100,75 S130,85 150,70 S180,45 210,40 S240,55 260,50 S290,30 320,25 S360,35 400,20" fill="none" stroke="#D4AF37" stroke-width="2.5" stroke-linecap="round"/>
            <path d="M0,120 C20,115 30,100 50,90 S80,70 100,75 S130,85 150,70 S180,45 210,40 S240,55 260,50 S290,30 320,25 S360,35 400,20 L400,160 L0,160 Z" fill="url(#heroGrad)"/>
          </svg>
        </div>
        <div class="dc-price">₹72,450</div>
        <div class="dc-change">▲ +₹1,036 <span style="color:var(--muted);font-weight:400;">(+1.45% today)</span></div>
        <div class="mini-cards">
          <div class="mini-card">
            <div class="mini-card-lbl">24K Gold</div>
            <div class="mini-card-val">₹72,450</div>
          </div>
          <div class="mini-card">
            <div class="mini-card-lbl">22K Gold</div>
            <div class="mini-card-val">₹66,413</div>
          </div>
          <div class="mini-card">
            <div class="mini-card-lbl">Silver</div>
            <div class="mini-card-val">₹84,200</div>
          </div>
          <div class="mini-card">
            <div class="mini-card-lbl">MCX Rate</div>
            <div class="mini-card-val" style="color:var(--green)">+0.92%</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- LIVE RATES -->
<section class="live-rates" id="rates">
  <div class="particles-container" id="particlesContainer"></div>
  <div class="container">
    <div class="section-header">
      <div class="section-tag">🔴 Live Prices</div>
      <h2 class="section-title">MetalPulse Live Rates</h2>
      <p class="section-sub">Live gold, silver, and coin prices updated every second.</p>
    </div>
    <div class="rates-board">
      <!-- Tabs -->
      <div class="rb-tabs">
        <div class="rb-tab active" onclick="switchTab('GOLD', this)">GOLD RATES</div>
        <div class="rb-tab" onclick="switchTab('SILVER', this)">SILVER RATES</div>
      </div>

      <!-- Spotlight Spot Rates -->
      <div class="rb-spotlight">
        <div class="rb-spot-item">
          <div class="rb-spot-label">GOLD</div>
          <div class="rb-spot-value" id="spotGold">0.00</div>
        </div>
        <div class="rb-spot-item">
          <div class="rb-spot-label">SILVER</div>
          <div class="rb-spot-value" id="spotSilver">0.00</div>
        </div>
        <div class="rb-spot-item">
          <div class="rb-spot-label">INR</div>
          <div class="rb-spot-value" id="spotINR">0.00</div>
        </div>
      </div>

      <!-- Product List (Dynamic) -->
      <div class="rb-product-list" id="ratesList">
        <!-- Rows will be injected by JS -->
      </div>

      <!-- Costing Table Header -->
      <div class="rb-table-header">
        <div class="rb-th">Product</div>
        <div class="rb-th center">Bid</div>
        <div class="rb-th center">Ask</div>
      </div>

      <!-- Costing Rows (Dynamic) -->
      <div id="costingRows">
        <!-- Rows will be injected by JS -->
      </div>
    </div>
  </div>
</section>

<!-- CHART SECTION -->
<section class="chart-section" id="chart">
  <div class="container">
    <div class="section-header">
      <div class="section-tag">📈 Analytics</div>
      <h2 class="section-title">Market Performance</h2>
    </div>
    <div class="chart-wrap">
      <div class="chart-header">
        <div class="chart-title-wrap">
          <div class="chart-title">Gold Market Performance — MCX</div>
          <div class="chart-subtitle">Historical price data with real-time updates</div>
        </div>
        <div class="time-filters">
          <button class="tf-btn active" onclick="switchChart('1D',this)">1D</button>
          <button class="tf-btn" onclick="switchChart('1W',this)">1W</button>
          <button class="tf-btn" onclick="switchChart('1M',this)">1M</button>
          <button class="tf-btn" onclick="switchChart('1Y',this)">1Y</button>
        </div>
      </div>
      <div class="chart-price-display">
        <div class="cdp-price" id="cdpPrice">₹72,450</div>
        <div class="cdp-change" id="cdpChange">▲ +1.45%</div>
        <div class="cdp-time" id="cdpTime">Today, 3:30 PM IST</div>
      </div>
      <div class="chart-body">
        <canvas id="mainChart"></canvas>
        <div class="crosshair-line" id="crosshairLine"></div>
        <div class="tooltip-box" id="tooltipBox">
          <div class="tooltip-price" id="ttPrice">₹72,450</div>
          <div class="tooltip-change" id="ttChange">▲ +1.45%</div>
          <div class="tooltip-time" id="ttTime">3:30 PM</div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- MARKET STATS -->
<section class="market-stats" id="stats">
  <div class="container">
    <div class="section-header">
      <div class="section-tag">📊 Statistics</div>
      <h2 class="section-title">Market Statistics</h2>
      <p class="section-sub">Comprehensive MCX market data and analytics at a glance.</p>
    </div>
    <div class="stats-grid" id="statsGrid">
      <div class="stat-card" data-final="72450">
        <div class="stat-icon">🥇</div>
        <div class="stat-label">Gold MCX Price</div>
        <div class="stat-value">₹0</div>
        <div class="stat-trend trend-up">▲ +1.45% today</div>
      </div>
      <div class="stat-card" data-final="84200">
        <div class="stat-icon">🥈</div>
        <div class="stat-label">Silver MCX Price</div>
        <div class="stat-value">₹0</div>
        <div class="stat-trend trend-up">▲ +0.92% today</div>
      </div>
      <div class="stat-card" data-final="7245">
        <div class="stat-icon">✨</div>
        <div class="stat-label">24K Gold Rate Today</div>
        <div class="stat-value">₹0</div>
        <div class="stat-trend trend-up">▲ +₹103 per gram</div>
      </div>
      <div class="stat-card" data-final="84.20">
        <div class="stat-icon">💎</div>
        <div class="stat-label">Silver Rate Today</div>
        <div class="stat-value">₹0</div>
        <div class="stat-trend trend-up">▲ +₹0.77 per gram</div>
      </div>
      <div class="stat-card" data-final="75890">
        <div class="stat-icon">📅</div>
        <div class="stat-label">52-Week High (Gold)</div>
        <div class="stat-value">₹0</div>
        <div class="stat-trend trend-down">▼ 4.5% from high</div>
      </div>
      <div class="stat-card" data-final="58200">
        <div class="stat-icon">📉</div>
        <div class="stat-label">52-Week Low (Gold)</div>
        <div class="stat-value">₹0</div>
        <div class="stat-trend trend-up">▲ 24.4% from low</div>
      </div>
      <div class="stat-card" data-final="83.45">
        <div class="stat-icon">🌐</div>
        <div class="stat-label">USD/INR Rate</div>
        <div class="stat-value">₹0</div>
        <div class="stat-trend trend-down">▼ -0.12% today</div>
      </div>
      <div class="stat-card" data-final="86.04">
        <div class="stat-icon">🔁</div>
        <div class="stat-label">Gold/Silver Ratio</div>
        <div class="stat-value">0</div>
        <div class="stat-trend" style="color:var(--muted)">Neutral zone</div>
      </div>
    </div>
  </div>
</section>

<!-- WHY USE -->
<section class="why-section" id="about">
  <div class="container">
    <div class="why-grid">
      <div>
        <div class="section-tag">📱 Mobile App</div>
        <h2 class="section-title">Why Trade Using Our Mobile App</h2>
        <p class="section-sub">Professional-grade tools packed into a sleek mobile experience designed for serious investors.</p>
        <div class="feature-list">
          <div class="feature-item">
            <div class="fi-icon">⚡</div>
            <div>
              <div class="fi-title">Real-time MCX Market Price Updates</div>
              <div class="fi-desc">Sub-second price feeds directly from MCX exchanges with zero latency alerts.</div>
            </div>
          </div>
          <div class="feature-item">
            <div class="fi-icon">🔒</div>
            <div>
              <div class="fi-title">Secure Gold & Silver Trading</div>
              <div class="fi-desc">Bank-grade 256-bit encryption with biometric authentication for every transaction.</div>
            </div>
          </div>
          <div class="feature-item">
            <div class="fi-icon">📊</div>
            <div>
              <div class="fi-title">Live Charts & Market Analytics</div>
              <div class="fi-desc">Professional charting tools with 20+ technical indicators and pattern recognition.</div>
            </div>
          </div>
          <div class="feature-item">
            <div class="fi-icon">💰</div>
            <div>
              <div class="fi-title">Instant Buy & Sell Options</div>
              <div class="fi-desc">Execute trades in milliseconds with one-tap order placement and instant confirmations.</div>
            </div>
          </div>
          <div class="feature-item">
            <div class="fi-icon">📱</div>
            <div>
              <div class="fi-title">Easy Mobile Trading Experience</div>
              <div class="fi-desc">Intuitive interface designed for both beginners and seasoned gold investors.</div>
            </div>
          </div>
        </div>
      </div>

      <div class="why-visual">
        <div class="app-mockup">
          <div class="app-screen">
            <div class="app-notch"></div>
            <div class="app-header">MCX Gold — Live</div>
            <div class="app-price-big">₹72,450</div>
            <div class="app-change">▲ +₹1,036 (+1.45%)</div>
            <div class="app-chart-mini">
              <svg viewBox="0 0 280 70" preserveAspectRatio="none" style="width:100%;height:100%">
                <defs>
                  <linearGradient id="appGrad" x1="0" y1="0" x2="0" y2="1">
                    <stop offset="0%" stop-color="#D4AF37" stop-opacity="0.25"/>
                    <stop offset="100%" stop-color="#D4AF37" stop-opacity="0"/>
                  </linearGradient>
                </defs>
                <path d="M0,50 C20,45 30,40 50,38 S80,30 100,28 S130,35 150,28 S180,15 210,12 S250,18 280,10" fill="none" stroke="#D4AF37" stroke-width="2" stroke-linecap="round"/>
                <path d="M0,50 C20,45 30,40 50,38 S80,30 100,28 S130,35 150,28 S180,15 210,12 S250,18 280,10 L280,70 L0,70 Z" fill="url(#appGrad)"/>
              </svg>
            </div>
            <div class="app-actions">
              <button class="app-btn-buy">BUY GOLD</button>
              <button class="app-btn-sell">SELL GOLD</button>
            </div>
            <div class="app-mini-stats">
              <div class="ams-item">
                <div class="ams-lbl">Open</div>
                <div class="ams-val">₹71,414</div>
              </div>
              <div class="ams-item">
                <div class="ams-lbl">High</div>
                <div class="ams-val" style="color:var(--green)">₹72,890</div>
              </div>
              <div class="ams-item">
                <div class="ams-lbl">Low</div>
                <div class="ams-val" style="color:var(--red)">₹71,200</div>
              </div>
              <div class="ams-item">
                <div class="ams-lbl">Volume</div>
                <div class="ams-val">42.8K</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- DOWNLOAD -->
<section class="download-section" id="download">
  <div class="container">
    <div class="download-card">
      <div class="section-tag" style="margin:0 auto 20px;">🚀 Available Now</div>
      <h2>Trade <em>Gold & Silver</em> Anytime</h2>
      <p>Download our MCX trading mobile app to securely buy and sell gold and silver with real-time market data, advanced charts, and instant execution.</p>
      <div class="store-buttons">
        <a href="#" class="store-btn">
          <div class="store-btn-icon">▶</div>
          <div>
            <div class="store-btn-sub">Get it on</div>
            <div class="store-btn-name">Google Play</div>
          </div>
        </a>
        <a href="#" class="store-btn">
          <div class="store-btn-icon">🍎</div>
          <div>
            <div class="store-btn-sub">Download on the</div>
            <div class="store-btn-name">App Store</div>
          </div>
        </a>
      </div>
    </div>
  </div>
</section>

<!-- CONTACT / ABOUT -->
<section class="insights-section" id="contact">
  <div class="container">
    <div class="section-header">
      <div class="section-tag">� Contact Us</div>
      <h2 class="section-title">Get in Touch with MetalPulse</h2>
      <p class="section-sub">Expert assistance for all your gold and silver trading needs.</p>
    </div>
    <div class="insights-grid">
      <div class="insight-card">
        <div class="insight-preview">
          <div class="insight-preview-icon">👤</div>
        </div>
        <div class="insight-body">
          <div class="insight-tag">Contact Person</div>
          <div class="insight-title">Mr. Pratik Soni</div>
          <div class="insight-desc">Managing Director at MetalPulse. Expertise in Bullion Market.</div>
          <a href="tel:+919825677940" class="read-more">+91 9825677940 →</a>
        </div>
      </div>
      <div class="insight-card">
        <div class="insight-preview">
          <div class="insight-preview-icon">📧</div>
        </div>
        <div class="insight-body">
          <div class="insight-tag">Support E-mail</div>
          <div class="insight-title">Online Assistance</div>
          <div class="insight-desc">For any queries related to rates, delivery, or account status.</div>
          <a href="mailto:aaravbullion9@gmail.com" class="read-more">aaravbullion9@gmail.com →</a>
        </div>
      </div>
      <div class="insight-card">
        <div class="insight-preview">
          <div class="insight-preview-icon">�</div>
        </div>
        <div class="insight-body">
          <div class="insight-tag">Locations</div>
          <div class="insight-title">AHMEDABAD & RAJKOT</div>
          <div class="insight-desc">Head Office: AHMEDABAD<br>Branch Office: RAJKOT</div>
          <a href="#" class="read-more">View on Map →</a>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- FOOTER -->
<footer>
  <div class="footer-grid">
    <div class="footer-brand">
      <div class="nav-logo" style="margin-bottom:14px;display:flex;align-items:center;gap:10px;">
        <div class="logo-icon">🪙</div>
        <span class="logo-text">MetalPulse</span>
      </div>
      <p>India's most trusted platform for live bullion rates and spot market data. Committed to transparency and excellence since 2017.</p>
    </div>
    <div>
      <div class="footer-col-title">Navigation</div>
      <ul class="footer-links">
        <li><a href="#chart">Bars (Rates)</a></li>
        <li><a href="message.html">Messages</a></li>
        <li><a href="about-us.html">About Us</a></li>
        <li><a href="#contact">Contact Us</a></li>
      </ul>
    </div>
    <div>
      <div class="footer-col-title">Trading</div>
      <ul class="footer-links">
        <li><a href="#download">Live Trades</a></li>
        <li><a href="Orders.html">Pending Orders</a></li>
      </ul>
    </div>
    <div>
      <div class="footer-col-title">Mobile Apps</div>
      <ul class="footer-links">
        <li><a href="https://play.google.com/store/apps/details?id=com.aarav">Android App</a></li>
        <li><a href="https://apps.apple.com/in/app/aarav-bullion/id6474193567">iOS App</a></li>
        <li><a href="#">Latest Version</a></li>
        <li><a href="#">Updates</a></li>
      </ul>
    </div>
  </div>
  <div class="footer-bottom">
    <div class="footer-disclaimer">
      ⚠️ All rates displayed are for information purposes only. Final rates will be as per the market at the time of order confirmation. Payment and delivery terms apply as per company policy.
    </div>
    <div class="footer-copy">© Copyright 2017. MetalPulse. All rights reserved.</div>
  </div>
</footer>

<script>
// TICKER DATA
const tickerData = [
  { name: 'GOLD SPOT ($)', price: '$2,645.20', chg: '+0.85%', up: true },
  { name: 'SILVER SPOT ($)', price: '$31.42', chg: '-0.30%', up: false },
  { name: 'USD/INR', price: '₹84.152', chg: '+0.05%', up: true },
  { name: 'GOLD MCX', price: '₹72,450', chg: '+1.45%', up: true },
  { name: 'SILVER MCX', price: '₹84,200', chg: '+0.92%', up: true },
  { name: 'GOLD 24K (AHM)', price: '₹72,450', chg: '+1.45%', up: true },
  { name: 'GOLD 22K (AHM)', price: '₹66,410', chg: '+1.45%', up: true },
];

function buildTicker() {
  const el = document.getElementById('tickerInner');
  const items = [...tickerData, ...tickerData]; // duplicate for infinite scroll
  el.innerHTML = items.map(t => `
    <div class="ticker-item">
      <span class="ticker-name">${t.name}</span>
      <span class="ticker-price">${t.price}</span>
      <span class="${t.up ? 'ticker-chg-up' : 'ticker-chg-dn'}">${t.up ? '▲' : '▼'} ${t.chg}</span>
    </div>
  `).join('');
}

// RATE CARDS
// RATE DATA - BULLION BOARD
const rateCards = {
  'GOLD': {
    spot: { gold: '5183.80', silver: '88.73', inr: '91.881' },
    products: [
      { name: 'GOLD (DELHI) 995 T+0', price: '72345' },
      { name: 'GOLD 999 GGC-100G (AMD)', price: '72480' },
      { name: 'GOLD 995 BIS-IND (RAJ)', price: '72180' }
    ],
    costing: [
      { name: 'GOLD COSTING', bid: '162169', ask: '162190', high: '162388', low: '161340' },
      { name: 'GOLD 916 COSTING', bid: '66410', ask: '66450', high: '66500', low: '66300' }
    ]
  },
  'SILVER': {
    spot: { gold: '5183.80', silver: '88.73', inr: '91.881' },
    products: [
      { name: 'SILVER (AMD) PETI 30Kg T+0', price: '278145' },
      { name: 'SILVER PETI CUTTING (5KG) T+0', price: '278197' },
      { name: 'SILVER 999 GGC-1KG (AMD)', price: '279793' }
    ],
    costing: [
      { name: 'SILVER COSTING', bid: '275469', ask: '275744', high: '278339', low: '271000' },
      { name: 'SILVER 999 COSTING', bid: '84200', ask: '84350', high: '84500', low: '84100' }
    ]
  }
};

let currentCategory = 'GOLD';

// GSAP Registration
gsap.registerPlugin(ScrollTrigger);

// LENIS INIT (Smooth Scroll)
let lenis;
function initSmoothScroll() {
  lenis = new Lenis({
    duration: 1.6,
    easing: (t) => Math.min(1, 1.001 - Math.pow(2, -10 * t)),
    smoothWheel: true,
    wheelMultiplier: 1.1,
    lerp: 0.1
  });
  
  lenis.on('scroll', ScrollTrigger.update);

  function raf(time) {
    lenis.raf(time);
    requestAnimationFrame(raf);
  }
  requestAnimationFrame(raf);
}

// PARTICLES SYSTEM
function initParticles() {
  const container = document.getElementById('particlesContainer');
  if (!container) return;
  for (let i = 0; i < 30; i++) {
    const p = document.createElement('div');
    p.className = 'particle';
    container.appendChild(p);
    gsap.set(p, {
      x: gsap.utils.random(0, window.innerWidth),
      y: gsap.utils.random(0, 1000),
      scale: gsap.utils.random(0.5, 2),
      opacity: gsap.utils.random(0.1, 0.4)
    });
    animateParticle(p);
  }
}

function animateParticle(p) {
  gsap.to(p, {
    y: "+=150",
    x: "+=" + gsap.utils.random(-100, 100),
    duration: gsap.utils.random(10, 20),
    ease: "none",
    repeat: -1,
    yoyo: true
  });
}

function switchTab(cat, btn) {
  currentCategory = cat;
  document.querySelectorAll('.rb-tab').forEach(b => b.classList.remove('active'));
  btn.classList.add('active');
  
  const board = document.querySelector('.rates-board');
  if (cat === 'GOLD') {
    board.style.setProperty('--board-accent', 'var(--gold)');
    board.style.setProperty('--board-accent-grad', 'var(--grad)');
  } else {
    board.style.setProperty('--board-accent', 'var(--silver)');
    board.style.setProperty('--board-accent-grad', 'var(--silver-grad)');
  }
  
  buildRateCards();
}

function buildRateCards() {
  const data = rateCards[currentCategory];
  
  // 1. Spotlight
  document.getElementById('spotGold').textContent = data.spot.gold;
  document.getElementById('spotSilver').textContent = data.spot.silver;
  document.getElementById('spotINR').textContent = data.spot.inr;
  
  // 2. Product List
  const listEl = document.getElementById('ratesList');
  listEl.innerHTML = data.products.map(p => `
    <div class="rb-product-row">
      <div class="rb-prod-name">${p.name}</div>
      <div class="rb-prod-price">${parseFloat(p.price).toLocaleString('en-IN')}</div>
    </div>
  `).join('');
  
  // 3. Costing Rows
  const costEl = document.getElementById('costingRows');
  costEl.innerHTML = data.costing.map(c => `
    <div class="rb-cost-row">
      <div class="rb-cost-prod">${c.name}</div>
      <div class="rb-cost-val-wrap">
        <span class="rb-cost-val rc-price">${parseFloat(c.bid).toLocaleString('en-IN')}</span>
        <div class="rb-hl high">High: ${parseFloat(c.high).toLocaleString('en-IN')}</div>
      </div>
      <div class="rb-cost-val-wrap">
        <span class="rb-cost-val rc-price">${parseFloat(c.ask).toLocaleString('en-IN')}</span>
        <div class="rb-hl low">Low: ${parseFloat(c.low).toLocaleString('en-IN')}</div>
      </div>
    </div>
  `).join('');
}



// MAIN CHART
const chartDataSets = {
  '1D': { labels: ['9AM','10AM','11AM','12PM','1PM','2PM','3PM'], base: 71414, delta: [0,320,580,420,780,920,1036] },
  '1W': { labels: ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'], base: 71000, delta: [0,200,-100,400,800,1000,1450] },
  '1M': { labels: ['Feb 10','Feb 15','Feb 20','Feb 25','Mar 1','Mar 5','Mar 10'], base: 70000, delta: [0,300,800,600,1200,1800,2450] },
  '1Y': { labels: ['Apr','Jun','Aug','Oct','Dec','Feb','Now'], base: 58200, delta: [0,3200,5800,6200,9400,11800,14250] },
};

let currentPeriod = '1D';
let chartCanvas, ctx;
let chartData = [];
let chartLabels = [];
let animProgress = 0;
let animFrame;

function getChartPoints(canvas, data, base) {
  const w = canvas.width;
  const h = canvas.height;
  const vals = data.delta.map(d => base + d);
  const min = Math.min(...vals) - 200;
  const max = Math.max(...vals) + 200;
  return vals.map((v, i) => ({
    x: (i / (vals.length - 1)) * w,
    y: h - ((v - min) / (max - min)) * h * 0.85 - h * 0.075,
  }));
}

function drawChart(progress) {
  if (!ctx || !chartCanvas) return;
  const w = chartCanvas.width;
  const h = chartCanvas.height;
  ctx.clearRect(0, 0, w, h);

  const ds = chartDataSets[currentPeriod];
  const vals = ds.delta.map(d => ds.base + d);
  const min = Math.min(...vals) - 200;
  const max = Math.max(...vals) + 200;

  // Grid lines
  ctx.strokeStyle = 'rgba(42,47,58,0.8)';
  ctx.lineWidth = 1;
  for (let i = 0; i <= 4; i++) {
    const y = (i / 4) * h;
    ctx.beginPath();
    ctx.moveTo(0, y);
    ctx.lineTo(w, y);
    ctx.stroke();
    const price = max - (i / 4) * (max - min);
    ctx.fillStyle = 'rgba(156,163,175,0.6)';
    ctx.font = '11px DM Sans, sans-serif';
    ctx.fillText('₹' + Math.round(price).toLocaleString('en-IN'), 8, y - 4);
  }

  // X labels - Alignment fix for edges
  ctx.fillStyle = 'rgba(156,163,175,0.6)';
  ctx.font = '11px DM Sans, sans-serif';
  ds.labels.forEach((lbl, i) => {
    const x = (i / (ds.labels.length - 1)) * w;
    if (i === 0) ctx.textAlign = 'left';
    else if (i === ds.labels.length - 1) ctx.textAlign = 'right';
    else ctx.textAlign = 'center';
    ctx.fillText(lbl, x, h - 4);
  });
  ctx.textAlign = 'left';

  // Animation points calculation
  const totalPts = vals.length;
  const clampedProgress = Math.max(0, Math.min(1, progress));
  const endIdx = clampedProgress * (totalPts - 1);
  
  const pts = vals.map((v, i) => ({
    x: (i / (totalPts - 1)) * w,
    y: h - ((v - min) / (max - min)) * (h * 0.82) - h * 0.09,
  }));

  // Interpolated end point
  const fullIdx = Math.floor(endIdx);
  const frac = endIdx - fullIdx;
  let currentX = pts[fullIdx].x;
  let currentY = pts[fullIdx].y;

  if (frac > 0 && fullIdx < totalPts - 1) {
    currentX += (pts[fullIdx + 1].x - pts[fullIdx].x) * frac;
    currentY += (pts[fullIdx + 1].y - pts[fullIdx].y) * frac;
  }

  // Path drawing
  const grad = ctx.createLinearGradient(0, 0, 0, h);
  grad.addColorStop(0, 'rgba(212,175,55,0.18)');
  grad.addColorStop(1, 'rgba(212,175,55,0)');

  // Fill Area
  ctx.beginPath();
  ctx.moveTo(pts[0].x, h);
  ctx.lineTo(pts[0].x, pts[0].y);
  for (let i = 1; i <= fullIdx; i++) {
    ctx.lineTo(pts[i].x, pts[i].y);
  }
  if (fullIdx < totalPts - 1) {
    ctx.lineTo(currentX, currentY);
  }
  ctx.lineTo(currentX, h);
  ctx.closePath();
  ctx.fillStyle = grad;
  ctx.fill();

  // Draw Line
  ctx.beginPath();
  ctx.moveTo(pts[0].x, pts[0].y);
  for (let i = 1; i <= fullIdx; i++) {
    ctx.lineTo(pts[i].x, pts[i].y);
  }
  if (fullIdx < totalPts - 1) {
    ctx.lineTo(currentX, currentY);
  }
  ctx.strokeStyle = '#D4AF37';
  ctx.lineWidth = 2.5;
  ctx.lineJoin = 'round';
  ctx.lineCap = 'round';
  ctx.stroke();

  // Progress Dot (only if animating)
  if (clampedProgress < 1 || (clampedProgress === 1 && fullIdx < totalPts - 1)) {
    ctx.beginPath();
    ctx.arc(currentX, currentY, 5, 0, Math.PI * 2);
    ctx.fillStyle = '#D4AF37';
    ctx.fill();
    ctx.beginPath();
    ctx.arc(currentX, currentY, 9, 0, Math.PI * 2);
    ctx.fillStyle = 'rgba(212,175,55,0.2)';
    ctx.fill();
  }
}

function animateChart() {
  cancelAnimationFrame(animFrame);
  animProgress = 0;
  const duration = 1200;
  const start = performance.now();

  function frame(now) {
    animProgress = Math.min((now - start) / duration, 1);
    const ease = 1 - Math.pow(1 - animProgress, 3);
    drawChart(ease);
    if (animProgress < 1) animFrame = requestAnimationFrame(frame);
  }
  animFrame = requestAnimationFrame(frame);
}

function switchChart(period, btn) {
  currentPeriod = period;
  document.querySelectorAll('.tf-btn').forEach(b => b.classList.remove('active'));
  btn.classList.add('active');
  const ds = chartDataSets[period];
  const last = ds.base + ds.delta[ds.delta.length - 1];
  const first = ds.base;
  const change = ((last - first) / first * 100).toFixed(2);
  document.getElementById('cdpPrice').textContent = '₹' + last.toLocaleString('en-IN');
  document.getElementById('cdpChange').textContent = (change > 0 ? '▲ +' : '▼ ') + change + '%';
  document.getElementById('cdpChange').style.color = change > 0 ? 'var(--green)' : 'var(--red)';
  animateChart();
}

function initChart() {
  chartCanvas = document.getElementById('mainChart');
  if (!chartCanvas) return;
  ctx = chartCanvas.getContext('2d');

  function resize() {
    const parent = chartCanvas.parentElement;
    chartCanvas.width = parent.clientWidth;
    chartCanvas.height = parent.clientHeight - 20;
    drawChart(1);
  }
  resize();
  window.addEventListener('resize', resize);
  animateChart();

  // Tooltip
  chartCanvas.addEventListener('mousemove', (e) => {
    const rect = chartCanvas.getBoundingClientRect();
    const mx = e.clientX - rect.left;
    const ds = chartDataSets[currentPeriod];
    const vals = ds.delta.map(d => ds.base + d);
    const w = chartCanvas.width;
    const idx = Math.round((mx / w) * (vals.length - 1));
    const clampedIdx = Math.max(0, Math.min(vals.length - 1, idx));
    const price = vals[clampedIdx];
    const pct = ((price - ds.base) / ds.base * 100).toFixed(2);

    const tt = document.getElementById('tooltipBox');
    tt.style.display = 'block';
    tt.style.left = Math.min(mx + 12, w - 130) + 'px';
    tt.style.top = '20px';
    document.getElementById('ttPrice').textContent = '₹' + price.toLocaleString('en-IN');
    document.getElementById('ttChange').textContent = (pct > 0 ? '▲ +' : '▼ ') + pct + '%';
    document.getElementById('ttChange').style.color = pct > 0 ? 'var(--green)' : 'var(--red)';
    document.getElementById('ttTime').textContent = ds.labels[clampedIdx];

    const cl = document.getElementById('crosshairLine');
    cl.style.display = 'block';
    cl.style.left = mx + 'px';
  });

  chartCanvas.addEventListener('mouseleave', () => {
    document.getElementById('tooltipBox').style.display = 'none';
    document.getElementById('crosshairLine').style.display = 'none';
  });
}

// MARKET STATS EXPANSION
function initMarketStatsExpansion() {
  const gridEl = document.getElementById("statsGrid");
  const cards = document.querySelectorAll("#statsGrid .stat-card");
  if(!gridEl || cards.length === 0) return;

  const tl = gsap.timeline({
    scrollTrigger: {
      trigger: ".market-stats",
      start: "top 65%",
      toggleActions: "play none none none"
    }
  });

  cards.forEach((card, i) => {
    // Calculate distance from grid center to card center
    const gridCenter = {
      x: gridEl.offsetWidth / 2,
      y: gridEl.offsetHeight / 2
    };
    const cardCenter = {
      x: card.offsetLeft + card.offsetWidth / 2,
      y: card.offsetTop + card.offsetHeight / 2
    };
    const xDist = gridCenter.x - cardCenter.x;
    const yDist = gridCenter.y - cardCenter.y;
    
    // Adding slight Z-rotation scatter for overlap realism
    const rRotZ = gsap.utils.random(-5, 5);

    tl.fromTo(card, {
      x: xDist + (i * 10 - 35),
      y: yDist + (i * -10 + 35),
      z: -i * 30,
      rotateX: -20,
      rotateY: 10,
      rotateZ: rRotZ,
      scale: 0.85,
      opacity: 0
    }, {
      x: 0,
      y: 0,
      z: 0,
      rotateX: 0,
      rotateY: 0,
      rotateZ: 0,
      scale: 1,
      opacity: 1,
      duration: 1.5,
      ease: "power4.out",
      onComplete: () => {
        // 1. Float Motion
        gsap.to(card, {
          y: "-=6",
          duration: gsap.utils.random(2, 3),
          ease: "sine.inOut",
          yoyo: true,
          repeat: -1,
          delay: gsap.utils.random(0, 1)
        });

        // 2. Data Counter
        const valEl = card.querySelector(".stat-value");
        const finalValStr = card.getAttribute("data-final");
        const finalVal = parseFloat(finalValStr || 0);
        
        if(finalVal > 0) {
          const isDecimal = finalValStr.includes('.');
          const isRatio = card.querySelector('.stat-label').textContent.includes('Ratio');
          const counter = { val: 0 };
          
          gsap.to(counter, {
            val: finalVal,
            duration: 2,
            ease: "power3.out",
            onUpdate: () => {
              let displayVal = isDecimal ? counter.val.toFixed(2) : Math.floor(counter.val).toLocaleString('en-IN');
              valEl.textContent = isRatio ? displayVal : '₹' + displayVal;
            }
          });
        }
      }
    }, i * 0.1); // Stagger
  });
}

// LIVE PRICE ANIMATION
function animatePrices() {
  setInterval(() => {
    // subtle price flicker to simulate live
    const cards = document.querySelectorAll('.rc-price');
    if (cards.length === 0) return;
    const i = Math.floor(Math.random() * cards.length);
    const orig = cards[i].textContent;
    cards[i].style.transition = 'color 0.3s';
    cards[i].style.color = 'var(--gold-light)';
    setTimeout(() => {
      cards[i].style.color = 'var(--text)';
    }, 400);
  }, 2000);
}

// INIT
document.addEventListener('DOMContentLoaded', () => {
  initSmoothScroll();
  initParticles();
  buildTicker();
  buildRateCards();
  initChart();
  initMarketStatsExpansion();
  animatePrices();
});
  // PRELOADER HIDE
  window.addEventListener('load', () => {
    const tl = gsap.timeline();
    // 1. Forced progress bar duration (3.5s) for brand experience
    tl.to(".loader-bar", { x: "0%", duration: 3.5, ease: "power2.inOut" })
      .to(".loader-bar", { duration: 0.4, backgroundColor: "#22C55E" })
      .to("#preloader > div", { opacity: 0, y: -30, duration: 0.6, ease: "power2.in", delay: 0.2 })
      .to("#preloader", { 
        yPercent: -100, 
        duration: 1.0, 
        ease: "expo.inOut",
        onComplete: () => {
          document.getElementById('preloader').style.display = 'none';
        }
      });
  });
</script>
</body>
</html>