package config;

import java.sql.Connection;
import java.sql.DriverManager;

public class Conexion {

    Connection con;

    public Connection getConnection() {
        try {
            // Llama al driver que descargamos en el pom.xml
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 1. Leemos las variables de entorno (Render)
            String url = System.getenv("DB_URL");
            String usuario = System.getenv("DB_USER");
            String clave = System.getenv("DB_PASSWORD");

            // 2. Si las variables vienen vacías (estás en tu PC local), usamos las de XAMPP
            if (url == null) {
                url = "jdbc:mysql://localhost:3306/db_portafolio";
                usuario = "root";
                clave = "";
            }

            // 3. Nos conectamos usando los datos dinámicos
            con = DriverManager.getConnection(url, usuario, clave);
            System.out.println("¡Conexión exitosa a la base de datos!");

        } catch (Exception e) {
            System.out.println("Error fatal en la conexión: " + e.getMessage());
        }
        return con;
    }
}