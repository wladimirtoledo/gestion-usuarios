## Se requiere  implementar un capa web y de servicio para un modulo de gestion de usuarios.

la solución debe seguir una arquitectura MVC desacoplada. la capa web (servlet/jsp) no debe conocer detalles de la base de datos ni interactuar con objetos de persistencia directa; la transferancia de datos entrte la capa web y la capa de EJB se realiza obligatoriamente mediante un objeto DTO o value Object. la solución debe estar implementada con maven en tres tipos de proyectos EAR, EJB y WEB. la base de datos puede ser simulada y el proyecto deberia poder funcionar en wildfly 26.

Requisitos tecnicos obligatorios:
1. Patrón DTO
-crear la clase UsuarioDTO con los campos id (Long), nombre (String), email (String) y fechaCreacion (java.util.Date).
2. Capa EJB y JDBC seguro
-crear un session bean stateless (@Stateless) que implemente una interfaz local (@Local)
-inyectar DataSource configurado en el servidor Woldfly usando @Resourse(lookup = "java:/jdbc/MiDataSource").
-realizar las operaciones JDBC garantizando la seguridad contra SQL Injection mediante PreparedStatement y marcadores ?.
-asegurar la liberacion de recursos JDBC (Connection, PreparedStatement, ResultSet) utilizando el bloque try-with-resources de java 8
3. Capa Web - Controlador (Servlet)
-implementar UsuarioServlet mapeando en /usuarios
-inyectar el ejb mediante @EJB 
-en doGet: invocar al EJB, obtener la lista de DTOs, asignarla como atributo del HttpServletRequest y despachar el flujo a la vista mediante forward
-en doPost: leer las entradas del formulario, instanciar un UsuarioDTO, enviarlo al EJB y finalizar aplicando el patron Post/Redirect/Get (sendRedirect)
4. capa web - vista (jsp + jstl)
-crear la pagina en /web-inf/views/usuarios.jsp
-renderizar el formulario y la tabla de resultados haciendo uso exlusivo del jstl (<c:choose>, <c:forEach>, <c:out>) y Expression Language ${}
-prohibicion estricta: no se permite el uso de scriptlets Java (<% %>)



MVC → UsuarioServlet; (Controller)
REST → UsuarioResource; 
servicio de negocio compartido → EJB.


PowerShell:
& 'C:\wildfly-26.1.3.Final\bin\standalone.bat' '-Djboss.socket.binding.port-offset=100'

Cuando arranque:
& 'C:\wildfly-26.1.3.Final\bin\jboss-cli.bat' --controller=localhost:10090 --connect --command='deploy "C:\wamp64\www\gestion-usuarios\ear\target\gestion-usuarios-ear-1.0.0.ear" --force'

Ejercicio práctico de código (Solicitado)
http://localhost:8180/gestion-usuarios/usuarios

Ejercicio práctico de código (Mejorado CRUD Api-Rest)
http://localhost:8180/gestion-usuarios/usuarios-uno
http://localhost:8180/gestion-usuarios/api/usuarios


{
  "nombre": "Ana PPérez",
  "email": "aaana@example.com"
}


$env:JAVA_HOME = 'C:\Program Files\Java\jdk-21.0.11'
Set-Location 'C:\wamp64\www\gestion-usuarios'
mvn clean package
if ($LASTEXITCODE -eq 0) {
    & 'C:\wildfly-26.1.3.Final\bin\jboss-cli.bat' --controller=localhost:10090 --connect --command='deploy "C:\wamp64\www\gestion-usuarios\ear\target\gestion-usuarios-ear-1.0.0.ear" --force'
}




Wladimir Toledo León

