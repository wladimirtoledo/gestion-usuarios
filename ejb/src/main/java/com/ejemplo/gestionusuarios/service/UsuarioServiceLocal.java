package com.ejemplo.gestionusuarios.service;

import com.ejemplo.gestionusuarios.dto.UsuarioDTO;
import java.util.List;
import javax.ejb.Local;

@Local
public interface UsuarioServiceLocal {
    List<UsuarioDTO> listarUsuarios();

    void crearUsuario(UsuarioDTO usuario);
}