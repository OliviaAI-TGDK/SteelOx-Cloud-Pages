const GH_PAGES_ORIGIN = "https://oliviaai-tgdk.github.io/SteelOx-Cloud-Pages";
const CANONICAL = "https://tgdk.io/steelox/";

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
