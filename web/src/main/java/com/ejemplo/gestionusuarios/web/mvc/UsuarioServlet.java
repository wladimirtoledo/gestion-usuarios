package com.ejemplo.gestionusuarios.web.mvc;

import com.ejemplo.gestionusuarios.dto.UsuarioDTO;
import com.ejemplo.gestionusuarios.service.UsuarioServiceLocal;
import java.io.IOException;
import java.util.Date;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.logging.Logger;

/**
 * UsuarioServlet
 * 2026 - wtl
 * 
 */
@WebServlet("/usuarios")
public class UsuarioServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(UsuarioServlet.class.getName());

    @EJB
    private UsuarioServiceLocal usuarioService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("UsuarioServlet.doGet()");

        request.setAttribute("usuarios", usuarioService.listarUsuarios());
        request.getRequestDispatcher("/WEB-INF/views/usuarios.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("UsuarioServlet.doPost()");

        request.setCharacterEncoding("UTF-8");
        UsuarioDTO usuario = new UsuarioDTO();
        usuario.setNombre(request.getParameter("nombre")); // validar si viene null (maxlength)
        usuario.setEmail(request.getParameter("email")); //falta validación type=email
        usuario.setFechaCreacion(new Date());

        usuarioService.crearUsuario(usuario); 
        response.sendRedirect(request.getContextPath() + "/usuarios");
    }

}