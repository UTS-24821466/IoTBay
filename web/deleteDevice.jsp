<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    // Database connection details
    String url = "jdbc:derby://localhost:1527/Device";
    String user = "minh";
    String password = "minh";
%>
<%
if (request.getParameter("confirmDelete") == null) {
    // Part 1: Search for the device
    String name = request.getParameter("name");
    String type = request.getParameter("type");

    if (name != null && type != null) {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(url, user, password);

            String sql = "SELECT * FROM UNTITLED WHERE name = ? AND type = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, name);
            statement.setString(2, type);

            ResultSet result = statement.executeQuery();

            if (result.next()) {
                out.println("Device ID: " + result.getString("deviceID") + "<br>");
                out.println("Name: " + result.getString("name") + "<br>");
                out.println("Type: " + result.getString("type") + "<br>");
                out.println("Price: " + result.getDouble("price") + "<br>");
                out.println("Quantity: " + result.getInt("quantity") + "<br>");
                out.println("Availability: " + result.getString("availability") + "<br>");
                out.println("<form action='deleteDevice.jsp' method='post'>");
                out.println("<input type='hidden' name='name' value='" + name + "'>");
                out.println("<input type='hidden' name='type' value='" + type + "'>");
                out.println("<input type='hidden' name='confirmDelete' value='true'>");
                out.println("<input type='submit' value='Delete'>");
                out.println("</form>");
            } else {
                out.println("Device not found.");
            }

            conn.close();
        } catch (Exception ex) {
            out.println("Error: " + ex.getMessage());
        }
    } else {
        // Display search form if no parameters are provided
        out.println("<form action='deleteDevice.jsp' method='get'>");
        out.println("Name: <input type='text' name='name'><br>");
        out.println("Type: <input type='text' name='type'><br>");
        out.println("<input type='submit' value='Search'>");
        out.println("</form>");
    }
} else {
    // Part 2: Delete the device information
    String name = request.getParameter("name");
    String type = request.getParameter("type");

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection conn = DriverManager.getConnection(url, user, password);

        String sql = "DELETE FROM UNTITLED WHERE name = ? AND type = ?";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setString(1, name);
        statement.setString(2, type);

        int rowsDeleted = statement.executeUpdate();

        if (rowsDeleted > 0) {
            out.println("Device information deleted successfully.");
        } else {
            out.println("Error deleting device information.");
        }

        conn.close();
        
    } catch (Exception ex) {
        out.println("Error: " + ex.getMessage());
    }
}
%>
