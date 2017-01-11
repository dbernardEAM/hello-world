<%@page language="java" contentType="text/xml; charset=UTF-8"
	import="java.util.*" 
	import="java.lang.*" 
	import="java.io.*" 
	import="java.sql.Connection"
	import="java.sql.DatabaseMetaData" 
	import="java.sql.ResultSet"
	import="java.sql.SQLException" 
	import="java.sql.Statement"
	import="java.sql.CallableStatement" 
	import="java.sql.PreparedStatement"
	import="java.sql.DriverManager" 
	import="javax.sql.DataSource"
	import="java.sql.Types" 
	import="javax.naming.Context"
	import="javax.naming.InitialContext"
	import="java.text.CharacterIterator"
	import="java.text.StringCharacterIterator"
	import="com.dstm.mp.web.event.IServletConstants"
	import="com.dstm.mp.web.model.base.SessionUser"
	import="com.dstm.mp.web.util.tab.TabGeneratorBase"
	import="net.sf.json.JSONObject"
%>
<%
    response.setContentType("text/json");
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
	response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
	response.addHeader("Cache-Control", "post-check=0, pre-check=0");
%>
<%
    JSONObject json = new JSONObject();
    
	String vUserid 		= "";
    String vTenantId 	= "";
	
	String vField		= "";
	String vValue1		= "";
	String vValue2		= "";
	String vValue3		= "";
	String vValue4		= "";
	String vValue5		= "";
	String vStatus		= "";
    
    vUserid 	= request.getParameter("userid");
    vTenantId 	= request.getParameter("tenantid");
    
	vField		= request.getParameter("field");
	vValue1		= request.getParameter("value1");
    vValue2		= request.getParameter("value2");
	vValue3		= request.getParameter("value3");
	vValue4		= request.getParameter("value4");
	vValue5		= request.getParameter("value5");
	
	/*vField		= "DEBUG";
	vValue1		= "";
    vValue2		= "";
	vValue3		= "";
	vValue4		= "";
	vValue5		= "";*/
	
	
    //Info de Session InforEAM
    Connection vConnection 			= null;
    CallableStatement vStatement 	= null;
    ResultSet vResultSet 			= null;
    
	try
    {
		vConnection = TabGeneratorBase.getConnection(vTenantId);
		vStatement 	= vConnection.prepareCall("{ CALL TIS_GETVALUEOF(?,?,?,?,?,?,?) }");
		
		vStatement.setString(1, vField);
		vStatement.setString(2, vValue1);
		vStatement.setString(3, vValue2);
		vStatement.setString(4, vValue3);
		vStatement.setString(5, vValue4);
		vStatement.setString(6, vValue5);
		
		vStatement.registerOutParameter(2, java.sql.Types.VARCHAR);
		vStatement.registerOutParameter(3, java.sql.Types.VARCHAR);
		vStatement.registerOutParameter(4, java.sql.Types.VARCHAR);
		vStatement.registerOutParameter(5, java.sql.Types.VARCHAR);
		vStatement.registerOutParameter(6, java.sql.Types.VARCHAR);
		vStatement.registerOutParameter(7, java.sql.Types.VARCHAR);
		
		vStatement.execute();
		
		vStatus = vStatement.getString(7);
		vValue1 = vStatement.getString(2);
		vValue2 = vStatement.getString(3);
		vValue3 = vStatement.getString(4);
		vValue4 = vStatement.getString(5);
		vValue5 = vStatement.getString(6);
	}
    catch (SQLException e)
    {
		vStatus = "ERROR";
		vValue1 = "JSP";
        vValue2 = e.getMessage();                       
    }
    finally
    {
      TabGeneratorBase.closeQuery(vStatement, vResultSet);
      TabGeneratorBase.closeConnection(vConnection);
    }
	
    json.put("status", vStatus);
	json.put("field", vField);
    json.put("value1", vValue1);
	json.put("value2", vValue2);
	json.put("value3", vValue3);
	json.put("value4", vValue4);
	json.put("value5", vValue5);
	
	/*json.put("success","true");
	json.put("installparam", vStatus);  
	json.put("codeparam", vValue1); 
	json.put("userid", vField);*/  
		
    out.println(json.toString());
%>
