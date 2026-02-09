package es.gob.extranjeria.repository;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import es.gob.extranjeria.model.Usuario;

public interface UsuarioRepository extends JpaRepository<Usuario,Long > {
    Optional<Usuario> findByUsername(String username);
}
