// flash@1.1.0 downloaded from https://ga.jspm.io/npm:flash@1.1.0/index.js

import s from"assert";var e="undefined"!==typeof globalThis?globalThis:"undefined"!==typeof self?self:global;var a={};var r=s;a=function(){return function(s,e,a){r(s.session,"a req.session is required!");Array.isArray(s.session.flash)||(s.session.flash=[]);e.locals.flash=s.session.flash;s.flash=e.flash=push;a()}};function push(s,a){if(!a){a=s;s="info"}a={message:a,type:s};var r=(this||e).res||this||e;var i=r.locals.flash;for(var f=0;f<i.length;f++){var l=i[f];if(a.type===l.type&&a.message===l.message)return this||e}i.push(a);return this||e}var i=a;export default i;

