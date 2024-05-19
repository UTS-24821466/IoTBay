<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    // Database connection details
    String url = "jdbc:derby://localhost:1527/Device";
    String user = "minh";
    String password = "minh";
%>
<%
if (request.getParameter("newName") == null) {
    // Part 1: Search for the device
    String name = request.getParameter("name");
    String type = request.getParameter("type");

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection conn = DriverManager.getConnection(url, user, password);

        String sql = "SELECT * FROM UNTITLED WHERE name = ? AND type = ?";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setString(1, name);
        statement.setString(2, type);

        ResultSet result = statement.executeQuery();

        if (result.next()) {
            out.println("<form action='updateDevice.jsp' method='post'>");
            out.println("Device ID: <input type='text' name='newID' value='" + result.getString("deviceID") + "'><br>");
            out.println("Name: <input type='text' name='newName' value='" + result.getString("name") + "'><br>");
            out.println("Type: <input type='text' name='newType' value='" + result.getString("type") + "'><br>");
            out.println("Price: <input type='text' name='newPrice' value='" + result.getDouble("price") + "'><br>");
            out.println("Quantity: <input type='text' name='newQuantity' value='" + result.getInt("quantity") + "'><br>");
            out.println("Availability: <input type='text' name='newAvailability' value='" + result.getString("availability") + "'><br>");
            out.println("<input type='hidden' name='name' value='" + name + "'>");
            out.println("<input type='hidden' name='type' value='" + type + "'>");
            out.println("<input type='submit' value='Update'>");
            out.println("</form>");
        } else {
            out.println("Device not found.");
        }

        conn.close();
    } catch (Exception ex) {
        out.println("Error: " + ex.getMessage());
    }
} else {
    // Part 2: Update the device information
    
    String name = request.getParameter("name");
    String type = request.getParameter("type");
    String newID = request.getParameter("newID");
    String newName = request.getParameter("newName");
    String newType = request.getParameter("newType");
    double newPrice = Double.parseDouble(request.getParameter("newPrice"));
    int newQuantity = Integer.parseInt(request.getParameter("newQuantity"));
    String newAvailability = request.getParameter("newAvailability");

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection conn = DriverManager.getConnection(url, user, password);

        String sql = "UPDATE UNTITLED SET deviceid = ?, name = ?, type = ?, price = ?, quantity = ?, availability = ? WHERE name = ? AND type = ?";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setString(1, newID);
        statement.setString(2, newName);
        statement.setString(3, newType);
        statement.setDouble(4, newPrice);
        statement.setInt(5, newQuantity);
        statement.setString(6, newAvailability);
        statement.setString(7, name);
        statement.setString(8, type);

        int rowsUpdated = statement.executeUpdate();

        if (rowsUpdated > 0) {
            out.println("Device information updated successfully.");
        } else {
            out.println("Error updating device information.");
        }

        conn.close();
        
    } catch (Exception ex) {
        out.println("Error: " + ex.getMessage());
    }
}
%>
