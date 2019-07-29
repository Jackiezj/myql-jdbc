package JDBC;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * JDBC入门案例
 */
public class JDBCDemo {
    public static void main(String[] args) throws Exception {
        // 注册驱动
        Class.forName("com.mysql.jdbc.Driver");
        // 获取连接对象
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/testdb", "root", "root");
        // 定义sql
        String sql = "select * from dept where id = ?";
        // 获取执行sql的对象
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        // 给sql中参数赋值
        preparedStatement.setInt(1, 1);
        // 获取结果集
        ResultSet resultSet = preparedStatement.executeQuery();
        // 遍历结果集
        while (resultSet.next()) {
            String dname = resultSet.getString("dname");
            String loc = resultSet.getString("loc");
            System.out.println(dname + ": " + loc);
        }
        // 关闭资源
        resultSet.close();
        preparedStatement.close();
        connection.close();
    }


}
