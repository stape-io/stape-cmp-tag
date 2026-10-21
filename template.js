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
