package com.ejemplo.gestionusuarios.web.view;

import java.io.IOException;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * UsuarioUnoServlet
 * 2026 - wtl
 */
@WebServlet("/usuarios-uno")
public class UsuarioUnoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(UsuarioUnoServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("UsuarioUnoServlet.doGet()");

        request.getRequestDispatcher("/WEB-INF/views/usuarios-uno.jsp").forward(request, response);
    }
    
}