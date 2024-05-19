<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
// Database connection details
String url = "jdbc:derby://localhost:1527/Device";
String user = "minh";
String password = "minh";

// Retrieve form data
String name = request.getParameter("name");
String type = request.getParameter("type");


try {
    // Establish database connection
    Class.forName("org.apache.derby.jdbc.ClientDriver");
    Connection conn = DriverManager.getConnection(url, user, password);

    // Create SQL query to search for device
    String sql = "SELECT * FROM UNTITLED WHERE name = ? AND type = ?";
    PreparedStatement statement = conn.prepareStatement(sql);
    statement.setString(1, name);
    statement.setString(2, type);

    out.println("Device information, encrypted code: " + statement.toString() + "<br>");

    // Execute the query
    ResultSet result = statement.executeQuery();
    
    if (result.next()) {
        out.println("Device ID: " + result.getString("deviceID") + "<br>");
        out.println("Name: " + result.getString("name") + "<br>");
        out.println("Type: " + result.getString("type") + "<br>");
        out.println("Price: " + result.getDouble("price") + "<br>");
        out.println("Quantity: " + result.getInt("quantity") + "<br>");
        out.println("Availability: " + result.getString("availability") + "<br>");

        // Redirect to the main page where the update and delete buttons will be displayed
        
    } else {
        out.println("Device not found.");
    }

    // Close connection
    conn.close();
    
} catch (Exception ex) {
    out.println("Error: " + ex.getMessage());
    
}
%>

