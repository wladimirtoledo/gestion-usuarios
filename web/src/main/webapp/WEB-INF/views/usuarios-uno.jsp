
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Gestión de usuarios 2026</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
    
</head>

<body>
    <main>
        <h1>Gestión de usuarios 2026 (WTL) CRUD</h1>

        <section aria-labelledby="nuevo-usuario">
            <h2 id="nuevo-usuario">Nuevo usuario</h2>

            <form id="form-crear">
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

            <p id="mensaje" class="empty-message" role="status" aria-live="polite">Cargando usuarios...</p>
            <div class="table-container" id="tabla-container" hidden>
                <table>
                    <thead>
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">Nombre</th>
                            <th scope="col">Correo electrónico</th>
                            <th scope="col">Fecha de creación</th>
                            <th scope="col">Gestión</th>
                        </tr>
                    </thead>
                    <tbody id="usuarios-body"></tbody>
                </table>
            </div>
        </section>

    </main>

    <dialog id="modal-editar">
        <h3>Editar usuario</h3>
        <form id="form-editar">
            <input type="hidden" id="edit-id">
            <p>
                <label for="edit-nombre">Nuevo nombre</label>
                <input id="edit-nombre" name="nombre" type="text" maxlength="150" required>
            </p>
            <p>
                <label for="edit-email">Correo electrónico</label>
                <input id="edit-email" name="email" type="email" maxlength="254" required>
            </p>
            <div class="modal-botones">
                <button type="submit">Guardar cambios</button>
                <button type="button" class="btn-secondary" id="cancelar-edicion">Cancelar</button>
            </div>
        </form>
    </dialog>

    <script>
        const apiUrl = '${pageContext.request.contextPath}/api/usuarios';
        const formCrear = document.getElementById('form-crear');
        const formEditar = document.getElementById('form-editar');
        const modalEditar = document.getElementById('modal-editar');
        const tablaContainer = document.getElementById('tabla-container');
        const usuariosBody = document.getElementById('usuarios-body');
        const mensaje = document.getElementById('mensaje');

        function mostrarMensaje(texto) {
            mensaje.textContent = texto;
            mensaje.hidden = !texto;
        }

        function crearCelda(valor) {
            const celda = document.createElement('td');
            celda.textContent = valor == null ? '' : valor;
            return celda;
        }

        function crearBoton(texto, clase, accion) {
            const boton = document.createElement('button');
            boton.type = 'button';
            boton.className = clase;
            boton.textContent = texto;
            boton.addEventListener('click', accion);
            return boton;
        }

        function formatearFecha(valor) {
            if (!valor) {
                return '';
            }

            const fecha = new Date(String(valor).replace(/\[[^\]]+\]$/, ''));
            if (Number.isNaN(fecha.getTime())) {
                return '';
            }

            const dosDigitos = function (numero) {
                return String(numero).padStart(2, '0');
            };
            return dosDigitos(fecha.getDate()) + '/'
                + dosDigitos(fecha.getMonth() + 1) + '/'
                + fecha.getFullYear() + ' '
                + dosDigitos(fecha.getHours()) + ':'
                + dosDigitos(fecha.getMinutes());
        }

        function renderizarUsuarios(usuarios) {
            usuariosBody.replaceChildren();
            tablaContainer.hidden = usuarios.length === 0;
            mostrarMensaje(usuarios.length === 0 ? 'No hay usuarios registrados.' : '');

            usuarios.forEach(function (usuario) {
                const fila = document.createElement('tr');
                fila.appendChild(crearCelda(usuario.id));
                fila.appendChild(crearCelda(usuario.nombre));
                fila.appendChild(crearCelda(usuario.email));

                fila.appendChild(crearCelda(formatearFecha(usuario.fechaCreacion)));

                const celdaAcciones = document.createElement('td');
                const acciones = document.createElement('div');
                acciones.className = 'acciones';
                acciones.appendChild(crearBoton('Editar', 'btn-sm btn-secondary', function () {
                    document.getElementById('edit-id').value = usuario.id;
                    document.getElementById('edit-nombre').value = usuario.nombre;
                    document.getElementById('edit-email').value = usuario.email;
                    modalEditar.showModal();
                }));
                acciones.appendChild(crearBoton('Eliminar', 'btn-sm btn-danger', function () {
                    eliminarUsuario(usuario.id);
                }));
                celdaAcciones.appendChild(acciones);
                fila.appendChild(celdaAcciones);
                usuariosBody.appendChild(fila);
            });
        }

        async function comprobarRespuesta(respuesta) {
            if (!respuesta.ok) {
                const detalle = await respuesta.text();
                throw new Error(detalle || 'La solicitud no pudo completarse.');
            }
            return respuesta;
        }

        async function cargarUsuarios() {
            mostrarMensaje('Cargando usuarios...');
            tablaContainer.hidden = true;
            try {
                const respuesta = await comprobarRespuesta(await fetch(apiUrl));
                renderizarUsuarios(await respuesta.json());
            } catch (error) {
                mostrarMensaje(error.message);
            }
        }

        async function enviarUsuario(url, metodo, usuario) {
            await comprobarRespuesta(await fetch(url, {
                method: metodo,
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(usuario)
            }));
            await cargarUsuarios();
        }

        async function eliminarUsuario(id) {
            if (!window.confirm('¿Estás seguro de que deseas eliminar este usuario?')) {
                return;
            }
            try {
                await comprobarRespuesta(await fetch(apiUrl + '/' + encodeURIComponent(id), {
                    method: 'DELETE'
                }));
                await cargarUsuarios();
            } catch (error) {
                mostrarMensaje(error.message);
            }
        }

        formCrear.addEventListener('submit', async function (evento) {
            evento.preventDefault();
            try {
                await enviarUsuario(apiUrl, 'POST', {
                    nombre: formCrear.elements.nombre.value,
                    email: formCrear.elements.email.value
                });
                formCrear.reset();
            } catch (error) {
                mostrarMensaje(error.message);
            }
        });

        formEditar.addEventListener('submit', async function (evento) {
            evento.preventDefault();
            const id = document.getElementById('edit-id').value;
            try {
                await enviarUsuario(apiUrl + '/' + encodeURIComponent(id), 'PUT', {
                    nombre: formEditar.elements.nombre.value,
                    email: formEditar.elements.email.value
                });
                modalEditar.close();
            } catch (error) {
                mostrarMensaje(error.message);
            }
        });

        document.getElementById('cancelar-edicion').addEventListener('click', function () {
            modalEditar.close();
        });

        cargarUsuarios();

    </script>

</body>
</html>
