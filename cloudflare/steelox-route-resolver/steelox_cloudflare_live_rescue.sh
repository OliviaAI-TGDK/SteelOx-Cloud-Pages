#!/data/data/com.termux/files/usr/bin/bash
set -Eeuo pipefail

REPO="$HOME/SteelOx-Cloud-Pages"
REMOTE_URL="https://github.com/OliviaAI-TGDK/SteelOx-Cloud-Pages.git"

DOMAIN="tgdk.io"
GH_ORG="OliviaAI-TGDK"
GH_REPO="SteelOx-Cloud-Pages"
GH_ORG_LOWER="$(printf "%s" "$GH_ORG" | tr '[:upper:]' '[:lower:]')"
GH_PAGES_ORIGIN="https://${GH_ORG_LOWER}.github.io/${GH_REPO}"

WORKER_NAME="steelox-route-resolver"
CF_DIR="$REPO/cloudflare/$WORKER_NAME"

STAMP="$(date -u +%Y%m%d-%H%M%SZ)"
VERSION="steelox-cloudflare-live-rescue-$STAMP"
DLS="/sdcard/Download/steelox"
REPORT="$DLS/$VERSION-report.txt"

echo "============================================================"
echo "SteelOx Cloudflare Live Rescue"
echo "Domain:  $DOMAIN"
echo "Worker:  $WORKER_NAME"
echo "Origin:  $GH_PAGES_ORIGIN"
echo "Version: $VERSION"
echo "============================================================"

mkdir -p "$DLS"

echo
echo "[1] Resolve repo"
if [ ! -d "$REPO/.git" ]; then
  git clone "$REMOTE_URL" "$REPO"
fi

cd "$REPO"
git remote set-url origin "$REMOTE_URL"

echo
echo "[2] Remove GitHub Pages host claim from this repo"
rm -f CNAME docs/CNAME
: > .nojekyll
mkdir -p docs
: > docs/.nojekyll

echo
echo "[3] Ensure SteelOx static files exist"
if [ ! -f "docs/SteelOx/index.html" ] && [ ! -f "docs/steelox/index.html" ]; then
  mkdir -p docs/steelox/assets docs/SteelOx/assets

  cat > docs/steelox/index.html <<'HTML'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">
<meta name="theme-color" content="#05070d">
<title>SteelOx | TGDK</title>
<link rel="stylesheet" href="./assets/steelox.css">
</head>
<body>
<main class="shell">
  <nav class="nav">
    <a class="brand" href="./"><span>SO</span><strong>SteelOx</strong></a>
    <a href="https://tgdk.io/">TGDK.io</a>
  </nav>

  <section class="hero">
    <p class="eyebrow">TGDK.io / SteelOx</p>
    <h1>Mobile-first defensive infrastructure for resilient apps, routes, and command hygiene.</h1>
    <p class="lead">SteelOx is the TGDK security operations layer for Android, Termux, web assets, APK delivery, command hygiene, and Cloudflare route control.</p>
    <div class="actions">
      <a href="#stack">View Stack</a>
      <a href="#deploy">Deploy</a>
    </div>
  </section>

  <section id="stack" class="grid">
    <article><b>Command Hygiene</b><p>Build, copy, version, and verify project packets safely.</p></article>
    <article><b>Cloudflare Routing</b><p>Path-level routing for /steelox and /SteelOx without host conflict.</p></article>
    <article><b>GitHub Pages Origin</b><p>Static origin remains available without claiming the whole domain.</p></article>
    <article><b>TGDK Brand Layer</b><p>SteelOx presence under TGDK.io with mobile-safe layout.</p></article>
  </section>

  <section id="deploy" class="deploy">
    <p>Canonical target:</p>
    <code>https://tgdk.io/steelox/</code>
  </section>
</main>
</body>
</html>
HTML

  cat > docs/steelox/assets/steelox.css <<'CSS'
:root{color-scheme:dark;--bg:#05070d;--panel:rgba(255,255,255,.07);--line:rgba(255,255,255,.14);--text:#f5f7fb;--muted:#a7b0c1;--accent:#a8ffdf}
*{box-sizing:border-box}body{margin:0;background:radial-gradient(circle at top left,rgba(81,145,255,.18),transparent 34rem),linear-gradient(180deg,#05070d,#090d17 55%,#05070d);color:var(--text);font-family:Inter,system-ui,-apple-system,BlinkMacSystemFont,"Segoe UI",sans-serif}.shell{width:min(1120px,calc(100% - 28px));margin:0 auto}.nav{display:flex;align-items:center;justify-content:space-between;gap:16px;margin-top:16px;padding:12px 14px;border:1px solid var(--line);border-radius:999px;background:rgba(5,7,13,.74);backdrop-filter:blur(18px)}a{color:inherit;text-decoration:none}.brand{display:flex;align-items:center;gap:10px}.brand span{display:grid;place-items:center;width:42px;height:42px;border-radius:50%;background:linear-gradient(135deg,#9fd3ff,#a8ffdf);color:#06101b;font-weight:900}.hero{min-height:70vh;display:flex;flex-direction:column;justify-content:center}.eyebrow{color:var(--accent);font-weight:900;letter-spacing:.15em;text-transform:uppercase;font-size:.78rem}h1{max-width:920px;margin:0 0 20px;font-size:clamp(2.6rem,8vw,6.4rem);line-height:.92;letter-spacing:-.075em}.lead{max-width:760px;color:var(--muted);font-size:1.12rem;line-height:1.7}.actions{display:flex;flex-wrap:wrap;gap:12px;margin-top:24px}.actions a{padding:14px 18px;border-radius:999px;background:var(--text);color:#05070d;font-weight:900}.actions a+a{background:var(--panel);color:var(--text);border:1px solid var(--line)}.grid{display:grid;grid-template-columns:repeat(4,minmax(0,1fr));gap:14px;padding:52px 0}.grid article,.deploy{border:1px solid var(--line);border-radius:28px;background:var(--panel);padding:22px;backdrop-filter:blur(18px)}.grid p,.deploy p{color:var(--muted);line-height:1.6}.deploy{margin-bottom:48px}code{display:inline-block;margin:4px 0 14px;color:var(--accent);word-break:break-word}@media(max-width:820px){.grid{grid-template-columns:1fr 1fr}}@media(max-width:560px){.grid{grid-template-columns:1fr}.nav{border-radius:24px}.hero{min-height:auto;padding:70px 0}h1{font-size:clamp(2.5rem,17vw,4.2rem)}}
CSS

  cp -a docs/steelox/. docs/SteelOx/
fi

if [ -f "docs/SteelOx/index.html" ]; then
  rm -rf docs/steelox
  mkdir -p docs/steelox
  cp -a docs/SteelOx/. docs/steelox/
fi

cat > docs/index.html <<'HTML'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="refresh" content="0; url=/steelox/">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>TGDK SteelOx</title>
</head>
<body>
<p><a href="/steelox/">SteelOx</a></p>
</body>
</html>
HTML

cat > README.md <<EOF
# SteelOx Cloud Pages

Cloudflare public route:

\`\`\`
https://$DOMAIN/steelox/
https://$DOMAIN/SteelOx/
\`\`\`

GitHub Pages origin:

\`\`\`
$GH_PAGES_ORIGIN/steelox/
$GH_PAGES_ORIGIN/SteelOx/
\`\`\`

This repo does not claim the apex custom domain with a GitHub Pages CNAME. Cloudflare owns host routing.

Generated:

\`\`\`
$VERSION
\`\`\`
EOF

echo
echo "[4] Create Cloudflare Worker"
mkdir -p "$CF_DIR"

cat > "$CF_DIR/worker.js" <<'EOF'
const GH_PAGES_ORIGIN = "__GH_PAGES_ORIGIN__";
const CANONICAL = "https://__DOMAIN__/steelox/";

const FALLBACK_HTML = `<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">
<meta name="theme-color" content="#05070d">
<title>SteelOx | TGDK</title>
<style>
:root{color-scheme:dark;--bg:#05070d;--panel:rgba(255,255,255,.07);--line:rgba(255,255,255,.14);--text:#f5f7fb;--muted:#a7b0c1;--accent:#a8ffdf}
*{box-sizing:border-box}body{margin:0;background:radial-gradient(circle at top left,rgba(81,145,255,.18),transparent 34rem),linear-gradient(180deg,#05070d,#090d17 55%,#05070d);color:var(--text);font-family:Inter,system-ui,-apple-system,BlinkMacSystemFont,"Segoe UI",sans-serif}.shell{width:min(1120px,calc(100% - 28px));margin:0 auto}.nav{display:flex;align-items:center;justify-content:space-between;gap:16px;margin-top:16px;padding:12px 14px;border:1px solid var(--line);border-radius:999px;background:rgba(5,7,13,.74);backdrop-filter:blur(18px)}a{color:inherit;text-decoration:none}.brand{display:flex;align-items:center;gap:10px}.brand span{display:grid;place-items:center;width:42px;height:42px;border-radius:50%;background:linear-gradient(135deg,#9fd3ff,#a8ffdf);color:#06101b;font-weight:900}.hero{min-height:72vh;display:flex;flex-direction:column;justify-content:center}.eyebrow{color:var(--accent);font-weight:900;letter-spacing:.15em;text-transform:uppercase;font-size:.78rem}h1{max-width:920px;margin:0 0 20px;font-size:clamp(2.6rem,8vw,6.4rem);line-height:.92;letter-spacing:-.075em}.lead{max-width:760px;color:var(--muted);font-size:1.12rem;line-height:1.7}.grid{display:grid;grid-template-columns:repeat(4,minmax(0,1fr));gap:14px;padding:52px 0}.grid article{border:1px solid var(--line);border-radius:28px;background:var(--panel);padding:22px;backdrop-filter:blur(18px)}.grid p{color:var(--muted);line-height:1.6}@media(max-width:820px){.grid{grid-template-columns:1fr 1fr}}@media(max-width:560px){.grid{grid-template-columns:1fr}.nav{border-radius:24px}.hero{min-height:auto;padding:70px 0}h1{font-size:clamp(2.5rem,17vw,4.2rem)}}
</style>
</head>
<body>
<main class="shell">
<nav class="nav"><a class="brand" href="/steelox/"><span>SO</span><strong>SteelOx</strong></a><a href="https://tgdk.io/">TGDK.io</a></nav>
<section class="hero">
<p class="eyebrow">TGDK.io / SteelOx</p>
<h1>Mobile-first defensive infrastructure for resilient apps, routes, and command hygiene.</h1>
<p class="lead">SteelOx is the TGDK security operations layer for Android, Termux, web assets, APK delivery, command hygiene, GitHub Pages origin hosting, and Cloudflare path routing.</p>
</section>
<section class="grid">
<article><b>Command Hygiene</b><p>Build, copy, version, and verify project packets safely.</p></article>
<article><b>Cloudflare Routing</b><p>Route /steelox and /SteelOx without claiming the whole host from GitHub Pages.</p></article>
<article><b>Pages Origin</b><p>Static origin support through SteelOx-Cloud-Pages.</p></article>
<article><b>TGDK Layer</b><p>Canonical SteelOx route under tgdk.io.</p></article>
</section>
</main>
</body>
</html>`;

function steelHeaders(headers = new Headers()) {
  headers.set("x-steelox-route", "cloudflare-live-rescue");
  headers.set("x-content-type-options", "nosniff");
  headers.set("referrer-policy", "strict-origin-when-cross-origin");
  headers.set("cache-control", "public, max-age=120, s-maxage=300");
  return headers;
}

function isSteelOx(pathname) {
  return /^\/steelox(\/.*)?$/i.test(pathname);
}

function mappedOriginPath(pathname) {
  const m = pathname.match(/^\/steelox\/?(.*)$/i);
  const rest = m && m[1] ? m[1].replace(/^\/+/, "") : "";
  return rest ? `/steelox/${rest}` : "/steelox/";
}

export default {
  async fetch(request) {
    const url = new URL(request.url);

    if (!isSteelOx(url.pathname)) {
      return new Response("SteelOx route resolver active. Use " + CANONICAL, {
        status: 404,
        headers: steelHeaders(new Headers({ "content-type": "text/plain; charset=utf-8" }))
      });
    }

    if (url.pathname === "/steelox" || url.pathname === "/SteelOx") {
      return Response.redirect(CANONICAL, 301);
    }

    const originUrl = new URL(GH_PAGES_ORIGIN + mappedOriginPath(url.pathname));
    originUrl.search = url.search;

    try {
      const originResponse = await fetch(originUrl.toString(), {
        method: request.method,
        headers: request.headers,
        redirect: "follow"
      });

      if (originResponse.ok) {
        return new Response(originResponse.body, {
          status: originResponse.status,
          statusText: originResponse.statusText,
          headers: steelHeaders(new Headers(originResponse.headers))
        });
      }
    } catch (_) {
      // Fall through to embedded fallback.
    }

    return new Response(FALLBACK_HTML, {
      status: 200,
      headers: steelHeaders(new Headers({ "content-type": "text/html; charset=utf-8" }))
    });
  }
};
EOF

sed -i \
  -e "s|__GH_PAGES_ORIGIN__|$GH_PAGES_ORIGIN|g" \
  -e "s|__DOMAIN__|$DOMAIN|g" \
  "$CF_DIR/worker.js"

cat > "$CF_DIR/wrangler.toml" <<EOF
name = "$WORKER_NAME"
main = "worker.js"
compatibility_date = "2026-05-01"
send_metrics = false

routes = [
  { pattern = "$DOMAIN/steelox*", zone_name = "$DOMAIN" },
  { pattern = "$DOMAIN/SteelOx*", zone_name = "$DOMAIN" }
]
EOF

cat > "$CF_DIR/package.json" <<EOF
{
  "name": "$WORKER_NAME",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "deploy": "wrangler deploy"
  },
  "devDependencies": {
    "wrangler": "latest"
  }
}
EOF

echo
echo "[5] Commit and push repo"
git add .nojekyll docs README.md cloudflare

if git diff --cached --quiet; then
  echo "[OK] Nothing new to commit."
else
  git commit -m "Deploy SteelOx Cloudflare live rescue $VERSION"
fi

git push -u origin main

echo
echo "[6] Install Node if needed"
if ! command -v node >/dev/null 2>&1; then
  pkg install -y nodejs
fi

echo
echo "[7] Deploy Cloudflare Worker"
echo "IMPORTANT: use a NEW token. Do not reuse any token that was pasted into chat."
echo

if [ -z "${CF_API_TOKEN:-}" ]; then
  read -r -s -p "Paste NEW Cloudflare API token: " CF_API_TOKEN
  echo
  export CF_API_TOKEN
fi

cd "$CF_DIR"
npx -y wrangler@latest deploy

unset CF_API_TOKEN

echo
echo "[8] Test routes"
echo "Waiting 8 seconds for route propagation..."
sleep 8

{
  echo "SteelOx Cloudflare Live Rescue Report"
  echo "Version: $VERSION"
  echo "Worker: $WORKER_NAME"
  echo "Origin: $GH_PAGES_ORIGIN"
  echo
  echo "Test: https://$DOMAIN/steelox"
  curl -sSI "https://$DOMAIN/steelox" | sed -n '1,12p' || true
  echo
  echo "Test: https://$DOMAIN/steelox/"
  curl -sSI "https://$DOMAIN/steelox/" | sed -n '1,16p' || true
  echo
  echo "Test body marker:"
  curl -sSL "https://$DOMAIN/steelox/" | grep -iE "SteelOx|cloudflare-live-rescue|TGDK" | head -10 || true
} | tee "$REPORT"

echo
echo "============================================================"
echo "[OK] Deployed SteelOx Cloudflare rescue route."
echo
echo "Open:"
echo "https://$DOMAIN/steelox"
echo "https://$DOMAIN/steelox/"
echo "https://$DOMAIN/SteelOx/"
echo
echo "Report:"
echo "$REPORT"
echo "============================================================"
