<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Connection conn = null;
	Statement stmt = null;
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","1234");
		stmt = conn.createStatement();
		
		String query = "select * from sample order by idx desc";
		ResultSet rs = stmt.executeQuery(query);
		
		Map<String,Object> m = null;
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		
		while(rs.next()){
			int idx = rs.getInt("idx");
			String content = rs.getString("content");
			m = new HashMap<String,Object>();
			m.put("idx", idx);
			m.put("content", content);
			list.add(m);
		}
		rs.close();
		request.setAttribute("list", list);
	}
	catch(Exception e) {
		e.printStackTrace();
	}
	finally {
		try{if(stmt != null) { stmt.close();}}catch(SQLException e){}
		try{if(conn != null) { conn.close();}}catch(SQLException e){}
	}
%>    
<c:choose>
	<c:when test="${fn:length(list) > 0 }">
		<c:forEach items="${list}" var="list">
			<tr>
				<td width="30%">
					${list.idx }
				</td>
				<td>
					${list.content }
				</td>
			</tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="2">
				목록이 존재하지 않습니다
			</td>
		</tr>
	</c:otherwise>
</c:choose>