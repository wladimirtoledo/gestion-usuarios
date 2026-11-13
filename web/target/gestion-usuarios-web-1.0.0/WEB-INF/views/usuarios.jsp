
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Gestión de usuarios 2026</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
    <!-- style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f1f5f9;
            color: #334155;
            min-height: 100vh;
            padding: 40px 20px;
        }

        main {
            max-width: 1100px;
            margin: 0 auto;
        }

        h1 {
            color: #1e293b;
            font-size: 30px;
            margin-bottom: 30px;
            font-weight: 700;
        }

        h2 {
            font-size: 19px;
            color: #1e293b;
            margin-bottom: 25px;
        }

        section {
            background: #ffffff;
            padding: 30px;
            border-radius: 12px;
            margin-bottom: 25px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.04);
            border: 1px solid #e2e8f0;
        }

        form p {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 8px;
            color: #475569;
        }

        input {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 7px;
            font-size: 14px;
            color: #334155;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        input:focus {
            outline: none;
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.12);
        }

        button {
            background: #2563eb;
            color: white;
            border: none;
            padding: 12px 22px;
            border-radius: 7px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s, transform 0.2s;
        }

        button:hover {
            background: #1d4ed8;
            transform: translateY(-1px);
        }

        .table-container {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
            white-space: nowrap;
        }

        thead {
            background: #f1f5f9;
        }

        th {
            color: #475569;
            font-weight: 600;
            text-align: left;
            padding: 15px;
            border-bottom: 2px solid #e2e8f0;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #e2e8f0;
            color: #475569;
        }

        tbody tr:nth-child(even) {
            background: #f8fafc;
        }

        tbody tr:hover {
            background: #eff6ff;
        }

        .empty-message {
            padding: 20px;
            background: #f8fafc;
            border-radius: 8px;
            color: #64748b;
            font-size: 14px;
            text-align: center;
        }

        @media (max-width: 600px) {
            body {
                padding: 20px 12px;
            }

            h1 {
                font-size: 24px;
            }

            section {
                padding: 20px 15px;
            }

            button {
                width: 100%;
            }
        }
    </style -->
</head>

<body>
    <main>
        <h1>Gestión de usuarios 2026 (WTL)</h1>

        <section aria-labelledby="nuevo-usuario">
            <h2 id="nuevo-usuario">Nuevo usuario</h2>

            <form method="post" action="${pageContext.request.contextPath}/usuarios">
                <p>
                    <label for="nombre">Nombre</label>
                    <input id="nombre" name="nombre" type="text" maxlength="150" placeholder="Ingrese el nombre completo" required>
                </p>

                <p>
                    <label for="email">Correo electrónico</label>
                    <input id="email" name="email" type="email" maxlength="254" placeholder="ejemplo@correo.com" required>
                </p>
                <button type="submit">Crear usuario</button>
            </form>
        </section>

        <section aria-labelledby="lista-usuarios">
            <h2 id="lista-usuarios">Usuarios registrados</h2>

            <c:choose>
                <c:when test="${empty usuarios}">
                    <p class="empty-message">No hay usuarios registrados.</p>
                </c:when>

                <c:otherwise>
                    <div class="table-container">
                        <table>
                            <thead>
                                <tr>
                                    <th scope="col">ID</th>
                                    <th scope="col">Nombre</th>
                                    <th scope="col">Correo electrónico</th>
                                    <th scope="col">Fecha de creación</th>
                                </tr>
                            </thead>

                            <tbody>
                                <c:forEach var="usuario" items="${usuarios}">
                                    <tr>
                                        <td><c:out value="${usuario.id}" /></td>
                                        <td><c:out value="${usuario.nombre}" /></td>
                                        <td><c:out value="${usuario.email}" /></td>
                                        <td><c:out value="${usuario.fechaCreacion}" /></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </section>
    </main>

</body>
</html>
