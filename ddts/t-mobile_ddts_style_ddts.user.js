// ==UserScript==
// @name        T-Mobile DDTS: Style DDTS Tickets more user friendly
// @namespace   https://ddts.devlab.de.tmo/wt/tmp/dump
// @include     https://ddts.devlab.de.tmo/wt/tmp/dump_*
// @include     https://ddts.devlab.de.tmo/ddts/ddts_main?bug_id*
// ==/UserScript==

document.body.setAttribute("bgColor", "#ffffff");

var styleTag = document.createElement("style");
var styleText = document.createTextNode(
	"table, br {float:left;} \
	a br {float:none;} \
	xmp {background-color:#f0f0f0; margin-left:2em;} \
	center { text-align:left; } \
	");
styleTag.appendChild(styleText);
document.body.appendChild(styleTag);