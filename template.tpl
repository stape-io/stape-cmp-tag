___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Stape CMP",
  "categories": [
    "UTILITY"
  ],
  "brand": {
    "id": "github.com_stape-io",
    "displayName": "stape-io",
    "thumbnail": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAABYElEQVR4AZ1TAUQFQRBdhBBCCCGEECCE8IEAkCT1b8ftdrt7oYAQ+gQIAUIA+AgQAoQQAgSAACGEcDjUPHag27vu32McNzNv386bVf9hrywXiGheDcWhtSvahGtt3Jc2/iPL/SVRudybYJy7TW6cctQxpjr3D/z94ag47sbGb7QTHPsdVvCMBqiAGqiSPBXFurbhNpJxTXgk60cNIk4+cXxmxp1iLqoFB0WxpK2/wGHoaSFCohtEZ4tSP5iIZ7ULJZjjQCIh8TXmiKv3IsLedJHE+jf+f98gggucfI+yeW+K7TYSAMbAxQSRu4KtWLq4Bt9YwhTJkSnXUKtzZ5pu2LCFpNgvOyUkiUNr2bPUnF5xLcwIzdq6m78kUAznGvNJqULRaDKZSzxgUVoR+VXVhcyEcyET90SJXDezbl/1AZ4AGuAiO3MSZ1JhLnyQVrMA9nPjCwjlkcqrHwRYLe504RfU6/XwKT3D8gAAAABJRU5ErkJggg=="
  },
  "description": "Installs Stape\u0027s CMP. Add on Consent Initialization and enter your container domain. Not needed if your site loads GTM via Stape Custom Loader, as CMP is already installed.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "stapeDomain",
    "displayName": "Stape domain",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      },
      {
        "type": "REGEX",
        "args": [
          "^[a-z0-9]([a-z0-9-]*[a-z0-9])?\\.[a-z0-9]([a-z0-9-]*[a-z0-9])?\\.stape\\.(net|io)$"
        ],
        "errorMessage": "Enter your Stape container domain, for example abcdefgh.euf.stape.net."
      }
    ],
    "help": "The domain of your Stape container, for example <i>abcdefgh.euf.stape.net</i>.\n<br/><br/>\nTo find the <b>Stape domain</b>, go to the <a href=\"https://app.stape.io/container\">Stape Admin panel</a>, select the sGTM container, go to the <i>Settings</i> tab and scroll down to the <i>Domains (Tagging Server URLs)</i> section. The domain is after the <i>Built-in container URL</i> text.\n<br/><br/>\nMake sure to:\n<ul><li>use the <i>stape.net</i> or <i>stape.io</i> domain, <b>not</b> your custom domain;</li><li>not include <i>https://</i> or a path.</li></ul>",
    "alwaysInSummary": true
  },
  {
    "type": "CHECKBOX",
    "name": "tcf",
    "checkboxText": "IAB TCF is on for this container",
    "simpleValueType": true,
    "defaultValue": false,
    "help": "Tick if <b>IAB TCF v2.2</b> is switched on in your Stape CMP settings.\n<br/><br/>\nThe tag then installs the TCF API (<i>__tcfapi</i>) before Google\u0027s tags load, so they can read the visitor\u0027s TC String.\n<br/><br/>\nLeave unticked if IAB TCF is off."
  },
  {
    "type": "GROUP",
    "name": "advancedSettings",
    "displayName": "Advanced settings",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "adsDataRedaction",
        "checkboxText": "Redact ads data",
        "simpleValueType": true,
        "defaultValue": false,
        "help": "Sets <i>ads_data_redaction</i> to <i>true</i>.\n<br/><br/>\nWhile <i>ad_storage</i> is denied, Google Ads and Floodlight requests do not carry ad click identifiers (for example, <i>gclid</i>)."
      },
      {
        "type": "CHECKBOX",
        "name": "urlPassthrough",
        "checkboxText": "Pass ad click information through URLs",
        "simpleValueType": true,
        "defaultValue": false,
        "help": "Sets <i>url_passthrough</i> to <i>true</i>.\n<br/><br/>\nWhile <i>ad_storage</i> or <i>analytics_storage</i> is denied, ad click and Google Analytics identifiers (for example, <i>gclid</i>) are kept in the page URLs, so conversions can still be measured."
      },
      {
        "type": "TEXT",
        "name": "pageLanguage",
        "displayName": "Page language",
        "simpleValueType": true,
        "help": "The language the CMP is shown in, for example <i>en</i> or <i>fr-CA</i>.\n<br/><br/>\nTo follow the page language, select a variable that returns it, such as a Custom JavaScript variable returning <i>document.documentElement.lang</i> (the <i>html lang</i> attribute).\n<br/><br/>\nThe CMP uses the default language of your container when:\n<ul><li>the field is empty;</li><li>the container has no translation for the given language.</li></ul>"
      },
      {
        "type": "TEXT",
        "name": "dataLayerName",
        "displayName": "Data layer name",
        "simpleValueType": true,
        "defaultValue": "dataLayer",
        "help": "The name of the data layer used by your GTM container.\n<br/><br/>\nChange it <b>only</b> if your GTM container uses a custom data layer name. Otherwise, keep <i>dataLayer</i>."
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const copyFromWindow = require('copyFromWindow');
const encodeUriComponent = require('encodeUriComponent');
const getType = require('getType');
const gtagSet = require('gtagSet');
const injectScript = require('injectScript');
const setDefaultConsentState = require('setDefaultConsentState');
const setInWindow = require('setInWindow');

/*==============================================================================
==============================================================================*/

const stapeDomain = data.stapeDomain;
const dataLayerName = data.dataLayerName || 'dataLayer';

if (!isStapeDomain(stapeDomain)) return data.gtmOnFailure();

if (copyFromWindow('__stapeCmp')) return data.gtmOnSuccess();

setDefaultConsentState({
  ad_storage: 'denied',
  ad_user_data: 'denied',
  ad_personalization: 'denied',
  analytics_storage: 'denied',
  functionality_storage: 'denied',
  personalization_storage: 'denied',
  security_storage: 'granted',
  wait_for_update: 500
});

if (data.adsDataRedaction) gtagSet({ ads_data_redaction: true });
if (data.urlPassthrough) gtagSet({ url_passthrough: true });

const namespace = { dataLayer: dataLayerName, gcmFloor: true };
if (data.tcf && !copyFromWindow('__tcfapi')) {
  setInWindow('__tcfapi', createTcfQueue(), false);
  namespace.tcfStub = true;
}
setInWindow('__stapeCmp', namespace, false);

const bundleUrl = getBundleUrl(stapeDomain);
injectScript(bundleUrl, data.gtmOnSuccess, data.gtmOnFailure, bundleUrl);

/*==============================================================================
Helpers
==============================================================================*/

function getBundleUrl(domain) {
  const identifier = domain.split('.')[0];
  const language = getLanguage();
  const query = language ? '?lang=' + encodeUriComponent(language) : '';

  return 'https://' + domain + '/' + identifier + '/cmp/bundle.js' + query;
}

// The IAB CmpApi takes over a stub by calling it with no arguments and draining what it returns.
function createTcfQueue() {
  const queue = [];
  return function (command, version, callback, parameter) {
    if (command === undefined) return queue;
    queue.push([command, version, callback, parameter]);
  };
}

function getLanguage() {
  return getType(data.pageLanguage) === 'string' ? data.pageLanguage.trim() : '';
}

// {identifier}.{zone}.stape.net or .stape.io
function isStapeDomain(domain) {
  if (getType(domain) !== 'string') return false;

  const labels = domain.split('.');
  if (labels.length !== 4) return false;
  if (labels[2] !== 'stape' || (labels[3] !== 'net' && labels[3] !== 'io')) return false;
  return isHostLabel(labels[0]) && isHostLabel(labels[1]);
}

function isHostLabel(label) {
  const allowed = 'abcdefghijklmnopqrstuvwxyz0123456789-';
  if (!label || label.length > 63) return false;
  if (label.charAt(0) === '-' || label.charAt(label.length - 1) === '-') return false;
  for (let i = 0; i < label.length; i++) {
    if (allowed.indexOf(label.charAt(i)) < 0) return false;
  }
  return true;
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "__stapeCmp"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "__tcfapi"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_consent",
        "versionId": "1"
      },
      "param": [
        {
          "key": "consentTypes",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_storage"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_user_data"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_personalization"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "analytics_storage"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "functionality_storage"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "personalization_storage"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "security_storage"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://*.stape.net/*"
              },
              {
                "type": 1,
                "string": "https://*.stape.io/*"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "write_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "ads_data_redaction"
              },
              {
                "type": 1,
                "string": "url_passthrough"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: '[Stand down] A page that already has __stapeCmp gets no default, no namespace write and no injection'
  code: |-
    fakeWindow.__stapeCmp = { dataLayer: 'dataLayer', gcmFloor: true };

    runCode(createMockData({ adsDataRedaction: true, urlPassthrough: true }));

    assertApi('gtmOnSuccess').wasCalled();
    assertApi('gtmOnFailure').wasNotCalled();
    assertApi('setDefaultConsentState').wasNotCalled();
    assertApi('gtagSet').wasNotCalled();
    assertApi('setInWindow').wasNotCalled();
    assertApi('injectScript').wasNotCalled();
- name: '[Stand down] An empty __stapeCmp namespace still stands the tag down'
  code: |-
    fakeWindow.__stapeCmp = {};

    runCode(createMockData());

    assertApi('gtmOnSuccess').wasCalled();
    assertApi('gtmOnFailure').wasNotCalled();
    assertApi('setDefaultConsentState').wasNotCalled();
    assertApi('setInWindow').wasNotCalled();
    assertApi('injectScript').wasNotCalled();
- name: '[Stand down] A namespace left by the loader with another data layer name stands the tag down'
  code: |-
    fakeWindow.__stapeCmp = { dataLayer: 'siteLayer', gcmFloor: true };

    runCode(createMockData({ dataLayerName: 'myLayer' }));

    assertApi('setDefaultConsentState').wasNotCalled();
    assertApi('setInWindow').wasNotCalled();
    assertApi('injectScript').wasNotCalled();
    expectSuccess();
- name: '[Stand down] A second run on the same page stands down after the first one wrote the namespace'
  code: |-
    runCode(createMockData());
    runCode(createMockData());

    var defaults = 0;
    var injections = 0;
    var i;
    for (i = 0; i < calls.length; i++) {
      if (calls[i] === 'setDefaultConsentState') defaults++;
      if (calls[i] === 'injectScript') injections++;
    }
    assertThat(defaults).isEqualTo(1);
    assertThat(injections).isEqualTo(1);
    expectSuccess();
- name: '[Default] Sets the denied floor with security_storage granted and a 500 ms wait'
  code: |-
    runCode(createMockData());

    assertApi('setDefaultConsentState').wasCalledWith({
      ad_storage: 'denied',
      ad_user_data: 'denied',
      ad_personalization: 'denied',
      analytics_storage: 'denied',
      functionality_storage: 'denied',
      personalization_storage: 'denied',
      security_storage: 'granted',
      wait_for_update: 500
    });
    var defaults = 0;
    var i;
    for (i = 0; i < calls.length; i++) {
      if (calls[i] === 'setDefaultConsentState') defaults++;
    }
    assertThat(defaults).isEqualTo(1);
    expectSuccess();
- name: '[Namespace] Writes only dataLayer and gcmFloor, with the default data layer name'
  code: |-
    runCode(createMockData());

    assertApi('setInWindow').wasCalledWith('__stapeCmp', { dataLayer: 'dataLayer', gcmFloor: true }, false);
    assertThat(fakeWindow.__stapeCmp).isEqualTo({ dataLayer: 'dataLayer', gcmFloor: true });
    expectSuccess();
- name: '[Namespace] Writes a custom data layer name'
  code: |-
    runCode(createMockData({ dataLayerName: 'myLayer' }));

    assertThat(fakeWindow.__stapeCmp).isEqualTo({ dataLayer: 'myLayer', gcmFloor: true });
    expectSuccess();
- name: '[Namespace] An empty data layer name falls back to dataLayer'
  code: |-
    runCode(createMockData({ dataLayerName: '' }));

    assertThat(fakeWindow.__stapeCmp).isEqualTo({ dataLayer: 'dataLayer', gcmFloor: true });
    expectSuccess();
- name: '[Namespace] An absent data layer name falls back to dataLayer'
  code: |-
    runCode(createMockData({ dataLayerName: undefined }));

    assertThat(fakeWindow.__stapeCmp).isEqualTo({ dataLayer: 'dataLayer', gcmFloor: true });
    expectSuccess();
- name: '[Namespace] Writes nothing else on window and never reads or creates the data layer or gtag'
  code: |-
    runCode(createMockData({ dataLayerName: 'myLayer' }));

    var allowedReads = ['__stapeCmp'];
    var i;
    for (i = 0; i < calls.length; i++) {
      if (calls[i].indexOf('setInWindow:') === 0) {
        assertThat(calls[i]).isEqualTo('setInWindow:__stapeCmp');
      }
      if (calls[i].indexOf('copyFromWindow:') === 0) {
        assertThat(allowedReads.indexOf(calls[i].slice('copyFromWindow:'.length)) >= 0).isTrue();
      }
    }
    assertThat(fakeWindow.gtag).isUndefined();
    assertThat(fakeWindow.myLayer).isUndefined();
    assertThat(fakeWindow.dataLayer).isUndefined();
    expectSuccess();
- name: '[Order] Default, then the advanced settings, then the namespace, then the injection'
  code: |-
    runCode(createMockData({ adsDataRedaction: true }));

    var wanted = ['setDefaultConsentState', 'gtagSet', 'setInWindow:__stapeCmp', 'injectScript'];
    var seen = [];
    var i;
    for (i = 0; i < calls.length; i++) {
      if (wanted.indexOf(calls[i]) >= 0) seen.push(calls[i]);
    }
    assertThat(seen).isEqualTo(wanted);
    expectSuccess();
- name: '[TCF] With the box unticked, no __tcfapi is read or written'
  code: |-
    runCode(createMockData());

    assertThat(fakeWindow.__tcfapi).isUndefined();
    assertThat(fakeWindow.__stapeCmp).isEqualTo({ dataLayer: 'dataLayer', gcmFloor: true });
    var i;
    for (i = 0; i < calls.length; i++) {
      assertThat(calls[i]).isNotEqualTo('copyFromWindow:__tcfapi');
    }
    expectSuccess();
- name: '[TCF] With the box ticked, installs a queue-only __tcfapi and marks the namespace'
  code: |-
    runCode(createMockData({ tcf: true }));

    assertThat(fakeWindow.__stapeCmp).isEqualTo({ dataLayer: 'dataLayer', gcmFloor: true, tcfStub: true });
    var callback = function () {};
    fakeWindow.__tcfapi('addEventListener', 2, callback);
    var queue = fakeWindow.__tcfapi();
    assertThat(queue.length).isEqualTo(1);
    assertThat(queue[0][0]).isEqualTo('addEventListener');
    assertThat(queue[0][1]).isEqualTo(2);
    assertThat(queue[0][2] === callback).isTrue();
    expectSuccess();
- name: '[TCF] With the box ticked, a page that already has __tcfapi keeps it and the namespace has no tcfStub'
  code: |-
    var existing = function () {};
    fakeWindow.__tcfapi = existing;

    runCode(createMockData({ tcf: true }));

    assertThat(fakeWindow.__tcfapi === existing).isTrue();
    assertThat(fakeWindow.__stapeCmp).isEqualTo({ dataLayer: 'dataLayer', gcmFloor: true });
    assertApi('injectScript').wasCalled();
    expectSuccess();
- name: '[TCF] The queue is on the page before the namespace and the injection'
  code: |-
    runCode(createMockData({ tcf: true }));

    var wanted = ['setInWindow:__tcfapi', 'setInWindow:__stapeCmp', 'injectScript'];
    var seen = [];
    var i;
    for (i = 0; i < calls.length; i++) {
      if (wanted.indexOf(calls[i]) >= 0) seen.push(calls[i]);
    }
    assertThat(seen).isEqualTo(wanted);
    expectSuccess();
- name: '[TCF] A ticked box installs nothing on a page that already has __stapeCmp'
  code: |-
    fakeWindow.__stapeCmp = { dataLayer: 'dataLayer', gcmFloor: true };

    runCode(createMockData({ tcf: true }));

    assertThat(fakeWindow.__tcfapi).isUndefined();
    assertApi('setInWindow').wasNotCalled();
    expectSuccess();
- name: '[TCF] The queue keeps every command in order with its parameter'
  code: |-
    runCode(createMockData({ tcf: true }));

    fakeWindow.__tcfapi('getTCData', 2, function () {}, [1, 2]);
    fakeWindow.__tcfapi('ping', 2, function () {});
    var queue = fakeWindow.__tcfapi();

    assertThat(queue.length).isEqualTo(2);
    assertThat(queue[0][0]).isEqualTo('getTCData');
    assertThat(queue[0][3]).isEqualTo([1, 2]);
    assertThat(queue[1][0]).isEqualTo('ping');
    assertThat(queue[1][3]).isUndefined();
    expectSuccess();
- name: '[Advanced] No gtagSet while both boxes are unticked'
  code: |-
    runCode(createMockData());

    assertApi('gtagSet').wasNotCalled();
    expectSuccess();
- name: '[Advanced] Ticking Redact ads data sets ads_data_redaction only'
  code: |-
    runCode(createMockData({ adsDataRedaction: true }));

    assertApi('gtagSet').wasCalledWith({ ads_data_redaction: true });
    assertApi('gtagSet').wasNotCalledWith({ url_passthrough: true });
    expectSuccess();
- name: '[Advanced] Ticking Pass ad click information through URLs sets url_passthrough only'
  code: |-
    runCode(createMockData({ urlPassthrough: true }));

    assertApi('gtagSet').wasCalledWith({ url_passthrough: true });
    assertApi('gtagSet').wasNotCalledWith({ ads_data_redaction: true });
    expectSuccess();
- name: '[Advanced] Ticking both sets both'
  code: |-
    runCode(createMockData({ adsDataRedaction: true, urlPassthrough: true }));

    assertApi('gtagSet').wasCalledWith({ ads_data_redaction: true });
    assertApi('gtagSet').wasCalledWith({ url_passthrough: true });
    expectSuccess();
- name: '[Inject] The URL carries the container identifier and no lang when the page language is absent'
  code: |-
    assertThat(injectedUrl()).isEqualTo('https://abcdefgh.euf.stape.net/abcdefgh/cmp/bundle.js');
    expectSuccess();
- name: '[Inject] The URL carries the page language when it is given'
  code: |-
    assertThat(injectedUrl({ pageLanguage: 'fr-CA' })).isEqualTo('https://abcdefgh.euf.stape.net/abcdefgh/cmp/bundle.js?lang=fr-CA');
    expectSuccess();
- name: '[Inject] The URL carries no lang when the page language is empty'
  code: |-
    assertThat(injectedUrl({ pageLanguage: '' })).isEqualTo('https://abcdefgh.euf.stape.net/abcdefgh/cmp/bundle.js');
    expectSuccess();
- name: '[Inject] The URL carries no lang when the page language is only whitespace'
  code: |-
    assertThat(injectedUrl({ pageLanguage: '  \t ' })).isEqualTo('https://abcdefgh.euf.stape.net/abcdefgh/cmp/bundle.js');
    expectSuccess();
- name: '[Inject] The page language is trimmed'
  code: |-
    assertThat(injectedUrl({ pageLanguage: ' de-DE ' })).isEqualTo('https://abcdefgh.euf.stape.net/abcdefgh/cmp/bundle.js?lang=de-DE');
    expectSuccess();
- name: '[Inject] The URL carries no lang when the page language is not a string'
  code: |-
    assertThat(injectedUrl({ pageLanguage: 5 })).isEqualTo('https://abcdefgh.euf.stape.net/abcdefgh/cmp/bundle.js');
    expectSuccess();
- name: '[Inject] The page language is URL-encoded'
  code: |-
    assertThat(injectedUrl({ pageLanguage: 'en US&x=1' })).isEqualTo(
      'https://abcdefgh.euf.stape.net/abcdefgh/cmp/bundle.js?lang=en%20US%26x%3D1'
    );
    expectSuccess();
- name: '[Inject] A zone that starts with c is accepted'
  code: |-
    var url;
    mock('injectScript', function (u, onSuccess) {
      url = u;
      onSuccess();
    });
    runCode(createMockData({ stapeDomain: 'abcdefgh.cne.stape.net' }));
    assertThat(url).isEqualTo('https://abcdefgh.cne.stape.net/abcdefgh/cmp/bundle.js');
    expectSuccess();
- name: '[Inject] A stape io domain and the l variant are accepted'
  code: |-
    var url;
    mock('injectScript', function (u, onSuccess) {
      url = u;
      onSuccess();
    });
    runCode(createMockData({ stapeDomain: 'ijklmnop.lgsr.stape.io' }));
    assertThat(url).isEqualTo('https://ijklmnop.lgsr.stape.io/ijklmnop/cmp/bundle.js');
    expectSuccess();
- name: '[Inject] A loaded script reports success'
  code: |-
    mock('injectScript', function (url, onSuccess, onFailure) {
      onSuccess();
    });

    runCode(createMockData());

    assertApi('gtmOnSuccess').wasCalled();
    assertApi('gtmOnFailure').wasNotCalled();
- name: '[Inject] A script that fails to load reports failure'
  code: |-
    mock('injectScript', function (url, onSuccess, onFailure) {
      onFailure();
    });

    runCode(createMockData());

    assertApi('gtmOnFailure').wasCalled();
    assertApi('gtmOnSuccess').wasNotCalled();
- name: '[Validation] Rejects a host outside stape net and stape io'
  code: |-
    expectRejected({ stapeDomain: 'abcdefgh.euf.example.com' });
- name: '[Validation] Rejects a look-alike suffix'
  code: |-
    expectRejected({ stapeDomain: 'abcdefgh.euf.stape.net.evil.com' });
- name: '[Validation] Rejects a host that only ends in the suffix text'
  code: |-
    expectRejected({ stapeDomain: 'abcdefgh.eufstape.net' });
- name: '[Validation] Rejects an apex host with no container label'
  code: |-
    expectRejected({ stapeDomain: 'euf.stape.net' });
- name: '[Validation] Rejects a host with extra labels'
  code: |-
    expectRejected({ stapeDomain: 'a.abcdefgh.euf.stape.net' });
- name: '[Validation] Rejects a value with a scheme'
  code: |-
    expectRejected({ stapeDomain: 'https://abcdefgh.euf.stape.net' });
- name: '[Validation] Rejects a value with a path'
  code: |-
    expectRejected({ stapeDomain: 'abcdefgh.euf.stape.net/x' });
- name: '[Validation] Rejects a value with a port'
  code: |-
    expectRejected({ stapeDomain: 'abcdefgh.euf.stape.net:8443' });
- name: '[Validation] Rejects a value with a space'
  code: |-
    expectRejected({ stapeDomain: 'abcdefgh.euf.stape.net ' });
- name: '[Validation] Rejects an upper-case host'
  code: |-
    expectRejected({ stapeDomain: 'ABCDEFGH.euf.stape.net' });
- name: '[Validation] Rejects an empty Stape domain'
  code: |-
    expectRejected({ stapeDomain: '' });
- name: '[Validation] Rejects a missing Stape domain'
  code: |-
    expectRejected({ stapeDomain: undefined });
- name: '[Validation] Rejects a Stape domain that is not a string'
  code: |-
    expectRejected({ stapeDomain: 12345 });
- name: '[Validation] Rejects a host whose zone is not followed by stape'
  code: |-
    expectRejected({ stapeDomain: 'abcdefgh.euf.notstape.net' });
- name: '[Validation] Rejects a stape host with another top-level domain'
  code: |-
    expectRejected({ stapeDomain: 'abcdefgh.euf.stape.com' });
- name: '[Validation] Rejects an empty container label'
  code: |-
    expectRejected({ stapeDomain: '.euf.stape.net' });
- name: '[Validation] Rejects an empty zone label'
  code: |-
    expectRejected({ stapeDomain: 'abcdefgh..stape.net' });
- name: '[Validation] Rejects a label longer than 63 characters'
  code: |-
    var label = 'a123456789b123456789c123456789d123456789e123456789f123456789g123';
    assertThat(label.length).isEqualTo(64);

    expectRejected({ stapeDomain: label + '.euf.stape.net' });
- name: '[Validation] Accepts a label of exactly 63 characters'
  code: |-
    var label = 'a123456789b123456789c123456789d123456789e123456789f123456789g12';
    assertThat(label.length).isEqualTo(63);

    assertThat(injectedUrl({ stapeDomain: label + '.euf.stape.net' })).isEqualTo(
      'https://' + label + '.euf.stape.net/' + label + '/cmp/bundle.js'
    );
    expectSuccess();
- name: '[Validation] Rejects a label that starts with a hyphen'
  code: |-
    expectRejected({ stapeDomain: '-abcdefgh.euf.stape.net' });
- name: '[Validation] Rejects a label that ends with a hyphen'
  code: |-
    expectRejected({ stapeDomain: 'abcdefgh-.euf.stape.net' });
- name: '[Validation] Rejects a label with an underscore'
  code: |-
    expectRejected({ stapeDomain: 'abcd_efgh.euf.stape.net' });
- name: '[Validation] Accepts hyphens inside a label'
  code: |-
    assertThat(injectedUrl({ stapeDomain: 'abcd-efgh.e-uf.stape.net' })).isEqualTo(
      'https://abcd-efgh.e-uf.stape.net/abcd-efgh/cmp/bundle.js'
    );
    expectSuccess();
setup: |-
  var fakeWindow = {};
  var calls = [];

  var baseMockData = {
    stapeDomain: 'abcdefgh.euf.stape.net',
    tcf: false,
    adsDataRedaction: false,
    urlPassthrough: false,
    dataLayerName: 'dataLayer'
  };

  function createMockData(overrides) {
    var result = {};
    var key;
    for (key in baseMockData) {
      result[key] = baseMockData[key];
    }
    overrides = overrides || {};
    for (key in overrides) {
      result[key] = overrides[key];
    }
    return result;
  }

  mock('copyFromWindow', function (key) {
    calls.push('copyFromWindow:' + key);
    return fakeWindow[key];
  });
  mock('setInWindow', function (key, value) {
    calls.push('setInWindow:' + key);
    fakeWindow[key] = value;
    return true;
  });
  mock('setDefaultConsentState', function () {
    calls.push('setDefaultConsentState');
  });
  mock('gtagSet', function () {
    calls.push('gtagSet');
  });
  mock('injectScript', function (url, onSuccess) {
    calls.push('injectScript');
    onSuccess();
  });

  function expectRejected(overrides) {
    runCode(createMockData(overrides));

    assertApi('gtmOnFailure').wasCalled();
    assertApi('gtmOnSuccess').wasNotCalled();
    assertApi('setDefaultConsentState').wasNotCalled();
    assertApi('gtagSet').wasNotCalled();
    assertApi('setInWindow').wasNotCalled();
    assertApi('injectScript').wasNotCalled();
  }

  function expectSuccess() {
    assertApi('gtmOnSuccess').wasCalled();
    assertApi('gtmOnFailure').wasNotCalled();
  }

  function injectedUrl(overrides) {
    var url;
    mock('injectScript', function (u, onSuccess) {
      url = u;
      onSuccess();
    });
    runCode(createMockData(overrides));
    return url;
  }


___NOTES___

2026-10-21 - Change Notes:
  - Add the Stape CMP tag: on Consent Initialization it sets the denied Consent Mode default (security_storage granted, 500 ms wait for the CMP) and loads the CMP bundle from the container's Stape domain, so sites that load GTM from googletagmanager.com get the banner without the Custom Loader
  - Stand down when window.__stapeCmp already exists, so a page the Custom Loader serves, a duplicated tag or a second container never gets a second default or a second bundle; otherwise record the data layer name and the Consent Mode floor marker there for the CMP runtime, the only global the tag can access
  - Add the IAB TCF option: when ticked, the tag installs a queue-only __tcfapi before Google's tags load, so they read the visitor's TC String, and marks the namespace with tcfStub; an existing __tcfapi is left untouched
  - Add Advanced settings for ads data redaction, URL passthrough, a custom data layer name and an optional Page language that is passed to the CMP as ?lang=, since the template cannot read the html lang attribute itself; reject a Stape domain that is not a *.stape.net or *.stape.io container host
  - Add unit tests and Stape-style help texts, including where to find the Stape domain in the Stape Admin panel

Created on 10/16/2026, 10:30:00 PM
