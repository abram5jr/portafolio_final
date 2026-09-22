package config;

import java.sql.Connection;
import java.sql.DriverManager;

public class Conexion {
    
    Connection con;
    
    public Connection getConnection() {
        try {
            // Llama al traductor que descargamos en el pom.xml
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Se conecta a tu XAMPP (localhost puerto 3306) a la base de datos db_portafolio
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_portafolio", "root", "");
            System.out.println("¡Conexión exitosa a la base de datos!");
            
        } catch (Exception e) {
            System.out.println("Error fatal en la conexión: " + e.getMessage());
        }
        return con;
    }
}