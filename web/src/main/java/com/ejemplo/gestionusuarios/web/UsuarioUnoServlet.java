package com.ejemplo.gestionusuarios.web;

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

@WebServlet("/usuarios-uno")
public class UsuarioUnoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @EJB
    private UsuarioServiceLocal usuarioService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("usuarios", usuarioService.listarUsuarios());
        request.getRequestDispatcher("/WEB-INF/views/usuarios-uno.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        UsuarioDTO usuario = new UsuarioDTO();
        usuario.setNombre(request.getParameter("nombre"));
        usuario.setEmail(request.getParameter("email"));
        usuario.setFechaCreacion(new Date());

        usuarioService.crearUsuario(usuario);
        response.sendRedirect(request.getContextPath() + "/usuarios-uno");
    }
}