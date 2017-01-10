// Changer une LOV
var vFormPanel = EAM.Utils.getScreen().getCurrentTab().getFormPanel();
try{
	vFormPanel.getFld('udfchar28').size = vFormPanel.getFld('description').size;
	vFormPanel.getForm().findField("customer").lookupLOV = {
		lovName : "LVCUST",
		inputFields: {
			"control.org": "organization",
			"parameter.employee": "issueto"
		},
		 returnFields: {
			"customer": "customercode",
			"customerorg": "customerorganization",
			"issueto": "employee",
			"udfchar28" : "customerdesc"
		}
	};
	vFormPanel.getForm().findField("customer").validateLOV = {
		lovName : "LVCUST",
		inputFields: {
			"control.org": "organization",
			"parameter.employee": "issueto"
		},returnFields : {
			"customer": "customercode",
			"customerorg": "customerorganization",
			"issueto": "employee",
			"udfchar28" : "customerdesc"
		},extraPKFields: ["customerorg"],
		clearFields: ["customerorg"]
	};
}
catch (e) {}


// Hyperlink
var vFormPanel = EAM.Utils.getScreen().getCurrentTab().getFormPanel();
var vWorkOrderNum = vFormPanel.getFldValue("workordernum");
vFormPanel.setFldValue("cust_1_CHAR_EVNT_HYPLINK","CLIQUER ICI",true);
vFormPanel.setFldValue("cust_1_CHAR_EVNT_HYPLINK","CLIQUER ICI",true);
console.log("cust_1_CHAR_EVNT_HYPLINK")
$('[name=cust_1_CHAR_EVNT_HYPLINK]').unbind('dblclick');
$('[name=cust_1_CHAR_EVNT_HYPLINK]').dblclick(function (sender) {
	var vField,
	vFieldVal,
	vFieldName;
	g = {
				SYSTEM_FUNCTION_NAME: "BSHYPL",
				USER_FUNCTION_NAME: "BSHYPL",
				ONLY_DATA_REQUIRED: true,
				pageaction: "",
				destfield:'udfchar06',
				destpagename: 'OSOBJA',
				sourcefield: 'workordernum',
				sourcepagename: 'EIDATT_HDR',
				hyperlinklinenum: '10'
			};
	var v= EAM.Ajax.request({
		url: "GOTO",
		params: g
	});
					
	var g = {
				CURRENT_TAB_NAME : "HDR",
				MENU_MODULE_KEY : "-1",
				SYSTEM_FUNCTION_NAME : "OSOBJA",
				USER_FUNCTION_NAME : "OSOBJA",
				uitheme : EAM.AppData.getUITheme(),
				fromlogin : "yes",
				hyperlinksource : "F",
				initpath : "OSOBJA",
				popup : "TRUE",
				skipfirstfunccheck : true,
				destfield :'udfchar06',
				sourcefield : 'workordernum',
				sourcepagename :'EIDATT_HDR'
			};
	a = ["hyperlink", 1, "I:WEBL", "udfchar06",vWorkOrderNum,"workordernum"];							
	EAM.ContextManager.getEAM("parent").Usage.start("screen_hyperlink");
	var b = EAM.Utils.createModal({
			header : false,
			parentContext : window
		});							
	b.show();
	b.update("loadmain?" + Ext.Object.toQueryString(g), a)							
});



//Modifier taille d'un champs
vFormPanel.getFld('udfchar28').size = vFormPanel.getFld('description').size;
//ou
vFormPanel.getFld('wspf_10_designation').size = 100;





//pagemode
vFormPanel.getFldValue("pagemode") == "display"






//Recupérer valeur
var vDemande = vFormPanel.getFldValue('wspf_10_demande');

var vHDR = EAM.Ajax.request({
		url: "GRIDDATA",
		params: {
			SYSTEM_FUNCTION_NAME: "EUDEM2",
			USER_FUNCTION_NAME: "EUDEM2",
			MADDON_FILTER_ALIAS_NAME_1: "customerrentalcode",
			MADDON_FILTER_OPERATOR_1: "=",
			MADDON_FILTER_JOINER_1: "AND",
			MADDON_FILTER_SEQNUM_1: "1",
			MADDON_FILTER_VALUE_1: vDemande
		}
	});
if (vHDR.responseData.pageData.grid.GRIDRESULT.GRID.DATA.length == 1) {
	var vDateDebut = new Date(vHDR.responseData.pageData.grid.GRIDRESULT.GRID.DATA[0].datedebutchantier);
	var vDateFin = new Date(vHDR.responseData.pageData.grid.GRIDRESULT.GRID.DATA[0].datefinchantier);

	vFormPanel.setFldValue("wspf_10_date_debut", vDateDebut, true);
	vFormPanel.setFldValue("wspf_10_date_fin", vDateFin, true);
}



