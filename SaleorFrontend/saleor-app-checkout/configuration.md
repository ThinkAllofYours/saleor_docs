---
description: saleor-app-checkout setting 방법, locale 설정 방법
---

### configurations

#### locale settings
- `pnpm dev`로 프로젝트 시작 후 언어를 한국어로 변경하고 장바구니 등을 클릭하게 되면 오류가 나는데 locale을 ko-KR로 변경하고 locale 정보를 checkout-storefront로 전달했을때 formatjs에서 한국어에 대한 데이터가 없기 때문에 오류가 생김
- packages/checkout-storefront/content/locales/ko-KR.json **ko-KR.json 파일이 해당 path에 위치**
> apps/saleor-app-checkout/next.config.js
```js
...
/** @type {import('next').NextConfig} */
const config = withTM({
  trailingSlash: true,
  i18n: {
    locales: ["en-US", "pl-PL", "fr-FR", "vi-VN", "ar-AE", "ko-KR"],
    defaultLocale:"ko-KR",
  },
  reactStrictMode: true,
  productionBrowserSourceMaps: true,
...
```

> packages/checkout-storefront/src/hooks/useLocale.ts
```ts
...
// Korea Customizing
import KO_KR from "../../content/compiled-locales/ko-KR.json"

const localeToMessages: Record<Locale, any> = {
  "en-US": EN_US,
  "pl-PL": PL_PL,
  "ko-KR": KO_KR,
};

interface UseLocale {
  locale: Locale;
  countryCode: CountryCode;
  channel: string;
  messages: typeof localeToMessages[keyof typeof localeToMessages];
}
...
```

> packages/checkout-storefront/src/lib/regions.ts
```ts
export const locales = ["en-US", "pl-PL", "ko-KR"] as const;

export const DEFAULT_LOCALE = "en-US";

export const DEFAULT_CHANNEL = "default-channel";

export type Locale = typeof locales[number];
```

> packages/checkout-storefront/src/sections/PageHeader/messages.ts
```ts
import { Locale } from "@/checkout-storefront/lib/regions";
import { defineMessages } from "react-intl";

export const languagesMessages = defineMessages<Locale>({
  "en-US": {
    defaultMessage: "English (USA)",
    id: "PageHeader/messages/eXrxj4",
    description: "english usa",
  },
  "pl-PL": {
    defaultMessage: "Polish",
    id: "PageHeader/messages/kd+Ya5",
    description: "polish",
  },
  "ko-KR": {
    defaultMessage: "korean",
    id: "PageHeader/messages/ko+eXrxj4",
    description: "korean",
  },
});
```