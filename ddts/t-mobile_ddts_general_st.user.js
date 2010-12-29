// ==UserScript==
// @name        T-Mobile DDTS: General Style for alle DDTS pages
// @namespace   https://ddts.devlab.de.tmo/general
// @include     https://ddts.devlab.de.tmo/*
// ==/UserScript==

document.body.setAttribute("bgColor", "#ffffff");
//document.body.setAttribute("style", "font-family:arial;font-size:72%;");

var styleTag = document.createElement("style");
var styleText = document.createTextNode("body {font-family:arial;} th,td {font-size:12px;padding:2px;} h2, p {margin:3px;} table {border-spacing:0px; border-collapse:collapse; margin:0px 3px;}");
styleTag.appendChild(styleText);
document.body.appendChild(styleTag);