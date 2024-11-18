package storedProcedureTesting;

import org.apache.commons.lang3.StringUtils;
import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.sql.*;

public class SPTesting {

    Connection connect = null;

    @BeforeClass
    void setup() throws SQLException {
        connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/vin_online_shopping", "database name", "password");
    }

    @Test(priority = 1)
    void storedProcedureExists() throws SQLException {
        try (Statement stmt = connect.createStatement();
             ResultSet result = stmt.executeQuery("SHOW PROCEDURE STATUS WHERE Name = 'SelectAllCustomers'")) {
             Assert.assertTrue(result.next(), "Stored procedure not found");
             Assert.assertEquals(result.getString("Name"), "SelectAllCustomers", "Stored procedure name mismatch");
        }
    }

    @Test(priority = 2)
    void test_SelectAllCustomers() throws SQLException {
        try (CallableStatement callSPstmt = connect.prepareCall("{CALL SelectAllCustomers()}");
             ResultSet spResult = callSPstmt.executeQuery();
             Statement stmt = connect.createStatement();
             ResultSet sqlResult = stmt.executeQuery("SELECT * FROM customers")) {

            Assert.assertTrue(compareResultSets(spResult, sqlResult), "ResultSets do not match");
        }
    }

    @Test(priority = 3)
    void test_SelectAllCategories() throws SQLException {
        try (CallableStatement callSPstmt = connect.prepareCall("{CALL SelectAllCategories()}");
             ResultSet spResult = callSPstmt.executeQuery();
             Statement stmt = connect.createStatement();
             ResultSet sqlResult = stmt.executeQuery("SELECT * FROM categories")) {

            Assert.assertTrue(compareResultSets(spResult, sqlResult), "ResultSets do not match");
        }
    }

    @Test(priority = 4)
    void test_SelectAllProducts() throws SQLException {
        try (CallableStatement callSPstmt = connect.prepareCall("{CALL SelectAllProducts()}");
             ResultSet spResult = callSPstmt.executeQuery();
             Statement stmt = connect.createStatement();
             ResultSet sqlResult = stmt.executeQuery("SELECT * FROM products")) {

            Assert.assertTrue(compareResultSets(spResult, sqlResult), "ResultSets do not match");
        }
    }

    @Test(priority = 5)
    void test_SelectAllOrders() throws SQLException {
        try (CallableStatement callSPstmt = connect.prepareCall("{CALL SelectAllOrders()}");
             ResultSet spResult = callSPstmt.executeQuery();
             Statement stmt = connect.createStatement();
             ResultSet sqlResult = stmt.executeQuery("SELECT * FROM orders")) {

            Assert.assertTrue(compareResultSets(spResult, sqlResult), "ResultSets do not match");
        }
    }

    @Test(priority = 6)
    void test_SelectAllOrdedItems() throws SQLException {
        try (CallableStatement callSPstmt = connect.prepareCall("{CALL SelectAllOrdedItems()}");
             ResultSet spResult = callSPstmt.executeQuery();
             Statement stmt = connect.createStatement();
             ResultSet sqlResult = stmt.executeQuery("SELECT * FROM ordered_items")) {

            Assert.assertTrue(compareResultSets(spResult, sqlResult), "ResultSets do not match");
        }
    }

    @Test(priority = 7)
    void test_SelectAllPayments() throws SQLException {
        try (CallableStatement callSPstmt = connect.prepareCall("{CALL SelectAllPayments()}");
             ResultSet spResult = callSPstmt.executeQuery();
             Statement stmt = connect.createStatement();
             ResultSet sqlResult = stmt.executeQuery("SELECT * FROM payments")) {

            Assert.assertTrue(compareResultSets(spResult, sqlResult), "ResultSets do not match");
        }
    }

    @Test(priority = 8)
    void test_NumberOfColumns() throws SQLException {
        try (CallableStatement callSPstmt = connect.prepareCall("CALL NumberOfColumns(?)")) {
            callSPstmt.setString(1, "customers");
            try (ResultSet spResult = callSPstmt.executeQuery();
                 Statement stmt = connect.createStatement();
                 ResultSet sqlResult = stmt.executeQuery("SELECT count(*) AS NumberOfColumns FROM information_schema.columns WHERE table_name = 'customers'")) {

                Assert.assertTrue(compareResultSets(spResult, sqlResult), "Column count mismatch");
            }
        }
    }

    @Test(priority = 9)
    void test_column_names() throws SQLException {
        try (CallableStatement callSPstmt = connect.prepareCall("CALL column_names(?)")) {
            callSPstmt.setString(1, "customers");
            try (ResultSet spResult = callSPstmt.executeQuery();
                 Statement stmt = connect.createStatement();
                 ResultSet sqlResult = stmt.executeQuery("SELECT column_name FROM information_schema.columns WHERE table_name = 'customers'")) {

                Assert.assertTrue(compareResultSets(spResult, sqlResult), "Column count mismatch");
            }
        }
    }

    @Test(priority = 10)
    void test_datatypes() throws SQLException {
        try (CallableStatement callSPstmt = connect.prepareCall("CALL datatypes(?)")) {
            callSPstmt.setString(1, "customers");
            try (ResultSet spResult = callSPstmt.executeQuery();
                 Statement stmt = connect.createStatement();
                 ResultSet sqlResult = stmt.executeQuery("SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'customers'")) {

                Assert.assertTrue(compareResultSets(spResult, sqlResult), "Column count mismatch");
            }
        }
    }

    @Test(priority = 11)
    void test_colSize() throws SQLException {
        try (CallableStatement callSPstmt = connect.prepareCall("CALL colSize(?)")) {
            callSPstmt.setString(1, "customers");
            try (ResultSet spResult = callSPstmt.executeQuery();
                 Statement stmt = connect.createStatement();
                 ResultSet sqlResult = stmt.executeQuery("SELECT column_name, column_type FROM information_schema.columns WHERE table_name = 'customers'")) {

                Assert.assertTrue(compareResultSets(spResult, sqlResult), "Column count mismatch");
            }
        }
    }

    @Test(priority = 12)
    void test_nullFields() throws SQLException {
        try (CallableStatement callSPstmt = connect.prepareCall("CALL nullFields(?)")) {
            callSPstmt.setString(1, "customers");
            try (ResultSet spResult = callSPstmt.executeQuery();
                 Statement stmt = connect.createStatement();
                 ResultSet sqlResult = stmt.executeQuery("SELECT column_name, is_nullable FROM information_schema.columns WHERE table_name = 'customers'")) {

                Assert.assertTrue(compareResultSets(spResult, sqlResult), "Column count mismatch");
            }
        }
    }

    @Test(priority = 13)
    void test_column_keys() throws SQLException {
        try (CallableStatement callSPstmt = connect.prepareCall("CALL column_keys(?)")) {
            callSPstmt.setString(1, "customers");
            try (ResultSet spResult = callSPstmt.executeQuery();
                 Statement stmt = connect.createStatement();
                 ResultSet sqlResult = stmt.executeQuery("SELECT column_name, column_key FROM information_schema.columns WHERE table_name = 'customers'")) {

                Assert.assertTrue(compareResultSets(spResult, sqlResult), "Column count mismatch");
            }
        }
    }

    @AfterClass
    void tearDown() throws SQLException {
        if (connect != null) {
            connect.close();
        }
    }

    public boolean compareResultSets(ResultSet spResultSet, ResultSet sqlResultSet) throws SQLException {
        while (spResultSet.next()) {
            if (!sqlResultSet.next()) {
                return false; // spResultSet has more rows
            }

            int columnCount = spResultSet.getMetaData().getColumnCount();
            for (int i = 1; i <= columnCount; i++) {
                if (!StringUtils.equals(spResultSet.getString(i), sqlResultSet.getString(i))) {
                    return false; // Column mismatch
                }
            }
        }

        return !sqlResultSet.next(); // Ensure sqlResultSet doesn't have extra rows
    }
}
