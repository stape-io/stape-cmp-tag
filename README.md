# Stape CMP Tag for Google Tag Manager Web

This tag installs your Stape container's consent management platform (CMP) on a site that loads Google Tag Manager from `googletagmanager.com`. It sets the denied Google Consent Mode default and loads the CMP from your container's Stape domain, so the banner appears and Consent Mode updates follow the visitor's choice.

⚠️ If your site loads Google Tag Manager through the Stape Custom Loader, the CMP is already installed there and you do not need this tag. ⚠️

## Setup Instructions

1. **Import** the template from the Community Template Gallery into your GTM Web workspace.
2. **Create** a new tag using the _Stape CMP_ template.
3. **Enter** your Stape domain, the domain of your Stape container, for example `abcdefgh.euf.stape.net`. To find it, go to the [Stape Admin panel](https://app.stape.io/container), select the sGTM container, go to the _Settings_ tab and scroll down to the _Domains (Tagging Server URLs)_ section. The domain is after the _Built-in container URL_ text.
4. **Tick** _IAB TCF is on for this container_ if IAB TCF is switched on in your Stape CMP settings (see _TCF_ below).
5. **Fill in** _Page language_ under _Advanced settings_ if you want the CMP in the page's language (see _Language_ below). You can leave it empty.
6. **Assign** the **Consent Initialization - All Pages** trigger. The tag must run before any other tag so the denied default is in place first.
7. **Publish** the container.

The Stape domain is the container domain under `stape.net` or `stape.io`, not your custom domain.

## What the Tag Does

On each page, in this order:

1. **Stands down** if `window.__stapeCmp` already exists. A page served by the Stape Custom Loader, a duplicated tag and a second container on the page all end here, so the CMP is never installed twice.
2. **Sets the Consent Mode default** with `setDefaultConsentState`: every signal is `denied` except `security_storage`, which is `granted`, with `wait_for_update` set to 500 ms. There is no per-region table.
3. **Applies the advanced settings** you ticked, if any (see below).
4. **Installs the TCF API queue** `window.__tcfapi` when _IAB TCF is on for this container_ is ticked and the page has no `__tcfapi` yet (see _TCF_ below).
5. **Writes the namespace** `window.__stapeCmp = { dataLayer: <data layer name>, gcmFloor: true }`, with `tcfStub: true` when the tag installed the TCF API queue. Nothing else is written to `window`, the tag never touches your data layer array and it never creates `window.gtag`.
6. **Loads the CMP** from `https://<Stape domain>/<container identifier>/cmp/bundle.js`. The container identifier is the first label of the Stape domain. The tag reports success or failure to GTM when the script loads or fails.

### Language

The tag appends `?lang=` to the bundle URL with the value of the **Page language** field, trimmed and URL-encoded. When the field is empty, `?lang=` is left out and the CMP uses your container's default language.

A GTM template cannot read the page's `<html lang>` attribute or the browser's language, so the tag cannot detect the language itself. To follow the page, create a GTM variable that returns it (for example a Custom JavaScript variable returning `document.documentElement.lang`) and select it in the field. The CMP selects the language from what you pass; a language the container has no copy for falls back to the container's default language.

## Advanced Settings

| Setting | Effect |
| --- | --- |
| Redact ads data | Removes ad click identifiers from Google Ads requests while `ad_storage` is denied. |
| Pass ad click information through URLs | Keeps the ad click identifier in page URLs while `ad_storage` is denied, so conversions can still be measured. |
| Page language | The page's language, for example a variable that returns the `<html lang>` attribute. Optional; leave empty to show the CMP in its default language. |
| Data layer name | The name of your data layer array. Change it only if your GTM container uses a custom data layer name. |

A custom data layer name needs no change to the template's permissions, so the template stays linked to the Community Template Gallery.

## TCF

Google's tags look for the TCF API (`window.__tcfapi`) when they load, which is before the CMP script arrives. Tick _IAB TCF is on for this container_ when IAB TCF is switched on in your Stape CMP settings: the tag then puts a TCF API queue on the page, Google's tags find it and read the visitor's TC String, and the CMP takes the queue over when it loads and adds the frame that ad iframes use to reach it. Keep the box in step with your CMP settings; without TCF in the container, leave it unticked.

## Waiting for the CMP API

The `window.__stapeCmp` object exists as soon as the tag runs, but its methods arrive with the CMP script. To call the API from your own code, check for the method, for example `typeof window.__stapeCmp?.on === 'function'`, or react to the `stape_cmp_consent` data layer event.

## Permissions

| Permission | Why |
| --- | --- |
| Injects scripts | Loads the CMP bundle from `https://*.stape.net/*` and `https://*.stape.io/*`. |
| Accesses global variables | Reads and writes `__stapeCmp`, and `__tcfapi` for the TCF API queue. |
| Accesses consent state | Sets the default for every Consent Mode signal. |
| Writes to the data layer | Sets `ads_data_redaction` and `url_passthrough` when those options are ticked. |

## Open Source

The **Stape CMP Tag for GTM** is developed and maintained by the [Stape Team](https://stape.io/) under the Apache 2.0 license.

### GTM Gallery Status
🔴 Not listed
