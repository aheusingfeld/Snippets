// ==UserScript==
// @name        T-Mobile DDTS: Style DDTS Tickets more user friendly
// @namespace   https://ddts.devlab.de.tmo/wt/tmp/dump
// @include     https://ddts.devlab.de.tmo/wt/tmp/dump_*
// @include     https://ddts.devlab.de.tmo/ddts/ddts_main?*bug_id*
// @include     https://ddts.devlab.de.tmo/ddts/ddts_main
// @require     http://code.jquery.com/jquery-1.9.1.min.js
// ==/UserScript==

$("<div id='navbar'></div>").prependTo("body")
$("td > strong:contains('Change state to')").parents("table").appendTo("#navbar").addClass("actions");
$("td > a:contains('Problem')").parents("table").appendTo("#navbar").addClass("linklist");
$("<ul id='enclosures'></ul>").appendTo("#navbar")
$(".linklist br").remove();
$(".linklist img").remove();
$(".linklist a").wrap('<li>');
$(".linklist li").appendTo('ul#enclosures');
$(".linklist").remove();
$("center strong a[name]").css("padding-top", "80px").css("display", "block");
$("<style>\
	body {background-color: #fff; padding-top:80px;}\
	table, br {float:left;} \
	#navbar {position: fixed; top: 0px; left: 0px; width:100%; background-color: #eee; display:inline; margin:0; padding:0; border-bottom:1px solid #ccc;}\
	.actions * {width:auto; font-size: 11px; }\
	.actions a {font-weight: bold;}\
	.actions form, .actions input, .actions select {margin:0; padding:0;}\
	#enclosures {list-style:none; margin:0px; padding:0px; text-indent:0px; font-size: 11px; line-height:2em; }\
	#enclosures li {display:inline; margin:2px; padding:0px; text-indent:0px;}\
	#enclosures a {border:1px solid #999; background-color: #ccc; padding:2px; text-decoration:none;}\
	a br {float:none;} \
	xmp {background-color:#f0f0f0; margin-left:1em;} \
	center { text-align:left; } \
	hr {clear:both}\
	</style>").appendTo("head");

// -------------------------------------------------------------------
// "Create JIRA issue" link after this line
// see https://confluence.atlassian.com/display/JIRA/Creating+Issues+via+direct+HTML+links

function getNextTDSibling(node) {
    if (node == null || node.nextSibling == null || "TH" === node.nextSibling.nodeName.toUpperCase())
        return null;

    if (node.nextSibling.textContent == '\n' )
        return getNextTDSibling(node.nextSibling);

    return node.nextSibling.textContent;
}
function getXmpHeading(node) {
    if (node.previousSibling == null)
        return null;

    if (node.previousSibling.textContent == '\n' )
        return getXmpHeading(node.previousSibling);

    if (node.previousSibling.firstChild == null || node.previousSibling.firstChild.firstChild == null)
        return null;

    return node.previousSibling.firstChild.firstChild.textContent;
}

function getJiraDescription(attributes) {
    var result = "DDTS Link: ["+ attributes['Bug'] + "|https://ddts.devlab.de.tmo/ddts/ddts_main?LastForm=DumpBug&bug_id=" + attributes['Bug'] + "]\n" +
        "Gerrit Code Review: [Gerrit|https://tmv517.devlab.de.tmo:8100/]\n\n";
    var ddtsEnclosures = Iterator(attributes['ddtsEnclosures'], true);
    for (var key in ddtsEnclosures) {
        //if ("History" !== key)
            result += "h3. " + key + "\n{code}" + attributes['ddtsEnclosures'][key] + "{code}\n\n"
    }
    return result;
}

var jiraProjects = { 'tvpp_d' : '10041', 'ikdb_ms_d' : '10041', 'ikdb_tsg_d' : '10041', 'hck_d' : '10041', 'tvpp_batch_d' : '10041', 'tvpp_c' : '10041', 'tvpptask_c' : '10041', 'tvpp_b2b_d' : '10050'};
var jiraComponents = { 'tvpp_d' : '10452', 'ikdb_ms_d' : '10920', 'ikdb_tsg_d' : '11100', 'hck_d' : '11100', 'tvpp_batch_d' : '11380', 'tvpp_c' : '12020', 'tvpptask_c' : '12020', 'tvpp_b2b_d' : ''};
var myDDTSAttributeMap = {};
elementList = document.getElementsByTagName("th");
for (var i = 0; i<elementList.length; i++)
{
    var siblingValue = getNextTDSibling(elementList[i]);
    if (siblingValue != null)
    {
        myDDTSAttributeMap[elementList[i].textContent] = siblingValue;
    }
}
// get DDTS enclosures
elementList = document.getElementsByTagName("xmp");
var ddtsEnclosures = {};
for (var i = 0; i<elementList.length; i++) {
    var heading = getXmpHeading(elementList[i]);
    if (heading != null && elementList[i].textContent != null)
    {
        ddtsEnclosures[heading] = elementList[i].textContent;
    }
}
myDDTSAttributeMap['ddtsEnclosures'] = ddtsEnclosures;

$("<td><form id='toDevlabJira' name='toDevlabJira' method='post' target='_blank' accept-charset='UTF-8' \
 onsubmit='this.description.value = unescape(this.description.value);' \
 action='https://jira.devlab.de.tmo/secure/CreateIssueDetails!init.jspa?issuetype=1&pid=" 
	+ jiraProjects[myDDTSAttributeMap['Project']]
	+ "'>\
	<input type='submit' name='submit' value='To DevlabJIRA'>\
	<input type='hidden' name='summary' value='" + myDDTSAttributeMap['Bug'] + " - " + myDDTSAttributeMap['Headline'] + "'>\
	<input type='hidden' name='description' value='" + escape(getJiraDescription(myDDTSAttributeMap)) + "'>\
	<input type='hidden' name='reporter' value='mannana'>\
	<input type='hidden' name='assignee' value='" + myDDTSAttributeMap['Assigned engineer'] + "'>\
	<input type='hidden' name='components' value='" + jiraComponents[myDDTSAttributeMap['Project']] + "'>\
	<input type='hidden' name='priority' value='" + myDDTSAttributeMap['Severity'] + "'>\
	<input type='hidden' name='customfield_10000' value='" + myDDTSAttributeMap['Bug'] + "'>\
	<input type='hidden' name='environment' value='" + "Submitter: " + myDDTSAttributeMap['Submitter']
        + "\nFound in environment: " + myDDTSAttributeMap['Found in environment']
        + "\nProject release: " + myDDTSAttributeMap['Project release']
        + "\nProject build: " + myDDTSAttributeMap['Project build'] + "'>\
	</form></td>")
	.appendTo(".actions tr:last")

// for debugging
/*
textarea = document.createElement("textarea");
textarea.appendChild(document.createTextNode(JSON.stringify(myDDTSAttributeMap, undefined, 2)));
textarea.setAttribute("style", "width:500px;height:200px;");
document.body.insertBefore(textarea, document.body.firstChild);
*/


