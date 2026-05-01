const GH_PAGES_ORIGIN = "https://oliviaai-tgdk.github.io/SteelOx-Cloud-Pages";
const CANONICAL_PUBLIC = "https://tgdk.io/steelox/";

function securityHeaders(headers) {
  headers.set("x-steelox-route", "cloudflare-worker");
  headers.set("x-steelox-origin", GH_PAGES_ORIGIN);
  headers.set("x-content-type-options", "nosniff");
  headers.set("referrer-policy", "strict-origin-when-cross-origin");
  headers.set("cache-control", "public, max-age=180, s-maxage=300");
  return headers;
}

function mapSteelOxPath(pathname) {
  const match = pathname.match(/^\/steelox\/?(.*)$/i);
  if (!match) return null;

  const rest = match[1] || "";
  const cleanRest = rest.replace(/^\/+/, "");

  if (cleanRest.length === 0) {
    return "/steelox/";
  }

  return "/steelox/" + cleanRest;
}

export default {
  async fetch(request) {
    const incoming = new URL(request.url);
    const mappedPath = mapSteelOxPath(incoming.pathname);

    if (!mappedPath) {
      return new Response("SteelOx route resolver active. Use " + CANONICAL_PUBLIC, {
        status: 404,
        headers: securityHeaders(new Headers({
          "content-type": "text/plain; charset=utf-8"
        }))
      });
    }

    if (
      incoming.pathname === "/steelox" ||
      incoming.pathname === "/SteelOx"
    ) {
      return Response.redirect(CANONICAL_PUBLIC, 301);
    }

    const originURL = new URL(GH_PAGES_ORIGIN + mappedPath);
    originURL.search = incoming.search;

    const originRequest = new Request(originURL.toString(), {
      method: request.method,
      headers: request.headers,
      body: request.method === "GET" || request.method === "HEAD" ? undefined : request.body,
      redirect: "follow"
    });

    const originResponse = await fetch(originRequest);
    const headers = securityHeaders(new Headers(originResponse.headers));

    headers.delete("content-security-policy");
    headers.delete("content-security-policy-report-only");

    return new Response(originResponse.body, {
      status: originResponse.status,
      statusText: originResponse.statusText,
      headers
    });
  }
};
