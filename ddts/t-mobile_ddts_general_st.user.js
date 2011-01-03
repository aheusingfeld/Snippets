// ==UserScript==
// @name        T-Mobile DDTS: General Style
// @namespace   https://ddts.devlab.de.tmo/general
// @include     https://ddts.devlab.de.tmo/*
// ==/UserScript==

document.body.setAttribute("bgColor", "#ffffff");
//document.body.setAttribute("style", "font-family:arial;font-size:72%;");

var styleTag = document.createElement("style");
var styleText = document.createTextNode("body {font-family:arial;} \
	a {color:#003366;} \
	th,td {font-size:12px;padding:2px;border:0px;} \
	th {background-color:#f0f0f0;} \
	h2, p {margin:3px;} \
	input, select { border:1px solid #999; } \
	hr {clear:both; border:1px solid #f0f0f0; } \
	table {border-spacing:0px; border-collapse:collapse; margin:3px; border:1px solid #bbbbbb;}");
styleTag.appendChild(styleText);
document.body.appendChild(styleTag);