package com.ejemplo.gestionusuarios.service;

import com.ejemplo.gestionusuarios.dto.UsuarioDTO;

import java.util.List;
import javax.ejb.Local;


/**
 * Wladimir Toledo - 2026
 * UsuarioServiceLocal
 * 
 */
@Local
public interface UsuarioServiceLocal {


    List<UsuarioDTO> listarUsuarios();

    void crearUsuario(UsuarioDTO usuario);

    boolean actualizarUsuario(UsuarioDTO usuario);

    boolean eliminarUsuario(Long id);

    
}