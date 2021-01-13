// --
// Copyright (C) 2019–present Efflux GmbH, https://efflux.de/
// Part of the CustomJavaScript package.
// --
// This software comes with ABSOLUTELY NO WARRANTY. For details, see
// the enclosed file COPYING for license information (GPL). If you
// did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
// --

'use strict';

var Core = Core || {};
Core.Agent = Core.Agent || {};
Core.Agent.Admin = Core.Agent.Admin || {};

Core.Agent.Admin.CustomJavaScript = (function(TargetNS) {
	let JavaScriptCodeMirror;

	TargetNS.Init = function () {
		CKEDITOR.on('instanceReady', function(Editor) {
			$('.cke_button__autocomplete').hide()
			$('.cke_button__maximize ').hide()

			JavaScriptCodeMirror = $('.CodeMirror')[0].CodeMirror;
			JavaScriptCodeMirror.setOption('mode', 'text/javascript');
		});

		$('#TemplateAgentName').on('click', function() {
			TargetNS.TemplateAgentName();
		});

		$('#TemplateSpecificAction').on('click', function() {
			TargetNS.TemplateSpecificAction();
		});

		$('#ExportJavaScript').on('click', function() {
			TargetNS.ExportJavaScript();
		});

	};

	TargetNS.InsertText = function(Text) {
		JavaScriptCodeMirror.replaceRange("\n" + Text, {line: Infinity});
	}

	TargetNS.ExportJavaScript = function() {
		// Create a download element, run, and delete it afterwards.
		const Value = 'data:text/javascript;charset=utf-8,' + encodeURIComponent(JavaScriptCodeMirror.getValue());

		let FileString = document.createElement('a');
		$(FileString).attr({'href': Value, 'download': 'Core.Agent.CustomJavaScript.js'}).hide();;

		$(document.body).append(FileString);
		FileString.click();
		FileString.remove();
	}

	TargetNS.TemplateAgentName = function() {
		const JavaScript = 
			"/* Console.log the name of the current agent. */\n" +
			"const AgentName = $('#ToolBar > li.UserAvatar > div > span').html();\n" +
			"console.log(AgentName);\n";
		TargetNS.InsertText(JavaScript);
	}

	TargetNS.TemplateSpecificAction = function() {
		const JavaScript = 
			"const Action = Core.Config.Get('Action');\n" +
			"\n" +
			"/* Only execute this code on the AgentTicketZoom screen. */\n" +
			"if (Action == 'AgentTicketZoom') {\n" +
			"    console.log('Ticket overview');\n" +
			"}\n";

		TargetNS.InsertText(JavaScript);
	}

	Core.Init.RegisterNamespace(TargetNS, 'APP_MODULE');

	return TargetNS;
}(Core.Agent.Admin.CustomJavaScript || {}));
