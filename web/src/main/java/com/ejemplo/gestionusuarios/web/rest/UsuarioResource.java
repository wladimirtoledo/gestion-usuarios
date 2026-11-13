package com.ejemplo.gestionusuarios.web.rest;

import com.ejemplo.gestionusuarios.dto.UsuarioDTO;
import com.ejemplo.gestionusuarios.service.UsuarioServiceLocal;
import com.ejemplo.gestionusuarios.web.view.UsuarioUnoServlet;

import java.util.Date;
import java.util.List;
import java.util.logging.Logger;
import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Path("/usuarios")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
@RequestScoped
public class UsuarioResource {
    @Inject
    private UsuarioServiceLocal usuarioService;

    private static final Logger LOGGER = Logger.getLogger(UsuarioResource.class.getName());

    @GET
    public List<UsuarioDTO> listar() {
        LOGGER.info("UsuarioResource.listar()");
        return usuarioService.listarUsuarios();
    }

    @POST
    public Response crear(UsuarioDTO usuario) {
        LOGGER.info("UsuarioResource.crear()");
        if (!normalizarYValidar(usuario)) {
            return error(Response.Status.BAD_REQUEST, "Nombre o correo no válido");
        }

        usuario.setFechaCreacion(new Date());
        usuarioService.crearUsuario(usuario);
        return Response.status(Response.Status.CREATED).build();
    }

    @PUT
    @Path("/{id}")
    public Response actualizar(@PathParam("id") Long id, UsuarioDTO usuario) {
        LOGGER.info("UsuarioResource.actualizar()");
        if (id == null || id < 1 || !normalizarYValidar(usuario)) {
            return error(Response.Status.BAD_REQUEST, "ID, nombre o correo no válido");
        }

        usuario.setId(id);
        if (!usuarioService.actualizarUsuario(usuario)) {
            return error(Response.Status.NOT_FOUND, "Usuario no encontrado");
        }
        return Response.noContent().build();
    }

    @DELETE
    @Path("/{id}")
    public Response eliminar(@PathParam("id") Long id) {
        LOGGER.info("UsuarioResource.eliminar()");
        if (id == null || id < 1) {
            //LOGGER.severe("UsuarioResource.eliminar(): ID no válido");
            return error(Response.Status.BAD_REQUEST, "ID no válido");
        }
        if (!usuarioService.eliminarUsuario(id)) {
            //LOGGER.severe("UsuarioResource.eliminar(): Usuario no encontrado");
            return error(Response.Status.NOT_FOUND, "Usuario no encontrado");
        }
        return Response.noContent().build();
    }

    private boolean normalizarYValidar(UsuarioDTO usuario) {
        LOGGER.info("UsuarioResource.normalizarYValidar()");
        if (usuario == null || usuario.getNombre() == null || usuario.getEmail() == null) {
            return false;
        }

        String nombre = usuario.getNombre().trim();
        String email = usuario.getEmail().trim();
        if (nombre.isEmpty() || nombre.length() > 150
                || email.length() > 254
                || !email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
            return false;
        }

        usuario.setNombre(nombre);
        usuario.setEmail(email);
        return true;
    }

    private Response error(Response.Status status, String message) {
        LOGGER.severe("UsuarioResource.error(): " + message);
        return Response.status(status)
                .type(MediaType.TEXT_PLAIN_TYPE)
                .entity(message)
                .build();
    }
}