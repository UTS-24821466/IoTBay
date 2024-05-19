<%@ page import="java.sql.*" %>
<%@ page import="java.util.UUID" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
String url = "jdbc:derby://localhost:1527/Device";
String user = "minh";
String password = "minh";

String name = request.getParameter("name");
String type = request.getParameter("type");
double price = Double.parseDouble(request.getParameter("price"));
int quantity = Integer.parseInt(request.getParameter("quantity"));
String availability = request.getParameter("availability");

try {
    Class.forName("org.apache.derby.jdbc.ClientDriver");
    Connection conn = DriverManager.getConnection(url, user, password);

    // Generate a random UUID
    String uuid = UUID.randomUUID().toString();

    // Extract numerical digits from the UUID and truncate to 8 characters
    String deviceID = uuid.replaceAll("\\D", "").substring(0, 8);

    String sql = "INSERT INTO UNTITLED (deviceID, name, type, price, quantity, availability) VALUES (?, ?, ?, ?, ?, ?)";
    PreparedStatement statement = conn.prepareStatement(sql);
    statement.setString(1, deviceID);
    statement.setString(2, name);
    statement.setString(3, type);
    statement.setDouble(4, price);
    statement.setInt(5, quantity);
    statement.setString(6, availability);

    int rowsInserted = statement.executeUpdate();
    if (rowsInserted > 0) {
        out.println("New record created successfully.");
    }

    conn.close();
    //response.sendRedirect("main.html");
} catch (Exception ex) {
    out.println("Error: " + ex.getMessage());
}
%>
