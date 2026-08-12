const apiKey = process.env.WDCLOUD_API_KEY;

if (!apiKey) {
  throw new Error("Set WDCLOUD_API_KEY before running this example");
}

const baseUrl = (process.env.WDCLOUD_BASE_URL || "https://token.wdcloud.ai").replace(/\/$/, "");
const model = process.env.WDCLOUD_MODEL || "deepseek-v4-flash";
const response = await fetch(`${baseUrl}/v1/chat/completions`, {
  method: "POST",
  headers: {
    Authorization: `Bearer ${apiKey}`,
    Accept: "application/json",
    "Content-Type": "application/json",
  },
  body: JSON.stringify({
    model,
    messages: [
      {
        role: "user",
        content: "请只回复：WDCloud API 连接成功",
      },
    ],
    stream: false,
  }),
});

const body = await response.text();
if (!response.ok) {
  throw new Error(`WDCloud request failed with HTTP ${response.status}: ${body}`);
}

console.log(JSON.stringify(JSON.parse(body), null, 2));
