const callInWindow = require('callInWindow');
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
const cmpId = data.cmpId;
const dataLayerName = data.dataLayerName || 'dataLayer';

if (!isStapeDomain(stapeDomain) || !isCmpId(cmpId)) return data.gtmOnFailure();

if (copyFromWindow('__stapeCmp')) return data.gtmOnSuccess();

gtagSet('developer_id.dNjQ3Nj', true);

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
if (data.uet) {
  setInWindow('uetq', [], false);
  callInWindow('uetq.push', 'consent', 'default', { ad_storage: 'denied' });
  namespace.uetFloor = true;
}
setInWindow('__stapeCmp', namespace, false);

const bundleUrl = getBundleUrl(stapeDomain, cmpId);
injectScript(bundleUrl, data.gtmOnSuccess, data.gtmOnFailure, bundleUrl);

/*==============================================================================
Helpers
==============================================================================*/

function getBundleUrl(domain, cmpId) {
  const identifier = domain.split('.')[0];
  const language = getLanguage();
  const query = language ? '?lang=' + encodeUriComponent(language) : '';

  return 'https://' + domain + '/' + identifier + '/cmp/v1/' + cmpId.toLowerCase() + '/bundle.js' + query;
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

// 8-4-4-4-12 hex digits, in either case
function isCmpId(id) {
  if (getType(id) !== 'string' || id.length !== 36) return false;

  const hex = '0123456789abcdefABCDEF';
  for (let i = 0; i < id.length; i++) {
    const char = id.charAt(i);
    if (i === 8 || i === 13 || i === 18 || i === 23) {
      if (char !== '-') return false;
    } else if (hex.indexOf(char) < 0) {
      return false;
    }
  }
  return true;
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
